//
//  WPCollectionPickerView.h
//  iDevice
//
//  Created by shelleyimac on 17/3/30.
//  Copyright © 2017年 Sanfriend Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WPCollectionPickerViewDelegate <NSObject>

-(void)collectionPicker:(UIView *)collectionPicker didSelectItem:(NSObject *)selectedItem;

@end

@interface WPCollectionPickerView : UIView

/**
    标题
 **/
@property(nonatomic, copy)NSString *pickerTitle;

/**
    标题背景色
 **/
@property(nonatomic, strong)UIColor *titleBackGroundColor;

/**
    collection背景色
 **/
@property(nonatomic, strong)UIColor *pickerBackGroundColor;


/**
    pickerDelegate
 **/
@property(nonatomic, weak)id<WPCollectionPickerViewDelegate> delegate;

/**
 初始化(固定cell宽高比)
 **/
-(instancetype)initWithPickerHeight:(CGFloat)pickerHeight andDataSource:(NSArray *)dataSource margin:(CGFloat)margin itemCountForRow:(NSUInteger)itemCount withScale:(CGFloat)scale;

/**
 初始化(固定cell高度)
 **/
-(instancetype)initWithPickerHeight:(CGFloat)pickerHeight andDataSource:(NSArray *)dataSource margin:(CGFloat)margin itemCountForRow:(NSUInteger)itemCount withItemHeight:(CGFloat)itemHeight;

/**
 显示处理
 **/
-(void)showingOn:(UIView *)superView;

/**
 移除处理
 **/
-(void)dismissed;

@end
