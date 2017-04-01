//
//  WPCustomItemCell.h
//  iDevice
//
//  Created by shelleyimac on 17/3/31.
//  Copyright © 2017年 Sanfriend Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPCustomItemModel.h" //导入自定义Model头文件

#define MODELCLASS WPCustomItemModel //设置自定义Model的类型

@interface WPCustomItemCell : UICollectionViewCell

@property(nonatomic,strong)WPCustomItemModel *itemModel;

@end
