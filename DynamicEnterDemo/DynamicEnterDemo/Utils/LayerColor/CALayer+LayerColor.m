//
//  CALayer+LayerColor.m
//  iecmanager
//
//  Created by Da.W on 16/8/26.
//  Copyright © 2016年 chuangli. All rights reserved.
//

#import "CALayer+LayerColor.h"

@implementation CALayer (LayerColor)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
