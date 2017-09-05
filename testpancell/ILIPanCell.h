//
//  ILIPanCell.h
//  testpancell
//
//  Created by fx on 2017/8/1.
//  Copyright © 2017年 fx. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString *KCellBeginDraging = @"cellBeginDraging";

@protocol ILIPanCellDelegate <NSObject>


- (void)handleClickCell:(UITableViewCell *)cell;

@end








@interface ILIPanCell : UITableViewCell

@property (nonatomic,weak)id<ILIPanCellDelegate>delegate;

+ (instancetype)panCellWithTableview:(UITableView *)tableview indexPath:(NSIndexPath *)indexpath btns:(NSArray *)btns;

@property (nonatomic,weak)UILabel *lb;

@property (nonatomic,assign,getter=isOpening)BOOL opening;

@property (nonatomic,assign,getter=isScrolling)BOOL scrolling;


- (void)close;

@end
