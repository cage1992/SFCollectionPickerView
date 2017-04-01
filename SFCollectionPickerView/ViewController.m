//
//  ViewController.m
//  SFCollectionPickerView
//
//  Created by shelleyimac on 17/3/31.
//  Copyright © 2017年 Sanfriend Technology Co. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "WPCollectionPickerView.h"
#import "WPCustomItemModel.h"

@interface ViewController ()<WPCollectionPickerViewDelegate>

@property(nonatomic,weak)UIImageView *showImageV;

@property(nonatomic,weak)UILabel *showItemIDL;

@property(nonatomic,weak)UITextView *rowItemCountTxtV;

@property(nonatomic,weak)UITextView *scaleTxtV;


@property(nonatomic,strong)NSMutableArray *localDataSource;

@property(nonatomic,strong)NSMutableArray *webDataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.localDataSource = [NSMutableArray array];
    self.webDataSource = [NSMutableArray array];
    
    for (int i = 1; i <= 22; i++) {
        WPCustomItemModel *item = [[WPCustomItemModel alloc] init];
        item.itemID = [NSString stringWithFormat:@"local00_%d",i];
        item.itemImage = [UIImage imageNamed:[NSString stringWithFormat:@"iconBG_%d",i]];
        [self.localDataSource addObject:item];
    }
    
    for (int i = 1; i <= 40; i++) {
        WPCustomItemModel *item = [[WPCustomItemModel alloc] init];
        item.itemID = [NSString stringWithFormat:@"web00_%d",i];
        item.itemPicUrl = @"http://img05.tooopen.com/images/20150202/sy_80219211654.jpg";
        [self.webDataSource addObject:item];
    }
    
    UIImageView *showImageV = [[UIImageView alloc] init];
    [self.view addSubview:showImageV];
    [showImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(30);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [showImageV setImage:[UIImage imageNamed:@"decotation_013"]];
    self.showImageV = showImageV;
    
    UILabel *showItemIDL = [[UILabel alloc]init];
    [self.view addSubview:showItemIDL];
    [showItemIDL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showImageV.mas_bottom).offset(30);
        make.centerX.equalTo(showImageV);
    }];
    [showItemIDL setFont:[UIFont systemFontOfSize:22]];
    [showItemIDL setBackgroundColor:[UIColor orangeColor]];
    [showItemIDL setText:@"请选择"];
    [showItemIDL setTextColor:[UIColor blackColor]];
    self.showItemIDL = showItemIDL;
    
    UILabel *rowItemCountL = [[UILabel alloc] init];
    [self.view addSubview:rowItemCountL];
    
    [rowItemCountL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showItemIDL).offset(-20);
        make.top.equalTo(showItemIDL.mas_bottom).offset(20);
    }];
    [rowItemCountL setText:@"行cell数"];
    
    UITextView *rowItemCountTxtV = [[UITextView alloc]init];
    [self.view addSubview:rowItemCountTxtV];
    
    [rowItemCountTxtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rowItemCountL);
        make.left.equalTo(rowItemCountL.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [rowItemCountTxtV setBackgroundColor:[UIColor lightGrayColor]];
    rowItemCountTxtV.text = @"4";
    self.rowItemCountTxtV = rowItemCountTxtV;
    
    UILabel *scaleL = [[UILabel alloc] init];
    [self.view addSubview:scaleL];
    
    [scaleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rowItemCountL);
        make.top.equalTo(rowItemCountTxtV.mas_bottom).offset(20);
    }];
    [scaleL setText:@"宽高比"];
    
    UITextView *scaleTxtV = [[UITextView alloc]init];
    [self.view addSubview:scaleTxtV];
    
    [scaleTxtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rowItemCountTxtV);
        make.top.equalTo(rowItemCountTxtV.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [scaleTxtV setBackgroundColor:[UIColor lightGrayColor]];
    scaleTxtV.text = @"1";
    self.scaleTxtV = scaleTxtV;
    
    UIButton *localImgBtn = [[UIButton alloc] init];
    [self.view addSubview:localImgBtn];
    
    [localImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.centerX.equalTo(self.view).offset(-50);
        make.size.mas_equalTo(CGSizeMake(60, 50));
    }];
    [localImgBtn setTitle:@"本地图片" forState:UIControlStateNormal];
    [localImgBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [localImgBtn setBackgroundColor:[UIColor purpleColor]];
    [localImgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [localImgBtn addTarget:self action:@selector(localImgBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *webImgBtn = [[UIButton alloc] init];
    [self.view addSubview:webImgBtn];
    
    [webImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.centerX.equalTo(self.view).offset(50);
        make.size.mas_equalTo(CGSizeMake(60, 50));
    }];
    [webImgBtn setTitle:@"网络图片" forState:UIControlStateNormal];
    [webImgBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [webImgBtn setBackgroundColor:[UIColor purpleColor]];
    [webImgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [webImgBtn addTarget:self action:@selector(webImgBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)localImgBtnClicked {
    CGFloat height = self.view.frame.size.height * 0.6;
    WPCollectionPickerView *localCollectionPicker = [[WPCollectionPickerView alloc] initWithPickerHeight:height andDataSource:self.localDataSource margin:10 itemCountForRow:[self.rowItemCountTxtV.text integerValue] withScale:[self.scaleTxtV.text floatValue]];
   
    localCollectionPicker.delegate = self;
//    localCollectionPicker.pickerBackGroundColor = [UIColor lightGrayColor];
//    localCollectionPicker.titleBackGroundColor = [UIColor orangeColor];
    localCollectionPicker.pickerTitle = @"本地图片";
    [localCollectionPicker showingOn:self.view];
}

-(void)webImgBtnClicked {
    CGFloat height = self.view.frame.size.height * 0.6;
    WPCollectionPickerView *webImgCollectionPicker = [[WPCollectionPickerView alloc] initWithPickerHeight:height andDataSource:self.webDataSource margin:10 itemCountForRow:[self.rowItemCountTxtV.text integerValue] withScale:[self.scaleTxtV.text floatValue]];
    webImgCollectionPicker.delegate = self;
    webImgCollectionPicker.pickerTitle = @"网络图片";
    webImgCollectionPicker.pickerBackGroundColor = [UIColor greenColor];
    webImgCollectionPicker.titleBackGroundColor = [UIColor yellowColor];
    [webImgCollectionPicker showingOn:self.view];
}

#pragma mark - WPCollectionPickerViewDelegate

-(void)collectionPicker:(UIView *)collectionPicker didSelectItem:(NSObject *)selectedItem {
    WPCustomItemModel *item = (WPCustomItemModel *)selectedItem;
    self.showImageV.image = item.itemImage;
    self.showItemIDL.text = [NSString stringWithFormat:@"选择了%@",item.itemID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
