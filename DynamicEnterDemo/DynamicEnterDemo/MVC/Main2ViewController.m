//
//  Main2ViewController.m
//  DynamicEnterDemo
//
//  Created by Da.W on 2018/2/8.
//  Copyright © 2018年 daw. All rights reserved.
//

#import "Main2ViewController.h"
#import "ModuleButton.h"
#import "ModuleModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "BannerView.h"

@interface Main2ViewController ()<UIScrollViewDelegate>{
    int rowNum;     //行数
    int colNum;  //列数
    CGFloat btnWidth;
    CGFloat btnHeight;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSArray *moduleArray;
@property (strong, nonatomic) NSMutableArray *bannerArray;

@end

@implementation Main2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self requestModules];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initView{
//    self.navigationItem.title=@"主页";
    self.navigationController.navigationBarHidden=YES;
    self.scrollView.delegate=self;
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
//    NSMutableArray *urlArray =[[NSMutableArray alloc]initWithObjects:@"http://123.159.193.22:8836/uploadfiles/carouselpicture/1516950719072.jpg",
//                               @"http://123.159.193.22:8836/uploadfiles/carouselpicture/1516951027306.jpg",
//                               @"http://123.159.193.22:8836/uploadfiles/carouselpicture/1517195052916.jpg",
//                               @"http://123.159.193.22:8836/uploadfiles/carouselpicture/1517195030963.jpeg",
//                               @"http://123.159.193.22:8836/uploadfiles/carouselpicture/1517195030963.jpg",
//                               @"http://123.159.193.22:8836/uploadfiles/carouselpicture/1517448840447.jpg",
//                               @"http://123.159.193.22:8836/uploadfiles/carouselpicture/1517448934619.jpg",nil];
    
    BannerView *bannerV =[[BannerView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 200)];
    bannerV.failedImage=@"bannerFailed";
    bannerV.imageUrlArray=self.bannerArray;
    [self.bannerView addSubview:bannerV];
}

#pragma mark - 绘制模块

/**
 初始化模块入口
 */
-(void)initModule{
    rowNum=3;
    colNum=4;
    btnWidth=screenWidth/colNum;
    btnHeight=self.scrollView.height/rowNum;
    
    int amount=rowNum*colNum;
    
    int pageNum = self.moduleArray.count/amount+1;
    [self.scrollView setContentSize:CGSizeMake(screenWidth*pageNum, self.scrollView.height)];
    self.pageControl.numberOfPages=pageNum;
    for (int i=0; i<pageNum; i++) {
        UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(screenWidth*i, 0, screenWidth, self.scrollView.height)];
        [self.scrollView addSubview:btnView];
        
        //添加按钮们
        for (int j=amount*i; j<MIN(amount*(i+1), self.moduleArray.count); j++) {
            [btnView addSubview:[self drawButtonAt:j]];
        }
    }
}


/**
 绘制按钮

 @param index 按钮所在数组的位置
 @return 按钮
 */
-(ModuleButton*)drawButtonAt:(int)index{
    CGFloat x = (index%colNum)*btnWidth;
    CGFloat y = ((index/colNum)%rowNum)*btnHeight;
    ModuleButton *mBtn=[[ModuleButton alloc]initWithFrame:CGRectMake(x, y, btnWidth, btnHeight)];
    
    ModuleModel *model = self.moduleArray[index];
    mBtn.model=model;
    [mBtn setTag:index];
    [mBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return mBtn;
}


/**
 按钮点击事件
 */
-(void)btnAction:(id)sender{
    ModuleButton *btn = (ModuleButton*)sender;
    ModuleModel *model = self.moduleArray[btn.tag];
    
    [self enterModule:model.className];
    
}


/**
 进入功能模块

 @param className 模块类名
 */
-(void)enterModule:(NSString*)className{
    Class c =NSClassFromString(className);
    UIViewController *controller;
    
#if __has_feature(objc_arc)
    
    controller = [[c alloc]init];
    
#else
    
    controller = [[[c alloc] init] autorelease];
    
#endif
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.scrollView.contentOffset.x/screenWidth;
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
            [self initModule];
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
