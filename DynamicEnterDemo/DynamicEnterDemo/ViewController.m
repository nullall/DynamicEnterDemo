//
//  ViewController.m
//  DynamicEnterDemo
//
//  Created by Da.W on 2018/2/7.
//  Copyright © 2018年 daw. All rights reserved.
//

#import "ViewController.h"
#import "MainTabBarVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MainTabBarVC *vc=[[MainTabBarVC alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
