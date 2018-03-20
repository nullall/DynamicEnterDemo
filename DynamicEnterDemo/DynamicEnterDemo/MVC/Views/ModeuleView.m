//
//  ModeuleView.m
//  DynamicEnterDemo
//
//  Created by Da.W on 2018/3/6.
//  Copyright © 2018年 daw. All rights reserved.
//

#import "ModeuleView.h"
#import "ModuleButton.h"

@interface ModeuleView()<UIScrollViewDelegate>{
    CGFloat btnWidth;
    CGFloat btnHeight;
}

@end

@implementation ModeuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    self.backgroundColor=[UIColor whiteColor];
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-37)];
    self.scrollView.pagingEnabled=YES;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.delegate=self;
    [self addSubview:self.scrollView];
    
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-37, self.frame.size.width, 37)];
    self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor=[UIColor blackColor];
    [self addSubview:self.pageControl];
    
//    if (!self.colNum) {
//        self.colNum=4;
//    }
//    if (!self.rowNum) {
//        self.rowNum=3;
//    }
}

-(void)setModuleArray:(NSMutableArray *)moduleArray{
    _moduleArray=moduleArray;
    [self initModule];
}

-(void)setColNum:(int)colNum{
    _colNum=colNum;
    [self initModule];
}

-(void)setRowNum:(int)rowNum{
    _rowNum=rowNum;
    [self initModule];
}

-(void)setViewController:(UIViewController *)viewController{
    _viewController=viewController;
    [self initModule];
}

#pragma mark - 绘制模块

/**
 初始化模块入口
 */
-(void)initModule{
    if (!self.colNum||!self.rowNum||!self.moduleArray||!self.viewController) {
        return;
    }
    btnWidth=screenWidth/self.colNum;
    btnHeight=self.scrollView.height/self.rowNum;
    
    int amount=self.rowNum*self.colNum;
    
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
    CGFloat x = (index%self.colNum)*btnWidth;
    CGFloat y = ((index/self.colNum)%self.rowNum)*btnHeight;
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
    
    [self.viewController.navigationController pushViewController:controller animated:YES];
}

#pragma mark - scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.scrollView.contentOffset.x/screenWidth;
}

@end
