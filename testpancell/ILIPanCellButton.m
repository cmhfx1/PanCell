//
//  ILIPanCellButton.m
//  testpancell
//
//  Created by fx on 2017/8/1.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "ILIPanCellButton.h"

@implementation ILIPanCellButton

+ (instancetype)panCellButtonWithType:(ILIPanCellButtonType)type
{
    ILIPanCellButton *btn = [ILIPanCellButton buttonWithType:UIButtonTypeCustom];
    btn.type = type;
    return btn;
}

@end
