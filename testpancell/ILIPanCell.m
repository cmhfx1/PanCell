//
//  ILIPanCell.m
//  testpancell
//
//  Created by fx on 2017/8/1.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "ILIPanCell.h"
#import "ILIPanCellRightView.h"


#define KScreenSize  [UIScreen mainScreen].bounds.size


@interface ILIPanCell ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)NSArray *btns;

@property (nonatomic,weak)ILIPanCellRightView *rightview;


@end


@implementation ILIPanCell


+ (instancetype)panCellWithTableview:(UITableView *)tableview indexPath:(NSIndexPath *)indexpath btns:(NSArray *)btns
{
    ILIPanCell *cell = [tableview dequeueReusableCellWithIdentifier:@"pan" forIndexPath:indexpath];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.btns = btns;
    
    cell.opening = NO;
    cell.scrolling = NO;
    
    
    return cell;
}


- (void)setBtns:(NSArray *)btns
{
    _btns = btns;
    
    self.rightview.btns = btns;
    self.rightview.frame = CGRectMake(KScreenSize.width, 0, self.rightview.width, self.frame.size.height);
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupContentview];
        
        [self setupRightview];
        
    }
    
    return self;
}


- (void)setupContentview
{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.contentView addGestureRecognizer:pan];
   
    [pan addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    
     pan.delegate = self;
    
    UILabel *lb = [[UILabel alloc] init];
    lb.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lb];
    
    self.lb = lb;
    
}



- (void)setupRightview
{
    ILIPanCellRightView *rightview = [[ILIPanCellRightView alloc] init];
    rightview.backgroundColor = [UIColor redColor];
    [self insertSubview:rightview atIndex:0];
    self.rightview = rightview;
}


- (void)layoutSubviews
{
    
    if(self.isOpening || self.isScrolling) return;
    
    [super layoutSubviews];
    _lb.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
}



#pragma mark - kvo -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)object;
    
    if (pan.state == UIGestureRecognizerStateFailed) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(handleClickCell:)]) {
            [self.delegate handleClickCell:self];
        }
        
        
    }else if (pan.state == UIGestureRecognizerStateBegan){
        
        NSLog(@"panGes _ begin -> sc scroll");
        [[NSNotificationCenter defaultCenter] postNotificationName:KCellBeginDraging object:nil];
    }
    
}



- (void)pan:(UIPanGestureRecognizer *)pan
{
    
    
    CGFloat maxOffset = -self.rightview.width;
    
    CGFloat tx = self.contentView.transform.tx;
    CGPoint point = [pan translationInView:pan.view];
    
    
    
    if (ABS(point.y) > ABS(point.x) + 2) {
        self.contentView.transform = CGAffineTransformIdentity;
        return;
    }
    
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        self.scrolling = YES;
        
        self.rightview.transform = CGAffineTransformMakeTranslation(maxOffset, 0);
        
        [UIView animateWithDuration:.05 animations:^{
            
            self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, point.x, 0);
            
        }];
        
        //        NSLog(@"begin --------%@",NSStringFromCGAffineTransform(self.contentView.transform));
        
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
        CGFloat currentOffset = tx + point.x;
        
        //        NSLog(@"%f",currentOffset);
        
        if (currentOffset >= maxOffset && currentOffset <= 0) {
            
            
            [UIView animateWithDuration:.05 animations:^{
                
                self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, point.x, 0);
            }];
            
            //            NSLog(@"change  -%@",NSStringFromCGAffineTransform(self.contentView.transform));
            
            
        }else if(currentOffset < maxOffset){
            
            [UIView animateWithDuration:.05 animations:^{
                self.contentView.transform = CGAffineTransformMakeTranslation(maxOffset, 0);
                
            }];
            
        }else if (currentOffset > 0){
            
            [UIView animateWithDuration:.05 animations:^{
                self.contentView.transform = CGAffineTransformIdentity;
                
            }];
            
        }

    }else if (pan.state == UIGestureRecognizerStateEnded) {
        
        self.scrolling = NO;
        CGFloat tx_ = self.contentView.transform.tx;
        
        CGFloat expect =  [self.rightview findBestLocation:ABS(tx_)];
        //            NSLog(@"______________________++++_____________________________%f",expect);
        
        if (expect) {
            self.opening = YES;
        }else{
            self.opening = NO;
        }
        
        [UIView animateWithDuration:.05 animations:^{
            
            self.contentView.transform = CGAffineTransformMakeTranslation(-expect, 0);
            
        }];
        
    }

    [pan setTranslation: CGPointZero inView:pan.view];
    
}




- (void)close
{
    self.scrolling = NO;
    self.opening = NO;
    [UIView animateWithDuration:.2 animations:^{
        self.rightview.transform = CGAffineTransformIdentity;
        self.contentView.transform = CGAffineTransformIdentity;
        
    }];
}




- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
//    NSLog(@"hit");
    if (self.isOpening) {
        CGPoint rightViewPoint =  [self convertPoint:point toView:self.rightview];

        BOOL rightViewinside = [self.rightview pointInside:rightViewPoint withEvent:event];

        if (rightViewinside) {

            NSLog(@"click _ right view _ buttons");

            NSLog(@"simular call button");
        }else{
            NSLog(@"click _ cell _ not right view");
        }

        [self close];
        return nil;
    }else return [super hitTest:point withEvent:event];

}


#pragma mark - ges  delegate -

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}




@end
