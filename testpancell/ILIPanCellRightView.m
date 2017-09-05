//
//  ILIPanCellRightView.m
//  testpancell
//
//  Created by fx on 2017/8/1.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "ILIPanCellRightView.h"
#import "ILIPanCellButtonModel.h"
#import "ILIPanCellButton.h"


@interface ILIPanCellRightView ()


@property (nonatomic,assign)CGFloat width;

@end

@implementation ILIPanCellRightView




- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (void)setBtns:(NSArray *)btns
{
    _btns = btns;
    
    _width = 0.f;
    
    for (ILIPanCellButtonModel *mdl in btns) {
        
        ILIPanCellButton *btn = [ILIPanCellButton panCellButtonWithType:mdl.type];
        [btn setTitleColor:mdl.titleColor forState:UIControlStateNormal];
        [btn setBackgroundColor:mdl.backColor];
        _width += mdl.width;
        [self addSubview:btn];
    }
    
    NSLog(@"<");
    
}

- (CGFloat)width
{
    return _width;
}


- (CGFloat)findBestLocation:(CGFloat)distance
{
    // distance 是 contentview 的 偏移距离 是左侧的 也是右侧的
    // 40 60
    
    CGFloat tmp = _width;

    for (int i = 0; i < _btns.count; i++) {
        
        ILIPanCellButtonModel *model = _btns[i];
        tmp -= model.width;
        if (distance > tmp) {
            if (distance > tmp + model.width/2.0) {
                distance = tmp + model.width;
            }else{
                distance = tmp;
            }
            break;
        }else continue;
    }
    
    return distance;

}








@end
