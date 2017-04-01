//
//  WPCollectionPickerView.m
//  iDevice
//
//  Created by shelleyimac on 17/3/30.
//  Copyright © 2017年 Sanfriend Co., Ltd. All rights reserved.
//

#import "WPCollectionPickerView.h"
#import "Masonry.h"

#import "WPCustomItemCell.h"    //导入自定义Cell头文件

#define CELLCLASS WPCustomItemCell     //设置自定义Cell的类型

static NSString * const ReuseCellID = @"CellID";

@interface WPCollectionPickerView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, weak)UIView *bgView;

@property(nonatomic, weak)UIView *contentView;

@property(nonatomic,weak)UIView *titleView;

@property(nonatomic,weak)UILabel *titleName;

@property(nonatomic,weak)UICollectionView *itemCollectionView;


@property(nonatomic,strong)NSMutableArray *dataSource;  //数据源

@property(nonatomic,assign)CGFloat margin;  //collectionCell 间距

@property(nonatomic,assign)NSUInteger itemCount; //一行cell的个数

@property(nonatomic,assign)CGFloat scale;   //宽高比

@property(nonatomic,assign)CGFloat itemHeight;  //cell高度

@property(nonatomic,assign)CGFloat pickerHeight;    //collectionPicker高度

@end

@implementation WPCollectionPickerView

-(instancetype)initWithPickerHeight:(CGFloat)pickerHeight andDataSource:(NSArray *)dataSource margin:(CGFloat)margin itemCountForRow:(NSUInteger)itemCount withScale:(CGFloat)scale{
    if (self = [super init]) {
        _pickerHeight = pickerHeight;
        _dataSource = [dataSource mutableCopy];
        _margin = margin;
        _itemCount = itemCount;
        _scale = scale;
        [self loadUI];
    }
    return self;
}

-(instancetype)initWithPickerHeight:(CGFloat)pickerHeight andDataSource:(NSArray *)dataSource margin:(CGFloat)margin itemCountForRow:(NSUInteger)itemCount withItemHeight:(CGFloat)itemHeight{
    if (self = [super init]) {
        _pickerHeight = pickerHeight;
        _dataSource = [dataSource mutableCopy];
        _margin = margin;
        _itemCount = itemCount;
        _itemHeight = itemHeight;
        [self loadUI];
    }
    return self;
}

-(void)loadUI {
    //加载背景view
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.bottom.equalTo(self).offset(-self.pickerHeight);
    }];
    [bgView setBackgroundColor:[UIColor clearColor]];
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapbgView)]];
    self.bgView = bgView;
    
    //加载内容view
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.mas_bottom);
        make.width.equalTo(self);
        make.height.equalTo(@(self.pickerHeight));
    }];
    self.contentView = contentView;
    
    //加载标题view
    UIView *titleView = [[UIView alloc] init];
    [contentView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.top.equalTo(contentView);
        make.width.equalTo(contentView);
        make.height.equalTo(@40);
    }];
   // titleView.backgroundColor = [UIColor colorWithHexString:@"#E57673"];
    titleView.backgroundColor = [UIColor orangeColor];
    self.titleView = titleView;
    
    UILabel *titleName = [[UILabel alloc] init];
    [titleView addSubview:titleName];
    [titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(titleView);
    }];
    [titleName setTextColor:[UIColor whiteColor]];
    [titleName setFont:[UIFont systemFontOfSize:20]];
    self.titleName = titleName;
    
    //加载collectionView
    UICollectionView *itemCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [contentView addSubview:itemCollectionView];
    [itemCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.top.equalTo(contentView).offset(40);
        make.width.equalTo(contentView);
        make.bottom.equalTo(contentView);
    }];
    [itemCollectionView registerClass:[CELLCLASS class] forCellWithReuseIdentifier:ReuseCellID];
    itemCollectionView.delegate = self;
    itemCollectionView.dataSource = self;
    //itemCollectionView.backgroundColor = [UIColor colorWithHexString:@"#CADAC8"];
    itemCollectionView.backgroundColor = [UIColor lightGrayColor];
    self.itemCollectionView = itemCollectionView;
}

#pragma mark - getter & setter

-(void)setTitleBackGroundColor:(UIColor *)titleBackGroundColor {
    _titleBackGroundColor = titleBackGroundColor;
    self.titleView.backgroundColor = titleBackGroundColor;
}

-(void)setPickerBackGroundColor:(UIColor *)pickerBackGroundColor {
    _pickerBackGroundColor = pickerBackGroundColor;
    self.itemCollectionView.backgroundColor = pickerBackGroundColor;
}
-(void)setPickerTitle:(NSString *)pickerTitle {
    _pickerTitle = pickerTitle;
    [self.titleName setText: pickerTitle];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CELLCLASS *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseCellID forIndexPath:indexPath];
    cell.itemModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellH;
    CGFloat cellW = (self.itemCollectionView.frame.size.width - (self.margin * (self.itemCount + 1))) / self.itemCount;
    
    if (self.scale) {
        cellH = cellW * self.scale;
    }else if(self.itemHeight) {
        cellH = self.itemHeight;
    }
    return CGSizeMake(cellW, cellH);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return _margin;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(_margin, _margin, _margin, _margin);
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *item = self.dataSource[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(collectionPicker:didSelectItem:)]) {
        [self.delegate collectionPicker:self didSelectItem:item];
    }
}

#pragma mark - public method

-(void)showingOn:(UIView *)superView {
    self.frame = superView.bounds;
    [superView addSubview:self];
    
    [self layoutIfNeeded];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(@(self.pickerHeight));
    }];
    [UIView animateWithDuration:.2 animations:^{
        [self layoutIfNeeded];
    }];
    
}

-(void)dismissed {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.mas_bottom);
        make.width.equalTo(self);
        make.height.equalTo(@(self.pickerHeight));
    }];
    [UIView animateWithDuration:.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 控件交互

-(void)tapbgView{
    [self dismissed];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
