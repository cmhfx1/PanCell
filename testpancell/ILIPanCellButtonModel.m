//
//  ILIPanCellButtonModel.m
//  testpancell
//
//  Created by fx on 2017/8/1.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "ILIPanCellButtonModel.h"

@implementation ILIPanCellButtonModel


+ (instancetype)panCellWithType:(ILIPanCellButtonType)type width:(CGFloat)width titleColor:(UIColor *)titleColor backColor:(UIColor *)backColor
{
    ILIPanCellButtonModel *mdl = [[self alloc] initWithType:type width:width titleColor:titleColor backColor:backColor];
    return mdl;
}

- (instancetype)initWithType:(ILIPanCellButtonType)type width:(CGFloat)width titleColor:(UIColor *)titleColor backColor:(UIColor *)backColor
{
    if (self = [super init]) {
        
        self.type = type;
        self.width = width;
        self.titleColor = titleColor;
        self.backColor = backColor;
        
    }
    return self;
}

@end
