//
//  ILIPanCellRightView.h
//  testpancell
//
//  Created by fx on 2017/8/1.
//  Copyright © 2017年 fx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ILIPanCellRightView : UIView

@property (nonatomic,strong)NSArray *btns;


- (CGFloat)width;



- (CGFloat)findBestLocation:(CGFloat)distance;

@end
