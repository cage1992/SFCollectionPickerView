//
//  WPCustomItemCell.m
//  iDevice
//
//  Created by shelleyimac on 17/3/31.
//  Copyright © 2017年 Sanfriend Co., Ltd. All rights reserved.
//

#import "WPCustomItemCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface WPCustomItemCell()

@property(nonatomic,weak)UIImageView *itemImgV;

@end

@implementation WPCustomItemCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

-(void)loadUI {
    UIImageView *itemImgV = [[UIImageView alloc]init];
    [self.contentView addSubview:itemImgV];
    [itemImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.itemImgV = itemImgV;
}

-(void)setItemModel:(MODELCLASS *)itemModel {
    _itemModel = itemModel;
    
    if (self.itemModel.itemImage) {
        [self.itemImgV setImage: self.itemModel.itemImage];
    } else if (self.itemModel.itemPicUrl) {
        [self.itemImgV sd_setImageWithURL:[NSURL URLWithString: self.itemModel.itemPicUrl]];
        self.itemModel.itemImage = self.itemImgV.image;
    }
}

@end
