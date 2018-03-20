//
//  CollectionViewCell.m
//  DynamicEnterDemo
//
//  Created by Da.W on 2018/2/7.
//  Copyright © 2018年 daw. All rights reserved.
//

#import "ModuleCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ModuleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ModuleModel *)model{
    _model=model;
    self.titleLabel.text=model.title;
     __block UIImage *failedimage=[UIImage imageNamed:@"failedicon"];
    [self.iconImv sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@"failedicon"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            //因为有缓存 不一定进的来
            failedimage=image;
        }
    }];
    
    if (model.iconWidth.floatValue>0 && model.iconHeight.floatValue>0) {
        //这里可以做一下图片大小的适配啥的，不过一般图片给的对的话其实也不需要
    }
    if (model.badge.intValue>0) {
        self.badgeLabel.text=model.badge;
    }else{
        self.badgeLabel.hidden=YES;
    }
}

@end
