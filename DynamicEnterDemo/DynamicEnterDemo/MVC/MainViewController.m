//
//  MainViewController.m
//  DynamicEnterDemo
//
//  Created by Da.W on 2018/2/7.
//  Copyright © 2018年 daw. All rights reserved.
//

#import "MainViewController.h"
#import "ModuleCollectionViewCell.h"
#import "ModuleModel.h"

@interface MainViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *moduleCollectionView;
@property (strong, nonatomic) NSArray *moduleArray;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initView{
    self.moduleArray=[NSArray array];
    
//    self.navigationItem.title=@"主页1";
//    self.navigationController.navigationBarHidden=NO;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    flowLayout.minimumInteritemSpacing = 0;
    //最小两行之间的间距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.moduleCollectionView setCollectionViewLayout:flowLayout];
    self.moduleCollectionView.delegate=self;
    self.moduleCollectionView.dataSource=self;
    //这种是xib建的cell 需要这么注册
    UINib *cellNib=[UINib nibWithNibName:@"ModuleCollectionViewCell" bundle:nil];
    [self.moduleCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"ModuleCollectionViewCell"];
    
    [self requestModules];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.moduleArray.count;
}

//每一个cell是什么
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ModuleCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ModuleCollectionViewCell" forIndexPath:indexPath];
    cell.model=self.moduleArray[indexPath.item];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ModuleModel *model = self.moduleArray[indexPath.item];
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


//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(screenWidth/4, 100);
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
            [self.moduleCollectionView reloadData];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"加载出错"];
    }];
}

@end
