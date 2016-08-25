//
//  EVSlideMenuView.h
//  EVSlideMenuView
//
//  Created by iwevon on 16/8/16.
//  Copyright © 2016年 iwevon. All rights reserved.
//

#import "EVCustomItem.h"
#import "EVTableViewWithBlock.h"

@interface EVSlideMenuView : UIView

/*
 #pragma mark - 重写父类方法
 //刷新数据
 - (void)setSelectedIndex:(NSInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    //your code
    如：1.刷新控件  2.切换tableView其它操作
 }
 
 //设置显示列表
 - (void)setMenuArray:(NSArray *)menuArray {
    [super setMenuArray:menuArray];
    //your code
    如：
     //初始化数据源
     [menuArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     [self.dataSuorceArray addObject:[NSMutableArray array]];  //列表的数据源
     [self.cellHeightArray addObject:[NSMutableArray array]];  //列表对应的cell height
     [self.curPageArray addObject:@(0)];                        //列表对应的currentPage
     }];
     
     //设置tableView数据
     self.tableViewArray = [self tableViewArrayWithSourceArray:self.dataSuorceArray];
}
 
 */


#pragma mark - Common
/** TabItem数组 */
@property (nonatomic, strong) NSArray *itemArray;
/** menu数据 */
@property (strong, nonatomic) NSArray *menuArray;
/** menu宽度 */
@property (nonatomic, assign) CGFloat menuWidth;
/** 当前显示的tableView */
@property (weak, nonatomic) UITableView *refreshTableView;
/** tableView数据 */
@property (strong, nonatomic) NSArray *tableViewArray;
/** 当前选中的文字 */
@property (copy, nonatomic) NSString *menuTittle;
/** 选中的下标 */
@property (nonatomic, assign) NSInteger selectedIndex;
/** 点击状态栏回到顶部 */
@property (nonatomic, assign) BOOL scrollsToTop;  // default is YES.

+ (instancetype)slideMenuViewWithFrame:(CGRect)frame
                             menuArray:(NSArray *)menuArray
                             menuWidth:(CGFloat)menuWidth
                           normalColor:(UIColor *)normalColor
                           selectColor:(UIColor *)selectColor;

#pragma mark - Not commonly used
/** nor文字颜色 */
@property (nonatomic, strong) UIColor *normalColor;
/** 选中文字颜色 */
@property (nonatomic, strong) UIColor *selectColor;
/** menu视图 */
@property (weak, nonatomic) UIScrollView *menuScrollView;
/** 内容视图 */
@property (weak, nonatomic) UIScrollView *scrollView;
/** menu背景视图 */
@property (weak, nonatomic) UIView *menuBgView;

@end
