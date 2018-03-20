//
//  TabbarModel.h
//  DynamicEnterDemo
//
//  Created by Da.W on 2018/3/10.
//  Copyright © 2018年 daw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabbarModel : NSObject
@property (strong, nonatomic) NSString *className;  //类名
@property (strong, nonatomic) NSString *title;      //功能名称
@property (strong, nonatomic) NSString *iconUrl;    //图标
@property (strong, nonatomic) NSString *iconSelectedUrl;    //选中图标
@property (strong, nonatomic) NSString *textNormalColor;    //字体颜色
@property (strong, nonatomic) NSString *textSelectedColor;  //选中字体
@end
