//
//  ViewController.m
//  EVSlideMenuView
//
//  Created by iwevon on 16/8/16.
//  Copyright © 2016年 iwevon. All rights reserved.
//

#import "ViewController.h"
#import "EVSlideMenuView.h"
#import "EVTableViewWithBlock.h"
#import "CustomTableViewCell.h"

#import <objc/runtime.h>

#define FIRST_PAGE 1
static char deletCarSourceInfoKey;


@interface ViewController ()<UIAlertViewDelegate>

/**
 *  列表的数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSuorceArray;
/**
 *  列表对应的currentPage
 */
@property (nonatomic, strong) NSMutableArray *curPageArray;
/**
 *  列表对应的cell height
 */
@property (nonatomic, strong) NSMutableArray *cellHeightArray;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupData];
    [self setupUI];
}

- (void)setupData {
    
    self.titleArray = @[@"发布中", @"已撤销", @"管理员删除", @"全部"];
    self.dataSuorceArray = [NSMutableArray array];
    self.curPageArray = [NSMutableArray array];
    self.cellHeightArray = [NSMutableArray array];
    
    
    //初始化数据源
    [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *sourceArray = [NSMutableArray array];
        NSMutableArray *heightArray = [NSMutableArray array];
        for (int i=0; i<self.titleArray.count; i++) {
            [sourceArray addObject:[NSString stringWithFormat:@"%d", i]];
            [heightArray addObject:@(kCustomTableViewCellDefaultHeight)];
        }
        
        [self.dataSuorceArray addObject:sourceArray];
        [self.cellHeightArray addObject:heightArray];
        [self.curPageArray addObject:@(FIRST_PAGE)];
    }];
}

- (void)setupUI {
    
    //创建顶部滑动控制器
    self.view.backgroundColor = [UIColor grayColor];
    
    CGFloat menuWidth = self.view.frame.size.width/self.titleArray.count;
    UIColor *normalColor = [UIColor grayColor];
    UIColor *selectColor = [UIColor yellowColor];
    
    CGFloat slideMenuX = 0;
    CGFloat slideMenuY = 20;
    CGFloat slideMenuW = self.view.frame.size.width;
    CGFloat slideMenuH = self.view.frame.size.height - slideMenuY;
    CGRect frame = CGRectMake(slideMenuX, slideMenuY, slideMenuW, slideMenuH);
    
    EVSlideMenuView *slideMenu = [EVSlideMenuView slideMenuViewWithFrame:frame menuArray:self.titleArray menuWidth:menuWidth normalColor:normalColor selectColor:selectColor];
    [self.view addSubview:slideMenu];
    
    slideMenu.selectedIndex = 0;
    slideMenu.menuScrollView.backgroundColor = [UIColor purpleColor];
    //设置tableView数据
    slideMenu.tableViewArray = [self tableViewArrayWithSourceArray:self.dataSuorceArray];
}


/**
 *  设置tableView
 */
- (NSArray *)tableViewArrayWithSourceArray:(NSArray *)sourceArray {
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    //设置tableview
    for (int i=0; i<sourceArray.count; i++) {
        
        EVTableViewWithBlock *tableView = [EVTableViewWithBlock tableViewWithFrame:CGRectZero style:UITableViewStylePlain setNumOfSectionsBlock:^NSInteger(UITableView *tableView) {
            return 1;
        } setNumOfRowsBlock:^NSInteger(UITableView *tableView, NSInteger section) {
            NSArray *dataArray = sourceArray[i];
            return dataArray.count;
        } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            NSString *title = sourceArray[i][indexPath.row];
            NSLog(@"DataSource - %@", title);

            CustomTableViewCell *cell = [CustomTableViewCell cellWithTableView:tableView];
            //判断是否显示更多信息
            [cell hiddenContactInfo:[self.cellHeightArray[i][indexPath.row] floatValue]==kCustomTableViewCellDefaultHeight];
            
            cell.cellEventBlock = ^(CGFloat cellHeight){
                if (cellHeight) {
                    self.cellHeightArray[i][indexPath.row] = @(cellHeight);
                    [tableView reloadData];
                }
            };
            return cell;
            
        } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
            
            NSString *title = sourceArray[i][indexPath.row];
            UIAlertView *alerctView = [[UIAlertView alloc] initWithTitle:nil message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            objc_setAssociatedObject(alerctView, &deletCarSourceInfoKey, @(indexPath.row), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [alerctView show];
        
        } setHeightForRowBlock:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            NSArray *cellHeightArray = self.cellHeightArray[i];
            return [cellHeightArray[indexPath.row] floatValue];
        }];
        [tempArray addObject:tableView];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        /* 刷新控件
        
        tableView.header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            self.curPageArray[i] = @(FIRST_PAGE);
            [self getCarSourceTableWithStatus:i pageNum:FIRST_PAGE];
        }];
        
        tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            NSInteger curPageNum = [self.curPageArray[i] integerValue] + 1;
            self.curPageArray[i] = @(curPageNum);
            [self getCarSourceTableWithStatus:i pageNum:curPageNum];
        }];
         */
        
    }
    return tempArray;
}


#pragma mark - UIAlerctViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(!buttonIndex) return;
    
    NSNumber * index = (NSNumber *)objc_getAssociatedObject(alertView, &deletCarSourceInfoKey);
    NSLog(@"%@", index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
