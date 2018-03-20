//
//  CollectionViewCell.h
//  DynamicEnterDemo
//
//  Created by Da.W on 2018/2/7.
//  Copyright © 2018年 daw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleModel.h"

@interface ModuleCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImv;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;


@property (nonatomic,strong) ModuleModel *model;
@end
