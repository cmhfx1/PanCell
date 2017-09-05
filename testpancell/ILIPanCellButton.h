//
//  ILIPanCellButton.h
//  testpancell
//
//  Created by fx on 2017/8/1.
//  Copyright © 2017年 fx. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ILIPanCellButtonType){
    ILIPanCellButtonTypeShare,
    ILIPanCellButtonTypeDelete,
};


@interface ILIPanCellButton : UIButton

@property (nonatomic,assign)ILIPanCellButtonType type;

+ (instancetype)panCellButtonWithType:(ILIPanCellButtonType)type;

@end
