//
//  MainTabBarVC.m
//  iecmanager
//
//  Created by Da.W on 16/11/11.
//  Copyright © 2016年 chuangli. All rights reserved.
//

#import "MainTabBarVC.h"
#import "MainViewController.h"
#import "Main2ViewController.h"
#import "Main3ViewController.h"

#import <SDWebImage/SDWebImageManager.h>

@interface MainTabBarVC (){
    UIColor *themeColor;
}

@end

@implementation MainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupAllChildViewControllers];
    [self requestModules];
    [self setupVC];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupVC{
    NSString *colorStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"themeColor"];
    if (colorStr) {
        themeColor = [UIColor colorWithHexString:colorStr];
    }
    NSArray *tabbar = [[NSUserDefaults standardUserDefaults] objectForKey:@"tabbar"];
    if (tabbar.count>0) {
        for (NSDictionary *dic in tabbar) {
            [self setupChildVCWithDic:dic];
        }
        return;
    }
    Main2ViewController *M2V=[[Main2ViewController alloc]init];
    M2V.tabBarItem.title=@"主页2";
    BaseNavigationController *NCM2V=[[BaseNavigationController alloc]initWithRootViewController:M2V];
    NCM2V.navigationBarHidden=YES;//有需要的话 对navigationbar进行隐藏
    M2V.title=@"主页2";
    [M2V.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x929292),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [M2V.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x2d3c54),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    MainViewController *M1V=[[MainViewController alloc]init];
    M1V.tabBarItem.title=@"主页11";
    BaseNavigationController *NCM1V=[[BaseNavigationController alloc]initWithRootViewController:M1V];
    M1V.title=@"主页1";
    [M1V.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x929292),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [M1V.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x2d3c54),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    
    
    
    //tabbar的背景颜色
    self.tabBar.barTintColor=RGBA(250, 250, 250, 1);
    
    self.viewControllers=@[NCM2V,NCM1V];
}



/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
//    NSArray *titles = @[@"首页", @"论坛", @"发现", @"我的"];
//    NSArray *imageNames = @[@"tab_news", @"tab_forum", @"tab_selectCar", @"tab_mySpace"];
    
//    for (int i = 0; i < 4; i++) {
//        NSString *imageName = [imageNames[i] stringByAppendingString:@"_normal"];
//        NSString *selectedImageName = [imageNames[i] stringByAppendingString:@"_highlighted"];
//        ViewController *homeCtrl = [[ViewController alloc] init];
//        [self setupChildViewController:homeCtrl title:titles[i] imageName:imageName selectedImageName:selectedImageName];
//    }
    [self setupChildViewController:[[Main2ViewController alloc]init] title:@"主页2" imageName:@"" selectedImageName:@""];
    [self setupChildViewController:[[MainViewController alloc]init] title:@"主页1" imageName:@"" selectedImageName:@""];
    [self setupChildViewController:[[Main3ViewController alloc]init] title:@"主页3" imageName:@"" selectedImageName:@""];
}

/**
 * 初始化子控制器
 */
- (void)setupChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置文字
    vc.title = title;
    vc.tabBarItem.title = title;
    //    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    // 设置普通状态下图片
    UIImage *normalImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = normalImage;
    
    // 设置选中状态下图片
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selectedImage;
    
    // 包装一个导航控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
//    nav.delegate=self;
    [self addChildViewController:nav];
}


/**
 * 初始化子控制器
 */
- (void)setupChildVCWithDic:(NSDictionary *)dic{
    NSString *className=[dic objectForKey:@"className"];
    NSString *title=[dic objectForKey:@"title"];
    NSString *iconUrl=[dic objectForKey:@"iconUrl"];
    NSString *iconSelectedUrl=[dic objectForKey:@"iconSelectedUrl"];
    NSString *textNormalColor=[dic objectForKey:@"textNormalColor"];
    NSString *textSelectedColor=[dic objectForKey:@"textSelectedColor"];
    
    Class c =NSClassFromString(className);
    UIViewController *controller;
#if __has_feature(objc_arc)
    controller = [[c alloc]init];
#else
    controller = [[[c alloc] init] autorelease];
#endif
    
    // 设置文字
    controller.title = title;
    controller.tabBarItem.title = title;
    //    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    // 设置普通状态下图片
    controller.tabBarItem.image = [[UIImage imageNamed:@"failedicon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:@"failedicon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //使用SDWebImage来下载及缓存
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:iconUrl] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (!error && finished) {
            controller.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }];

    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:iconSelectedUrl] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (!error && finished) {
            controller.tabBarItem.selectedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }];
    
    //设置字的颜色
    [controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:textNormalColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:textSelectedColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    // 包装一个导航控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    if (themeColor) {
        nav.navigationBar.barTintColor=themeColor;
    }
    //    nav.delegate=self;
    [self addChildViewController:nav];
}



#pragma mark - 请求数据
-(void)requestModules{
    [XIIHttpRequest getWithURL:TabbarAdd params:nil showHud:NO success:^(id json) {
        NSString *sourceData = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        NSLog(@"sourceData======>%@",sourceData);
        NSError* error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:&error];
        NSArray *tabbar = [dic objectForKey:@"tabbar"];
        [[NSUserDefaults standardUserDefaults]setObject:tabbar forKey:@"tabbar"];
        if ([dic objectForKey:@"themeColor"]) {
            NSString *colorStr=[dic objectForKey:@"themeColor"];
            [[NSUserDefaults standardUserDefaults]setObject:colorStr forKey:@"themeColor"];
        }
//        for (NSDictionary *dic in tabbar) {
//            [self setupChildVCWithDic:dic];
//        }
        
    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"加载出错"];
    }];
}

@end
