//
//  ModuleModel.h
//  DynamicEnterDemo
//
//  Created by Da.W on 2018/2/8.
//  Copyright © 2018年 daw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModuleModel : NSObject
@property (strong, nonatomic) NSString *className;  //类名
@property (strong, nonatomic) NSString *iconUrl;    //图标
@property (strong, nonatomic) NSString *iconPressedUrl;    //按压后的图标
@property (strong, nonatomic) NSString *title;      //功能名称
@property (strong, nonatomic) NSString *value;      //值，可能也用不到，暂时先放着；届时传值可以用NSUserDefaults传值方式传递
@property (strong, nonatomic) NSString *badge;      //角标
@property (strong, nonatomic) NSNumber *iconWidth;  //图标宽
@property (strong, nonatomic) NSNumber *iconHeight; //图标高
@end
