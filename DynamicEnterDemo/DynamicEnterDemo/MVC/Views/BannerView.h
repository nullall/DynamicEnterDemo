//
//  BannerView.h
//  BannerDemo
//
//  Created by Da.W on 2018/1/30.
//  Copyright © 2018年 daw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerView : UIView

/**
 imageview数组
 */
@property(nonatomic, strong) NSMutableArray *imageViewArray;

/**
 图片地址数组
 */
@property(nonatomic, strong) NSMutableArray *imageUrlArray;

/**
 图片数组
 */
@property(nonatomic, strong) NSMutableArray *imageArray;

/**
 用图片地址加载时，加载失败后默认显示的图片,得在设置url数组前设置才能奏效
 */
@property(nonatomic, strong) NSString *failedImage;

/**
 页面小圆点
 */
@property (strong ,nonatomic) UIPageControl *pageControl;

/**
 放轮播图的scrollView
 */
@property (strong ,nonatomic) UIScrollView *scrollView;
@end
