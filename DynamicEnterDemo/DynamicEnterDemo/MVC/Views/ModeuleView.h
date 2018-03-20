//
//  ModeuleView.h
//  DynamicEnterDemo
//
//  Created by Da.W on 2018/3/6.
//  Copyright © 2018年 daw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModeuleView : UIView
/**
 列一下属性：
 
 页面高宽
 按钮信息数组
 
 */


/**
 模块数组
 */
@property (nonatomic,strong)NSArray *moduleArray;

/**
 放按钮的scrollView
 */
@property (nonatomic,strong)UIScrollView *scrollView;

/**
 页码提示
 */
@property (nonatomic,strong)UIPageControl *pageControl;

/**
 行数
 */
@property (nonatomic,assign)int rowNum;

/**
 列数
 */
@property (nonatomic,assign)int colNum;

/**
 传入的VC
 */
@property (nonatomic,weak)UIViewController *viewController;

@end
