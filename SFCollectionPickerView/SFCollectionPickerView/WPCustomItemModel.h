//
//  WPCustomItemModel.h
//  iDevice
//
//  Created by shelleyimac on 17/3/30.
//  Copyright © 2017年 Sanfriend Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CustomItemType) {
    CustomItemBackGroundImg,
    CustomItemShelf,
    CustomItemIcon,
    CustomItemDecoration
};

@interface WPCustomItemModel : NSObject

/**
    itemID
 **/
@property(nonatomic, copy)NSString *itemID;

/**
    item图片URL
 **/
@property(nonatomic, copy)NSString *itemPicUrl;

/**
    item图片
 **/
@property(nonatomic,strong)UIImage *itemImage;

@end
