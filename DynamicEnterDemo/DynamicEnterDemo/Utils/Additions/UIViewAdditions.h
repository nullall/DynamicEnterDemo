//
//  UIViewAdditions.h
//  LaShouCommunity
//
//  Created by wanyueming on 09-11-27.
//  Copyright 2009 ___LASHOU-INC___. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    isTop = 10,
    isMid,
    isBottom,
    isSingle
}CellAtTableViewType;

@interface UIView (UIView)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;

@property(nonatomic,readonly) CGFloat orientationWidth;
@property(nonatomic,readonly) CGFloat orientationHeight;

@property (nonatomic, retain) NSObject *attachment; //在视图中附加一个绑定数据

- (void)removeSubviews;
- (CGPoint)centerOfFrame;
- (CGPoint)centerOfBounds;
+ (void) drawRoundRectangleInRect:(CGRect)rect
                        fillColor:(UIColor*)fillColor
                      strokeColor:(UIColor *)strokeColor
                      borderWidth:(CGFloat)borderWidth
                       whitchCell:(CellAtTableViewType)type;

@end
