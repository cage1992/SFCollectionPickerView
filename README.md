# SFCollectionPickerView

一:这个控件适用于一些需要选择图片等的场合,可以加载本地或者网络图片.

二: 本控件提供两种初始化模式:

      1.指定collectionViewcell的宽高比,适用于cell里图片尺寸固定的场合.
      
      -(instancetype)initWithPickerHeight:(CGFloat)pickerHeight andDataSource:(NSArray *)dataSource margin:(CGFloat)margin itemCountForRow:(NSUInteger)itemCount withScale:(CGFloat)scale

      2.指定cell的高度,适用于对cell高度要求固定的场合.
      
      -(instancetype)initWithPickerHeight:(CGFloat)pickerHeight andDataSource:(NSArray *)dataSource margin:(CGFloat)margin itemCountForRow:(NSUInteger)itemCount withItemHeight:(CGFloat)itemHeight
      
      
三: 可以通过初始化方法的 itemCountForRow 属性指定一行显示的cell数,已做自适应处理,保证显示正常美观.

四: 可以通过暴露的属性设置控件的显示样式:
   
        1./**  标题  **/
        @property(nonatomic, copy)NSString *pickerTitle;
        
        2. /**  标题背景色  **/
        @property(nonatomic, strong)UIColor *titleBackGroundColor;
        
        3./**  collection背景色  **/
        @property(nonatomic, strong)UIColor *pickerBackGroundColor;
        
        
 五: 相关公共方法:
        1./**  显示处理  **/
        -(void)showingOn:(UIView *)superView;
        
        2. /** 移除处理  **/
        -(void)dismissed;
        
        
        

        
