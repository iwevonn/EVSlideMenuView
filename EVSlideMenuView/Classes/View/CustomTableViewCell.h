//
//  ViewController.h
//  EVSlideMenuView
//
//  Created by iwevon on 16/8/16.
//  Copyright © 2016年 iwevon. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat kCustomTableViewCellDefaultHeight;
extern CGFloat kCustomTableViewCellFullHeight;

@interface CustomTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, assign) CGFloat cellHeight;

/**
 *  cell上的事件回调Block
 */
@property (nonatomic, copy) void(^cellEventBlock)(CGFloat cellHeight);

/**
 *  隐藏扩展信息
 */
- (void)hiddenContactInfo:(BOOL)hidden;


@end
