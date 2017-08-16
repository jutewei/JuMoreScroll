//
//  JuMultiScrollView.m
//  TestScrollview
//
//  Created by Juvid on 2017/8/16.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import "JuMultiScrollView.h"

@implementation JuMultiScrollView
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
     startPoint=self.contentOffset;
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
    // 遇到这些情况就直接返回
   
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint pointNew=[change[@"new"] CGPointValue];
        if (pointNew.y==64) {
            return;
        }
        if (self.contentOffset.y>64) {///< 当往上拖动，最外层scroll定位到标题头
            self.contentOffset=CGPointMake(0, 64);///防止外层滚动
            return;
        }
        NSLog(@"%d",_ju_tableView.dragging);
        if (_ju_tableView.dragging) {///< table滚动带动的才响应
            if (lastPoint.y>self.contentOffset.y) {///< 当table往下拉&&startPoint.y>64
                if (_ju_tableView.contentOffset.y>0) { ///< 定位最外层scroll标题头
                    if (startPoint.y<64) {/// 当拖动的时候位置就已经偏移  ///< scroll 固定在以前位置
                        self.contentOffset=startPoint;
                    }else{
                        self.contentOffset=CGPointMake(0, 64);///防止外层滚动
                    }
                }
            }else{/// 往上拖动坐标会改变
                startPoint=self.contentOffset;
            }
        }
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

@implementation JuMultiTableView
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
    // 遇到这些情况就直接返回

    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint pointNew=[change[@"new"] CGPointValue];
        if (pointNew.y==0) {
            return;
        }
//        CGPoint pointOld=[change[@"old"] CGPointValue];
        if (self.contentOffset.y<0) {/// 当table下拉时防止table出现弹性效果
            self.contentOffset=CGPointMake(0, 0);
            return;
        }
        if (lastPoint.y<self.contentOffset.y) { /// 当上拉table时
            if (_ju_scrollView.contentOffset.y<64&&startPoint.y<=0) {///< 外层还没有置顶 保持table与外层粘合在一起 &&startScrollPoint.y<64
                self.contentOffset=CGPointMake(0, 0);
            }
        }
        lastPoint=self.contentOffset;
        
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
     startPoint=self.contentOffset;
    return [super hitTest:point withEvent:event];
}

@end
