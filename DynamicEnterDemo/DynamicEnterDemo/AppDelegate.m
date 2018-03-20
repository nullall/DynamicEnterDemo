//
//  AppDelegate.m
//  DynamicEnterDemo
//
//  Created by Da.W on 2018/2/7.
//  Copyright © 2018年 daw. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "Main2ViewController.h"
#import "MainTabBarVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface AppDelegate ()
@property (strong, nonatomic) UIView *lunchView;
@end

@implementation AppDelegate
@synthesize lunchView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController=[[MainTabBarVC alloc]init];
    
//    [self.window makeKeyAndVisible];
//    
//    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
//    lunchView = viewController.view;
//    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
//    lunchView.frame = [UIApplication sharedApplication].keyWindow.frame;
//    [mainWindow addSubview:lunchView];
//    
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:lunchView.frame];
//    //图片地址可以通过推送获取保存到本地
//    NSString *str = @"http://127.0.0.1/banner/ad01.jpg";
//    [imageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"bannerFailed"]];
//    [lunchView addSubview:imageV];
//    
//    [self.window bringSubviewToFront:lunchView];
//    
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];
    return YES;
}

-(void)removeLun
{
    [lunchView removeFromSuperview];
}

//-(void)load{
//    //获取LaunchScreen.storyborad
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Launch Screen" bundle:nil];
//
//    //通过使用storyborardID去获取启动页viewcontroller
//    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"LaunchScreen"];
//
//    //获取viewController的视图
//    self.view = viewController.view;
//
//    //把视图添加到window
//    [self.window addSubview:self.view];
//    self.launchView = [[UIImageView alloc] initWithFrame:self.window.frame];
//    [self.launchView setImage:[UIImage imageNamed:@"launch.jpg"]];//这边图片可以做网络请求加载图片、视频动画或者其他自定义的引导页
//    [self.view addSubview:self.launchView];
//    //将图片视图推送到前面
//    [self.window bringSubviewToFront:self.launchView];
//
//    //设置3秒定时触发
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(colseLaunchScreen) userInfo:nil repeats:NO];
//
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
