//
//  JuMultiScrollView.m
//  TestScrollview
//
//  Created by Juvid on 2017/8/16.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import "JuMultiScrollView.h"
@interface JuMultiScrollView (){
    CGPoint startPoint;
    CGPoint lastPoint;
    BOOL isDragTable;
    __weak UITableView *ju_tableView;
}
@end

@implementation JuMultiScrollView
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    startPoint=self.contentOffset;
//    if (_ju_topSpace==0) {
        _ju_topSpace=self.contentSize.height-self.frame.size.height;
//    }
    
    isDragTable=NO;
    UIView *supView=[super hitTest:point withEvent:event];
    while (supView&&![supView isKindOfClass:[JuMultiScrollView class]]) {
        if ([supView isKindOfClass:[JuMultiTableView class]]) {
            isDragTable=YES;
            ju_tableView=(id)supView;
            break;
        }
        supView=supView.superview;
    }
    return [super hitTest:point withEvent:event];
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (self.superview) {
        [self removeObserver:self forKeyPath:@"contentOffset"];
    }
    if (newSuperview) {
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [self addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        if (self.contentOffset.y>_ju_topSpace) {///< 当往上拖动，最外层scroll定位到标题头
            self.contentOffset=CGPointMake(0, _ju_topSpace);///防止外层滚动
            return;
        }
        
        if (!ju_tableView) {
            return;
        }
        
        if (ju_tableView.dragging||isDragTable) {///< table滚动带动的才响应
            if (lastPoint.y>self.contentOffset.y) {///< 当内层table下拉&&startPoint.y>64
                if (ju_tableView.contentOffset.y>0&&self.contentOffset.y!=startPoint.y) { ///< 定位最外层scroll标题头
                    //                    if (startPoint.y<64) {/// 当拖动的时候位置就已经偏移  ///< scroll 固定在以前位置
                    self.contentOffset=startPoint;
                    //                    }else{
                    //                        self.contentOffset=CGPointMake(0, 64);///防止外层滚动
                    //                    }
                }
            }else{/// 往上拖动坐标会改变
                startPoint=self.contentOffset;
            }
        }
        /*else{/// 此条件可以在浮快置顶的时候禁止外层滚动
         if (_ju_tableView.contentOffset.y>0&&self.contentOffset.y!=_ju_topSpace) {
         self.contentOffset=CGPointMake(0, _ju_topSpace);///防止外层滚动
         }
         }*/
        lastPoint=self.contentOffset;
        
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

@interface JuMultiTableView(){
    CGPoint startPoint;
    CGPoint lastPoint;
    __weak  JuMultiScrollView *ju_scrollView;
}

@end

@implementation JuMultiTableView
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        //        CGPoint pointNew=[change[@"new"] CGPointValue];
        if (!ju_scrollView) {
            return;
        }
        
        if (self.contentOffset.y<0) {/// 当table下拉时防止table出现弹性效果
            self.contentOffset=CGPointMake(0, 0);
            
            return;
        }
        if (lastPoint.y<self.contentOffset.y) { /// 当上拉table时
            if (ju_scrollView.contentOffset.y<ju_scrollView.ju_topSpace&&startPoint.y<=0&&self.contentOffset.y!=0) {///< 外层还没有置顶 并且内层与外层初始是黏在一起的 保持table与外层粘合在一起
                self.contentOffset=CGPointMake(0, 0);
            }
        }
        lastPoint=self.contentOffset;
        
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (self.superview) {
        [self removeObserver:self forKeyPath:@"contentOffset"];
    }
    if (newSuperview) {
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [self addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer.view isEqual:ju_scrollView]) {/// 防止里层scroll上下滚动
        return YES;
    }
    return NO;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (!ju_scrollView) {
        UIView *supView=self.superview;
        while (supView&&![supView isKindOfClass:[JuMultiScrollView class]]) {
             supView=supView.superview;
        }
        ju_scrollView=(JuMultiScrollView *)supView;
    }
    startPoint=self.contentOffset;
    return [super hitTest:point withEvent:event];
}

@end
