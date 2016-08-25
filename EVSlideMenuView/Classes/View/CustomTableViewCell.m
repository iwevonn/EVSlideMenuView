//
//  ViewController.h
//  EVSlideMenuView
//
//  Created by iwevon on 16/8/16.
//  Copyright © 2016年 iwevon. All rights reserved.
//

#import "CustomTableViewCell.h"

CGFloat kCustomTableViewCellDefaultHeight = 120;
CGFloat kCustomTableViewCellFullHeight = 228;

@interface CustomTableViewCell ()

//联系人信息按钮
@property (weak, nonatomic) IBOutlet UIButton *contactInfoBtn;
//扩展视图
@property (weak, nonatomic) IBOutlet UIView *extensionView;


@end

@implementation CustomTableViewCell

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        _cellHeight = kCustomTableViewCellFullHeight;
    }
    return _cellHeight;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *indentifierCell = NSStringFromClass([self class]);
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifierCell];
    if (!cell) {
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:indentifierCell owner:nil options:nil];
        if (views.count) {
            cell = views.lastObject;
        } else {
            cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)hiddenContactInfo:(BOOL)hidden {
    self.contactInfoBtn.selected = !hidden;
    self.extensionView.hidden = hidden;
}


//contact information
- (IBAction)contactInfoClick:(UIButton *)button {
    self.extensionView.hidden = button.isSelected;
    button.selected = !button.isSelected;
    //切换cell的高度
    CGFloat cellHeight = button.isSelected?self.cellHeight:kCustomTableViewCellDefaultHeight;
    self.cellEventBlock ? self.cellEventBlock(cellHeight) : nil;
}
    
@end
