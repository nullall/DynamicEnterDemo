//
//  ModuleButton.m
//  iecmanager
//
//  Created by Da.W on 17/2/24.
//  Copyright © 2017年 chuangli. All rights reserved.
//  首页按钮

#import "ModuleButton.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation ModuleButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.contentEdgeInsets=UIEdgeInsetsMake(0, 0, 10, 0);
        self.btnNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 20)];
        self.btnNameLabel.textColor=UIColorFromHex(0x8B8B8B);
        self.btnNameLabel.font=[UIFont systemFontOfSize:13];
        self.btnNameLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:self.btnNameLabel];
        
        self.badgeValueLabel=[[UILabel alloc]init];
        self.badgeValueLabel.textColor=[UIColor whiteColor];
        self.badgeValueLabel.font=[UIFont systemFontOfSize:10];
        self.badgeValueLabel.textAlignment=NSTextAlignmentCenter;
        self.badgeValueLabel.backgroundColor=RGBA(255, 0, 39, 1);
        self.badgeValueLabel.layer.masksToBounds=YES;
        self.badgeValueLabel.layer.cornerRadius=7;
        [self addSubview:self.badgeValueLabel];
        self.badgeValueLabel.hidden=YES;
        
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.btnNameLabel.textColor=UIColorFromHex(0xC6C6C6);
    }else{
        self.btnNameLabel.textColor=UIColorFromHex(0x8B8B8B);
    }
}

-(void)setModel:(ModuleModel *)model{
    _model=model;
    
    self.btnNameLabel.text=model.title;
    
    //设置图标
    __block UIImage *btnImage=[UIImage imageNamed:@"failedicon"];
    [self sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"failedicon"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            //因为有缓存 不一定进的来
            btnImage=image;
            if (model.iconHeight.floatValue>0&&model.iconWidth.floatValue>0) {
                self.imageEdgeInsets=UIEdgeInsetsMake((self.height-10-model.iconHeight.floatValue)/2, (self.width-model.iconWidth.floatValue)/2, (self.height-10-model.iconHeight.floatValue)/2, (self.width-model.iconWidth.floatValue)/2);
            }
        }
    }];
    [self sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] forState:UIControlStateNormal placeholderImage:btnImage];
    
    //设置图标大小
    if (model.iconHeight.floatValue>0&&model.iconWidth.floatValue>0) {
        //高度上-10是因为 上面在整个内容上 设置里距离底部10；
        self.imageEdgeInsets=UIEdgeInsetsMake((self.height-10-model.iconHeight.floatValue)/2, (self.width-model.iconWidth.floatValue)/2, (self.height-10-model.iconHeight.floatValue)/2, (self.width-model.iconWidth.floatValue)/2);
    }
    
    //设置角标
    if (model.badge.intValue>0) {
        CGRect frame=self.imageView.frame;
        frame.origin.x=self.imageView.center.x+frame.size.width/2-10;
        frame.origin.y=self.imageView.center.y-frame.size.height/2;
        frame.size=CGSizeMake(14, 14);
        NSLog(@"%@",NSStringFromCGRect(frame));
        [self.badgeValueLabel setFrame:frame];
        self.badgeValueLabel.hidden=NO;
        self.badgeValueLabel.text=model.badge;
        if (model.badge.intValue>99) {
            self.badgeValueLabel.text=@"99";
        }
    }
}


@end
