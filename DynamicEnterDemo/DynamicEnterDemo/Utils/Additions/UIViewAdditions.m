//
//  UIViewAdditions.m
//  LaShouCommunity
//
//  Created by wanyueming on 09-11-27.
//  Copyright 2009 ___LASHOU-INC___. All rights reserved.
//

#import "UIViewAdditions.h"
#import <objc/runtime.h>

@implementation UIView (UIView)
/*
UIInterfaceOrientation TTDeviceOrientation() {
    
    UIInterfaceOrientation orient = UIInterfaceOrientationPortrait;
    
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationPortrait:
            orient = UIInterfaceOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orient = UIInterfaceOrientationPortraitUpsideDown;
            break;
        case UIDeviceOrientationLandscapeLeft:
            orient = UIInterfaceOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationLandscapeRight:
            orient = UIInterfaceOrientationLandscapeRight;
            break;
        default:
            break;
    }
    
    return orient;
}
*/
- (void)removeSubviews {
	while (self.subviews.count) {
		UIView* child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)top {
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
	CGRect frame = self.frame;
	frame.origin.x = right - frame.size.width;
	self.frame = frame;
}

- (CGFloat)bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
	CGRect frame = self.frame;
	frame.origin.y = bottom - frame.size.height;
	self.frame = frame;
}

- (CGFloat)centerX {
	return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
	self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
	return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
	self.center = CGPointMake(self.center.x, centerY);
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)screenX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
	}
	return x;
}

- (CGFloat)screenY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
	}
	return y;
}

- (CGFloat)screenViewX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			x -= scrollView.contentOffset.x;
		}
	}
	
	return x;
}

- (CGFloat)screenViewY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			y -= scrollView.contentOffset.y;
		}
	}
	return y;
}

- (CGRect)screenFrame {
	return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)offsetFromView:(UIView*)otherView {
	CGFloat x = 0, y = 0;
	for (UIView* view = self; view && view != otherView; view = view.superview) {
		x += view.left;
		y += view.top;
	}
	return CGPointMake(x, y);
}

- (CGFloat)orientationWidth {
	return UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)
    ? self.height : self.width;
}

- (CGFloat)orientationHeight {
	return UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)
    ? self.width : self.height;
}

- (CGPoint)centerOfFrame {
	CGRect rect = self.frame;
	return CGPointMake(rect.origin.x + rect.size.width / 2.0f,
					   rect.origin.y + rect.size.height / 2.0f);
}

- (CGPoint)centerOfBounds {
	CGRect rect = self.bounds;
	return CGPointMake(rect.origin.x + rect.size.width / 2.0f,
					   rect.origin.y + rect.size.height / 2.0f);
}

- (NSObject *)attachment {
    return objc_getAssociatedObject(self, @"kViewAttachment");
}

- (void)setAttachment:(NSObject *)attachment {
    objc_setAssociatedObject(self, @"kViewAttachment",nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (attachment) {
        objc_setAssociatedObject(self, @"kViewAttachment",attachment, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

//画圆角Cell  ——待修改加入了Cell的不同种类，上，中，下
+ (void) drawRoundRectangleInRect:(CGRect)rect
                        fillColor:(UIColor*)fillColor
                      strokeColor:(UIColor *)strokeColor
                      borderWidth:(CGFloat)borderWidth
                       whitchCell:(CellAtTableViewType)type {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[fillColor setFill];
    [strokeColor setStroke];
	
    CGContextSetAllowsAntialiasing(context,true);
    CGContextSetLineWidth(context, borderWidth);
	CGRect rrect = CGRectMake((rect.origin.x + borderWidth / 2), (rect.origin.y + borderWidth / 2), (rect.size.width - borderWidth), (rect.size.height - borderWidth));
	
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	CGContextMoveToPoint(context, minx, midy);
    if (type == isTop) {
        CGContextAddArcToPoint(context, minx, miny, midx, miny, 8.f);
        CGContextAddArcToPoint(context, maxx, miny, maxx, midy, 8.f);
        CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, 0.f);
        CGContextAddArcToPoint(context, minx, maxy, minx, midy, 0.f);
    } else if (type == isMid) {
        CGContextAddArcToPoint(context, minx, miny, midx, miny, 0.f);
        CGContextAddArcToPoint(context, maxx, miny, maxx, midy, 0.f);
        CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, 0.f);
        CGContextAddArcToPoint(context, minx, maxy, minx, midy, 0.f);
    } else if (type == isSingle) {
        CGContextAddArcToPoint(context, minx, miny, midx, miny, 8.f);
        CGContextAddArcToPoint(context, maxx, miny, maxx, midy, 8.f);
        CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, 8.f);
        CGContextAddArcToPoint(context, minx, maxy, minx, midy, 8.f);
    } else {
        CGContextAddArcToPoint(context, minx, miny, midx, miny, 0.f);
        CGContextAddArcToPoint(context, maxx, miny, maxx, midy, 0.f);
        CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, 8.f);
        CGContextAddArcToPoint(context, minx, maxy, minx, midy, 8.f);
    }
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);
}


@end
