//
//  Main3ViewController.m
//  DynamicEnterDemo
//
//  Created by Da.W on 2018/3/9.
//  Copyright © 2018年 daw. All rights reserved.
//

#import "Main3ViewController.h"
#import "BannerView.h"
#import "ModeuleView.h"
#import "ModuleModel.h"

@interface Main3ViewController ()
@property (strong, nonatomic) NSArray *moduleArray;
@property (strong, nonatomic) NSMutableArray *bannerArray;
@end

@implementation Main3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestModules];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


#pragma mark - 绘制轮播图
/**
 用URL加载
 */
-(void)bannerLoadWithUrl{
    BannerView *bannerV =[[BannerView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 200)];
    bannerV.failedImage=@"bannerFailed";
    bannerV.imageUrlArray=self.bannerArray;
    [self.view addSubview:bannerV];
}

#pragma mark - 绘制模块入口

-(void)initModuleView{
    ModeuleView *moduleView = [[ModeuleView alloc]initWithFrame:CGRectMake(0, 210, screenWidth, 240+37)];
    moduleView.rowNum=3;
    moduleView.colNum=4;
    moduleView.moduleArray=self.moduleArray;
    moduleView.viewController=self;
    [self.view addSubview:moduleView];
}

#pragma mark - 请求数据
-(void)requestModules{
    [XIIHttpRequest getWithURL:ModuleAdd params:nil showHud:YES success:^(id json) {
        NSString *sourceData = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        NSLog(@"sourceData======>%@",sourceData);
        NSError* error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:&error];
        NSArray *founctions = [dic objectForKey:@"founctions"];
        if (founctions.count>0) {
            self.moduleArray=[ModuleModel mj_objectArrayWithKeyValuesArray:founctions];
            [self initModuleView];
        }
        NSArray *banners = [dic objectForKey:@"banners"];
        if (banners.count>0) {
            self.bannerArray=[[NSMutableArray alloc]init];
            for (NSDictionary *url in banners) {
                [self.bannerArray addObject:[url objectForKey:@"url"]];
            }
            [self bannerLoadWithUrl];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"加载出错"];
    }];
}
@end
