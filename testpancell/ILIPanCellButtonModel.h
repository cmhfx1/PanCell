//
//  ILIPanCellButtonModel.h
//  testpancell
//
//  Created by fx on 2017/8/1.
//  Copyright © 2017年 fx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILIPanCellButton.h"

@interface ILIPanCellButtonModel : NSObject


@property (nonatomic,assign)ILIPanCellButtonType type;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,copy)UIColor *titleColor;
@property (nonatomic,copy)UIColor *backColor;


+ (instancetype)panCellWithType:(ILIPanCellButtonType)type width:(CGFloat)width titleColor:(UIColor *)titleColor backColor:(UIColor *)backColor;

@end
