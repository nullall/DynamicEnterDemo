//
//  ModuleButton.h
//  iecmanager
//
//  Created by Da.W on 17/2/24.
//  Copyright © 2017年 chuangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleModel.h"

@interface ModuleButton : UIButton

@property (strong, nonatomic) UILabel *btnNameLabel;     //按钮名字
@property (strong, nonatomic) UILabel *badgeValueLabel; //角标
@property (strong, nonatomic) ModuleModel *model;
@end
