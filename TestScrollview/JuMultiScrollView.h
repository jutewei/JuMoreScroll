//
//  JuMultiScrollView.h
//  TestScrollview
//
//  Created by Juvid on 2017/8/16.
//  Copyright © 2017年 Juvid. All rights reserved.
//
/*
 * 1、外层自己滚动：不做任何处理
 * 2、内层往上滚动：外层没置顶，外层往上滚，内层固定；外层置顶，内层往上滚动  *如果内层滚动前，外层没有置顶并且内层已经滚动过，则，内外层一起向上滚动
 * 3、内层往下滚动；内层没有滚动到顶，固定外层；内层滚动到顶，外层滚动内层不动
 */
#import <UIKit/UIKit.h>

@interface JuMultiScrollView : UIScrollView{
    CGPoint startPoint;
    CGPoint lastPoint;
    BOOL isDragTable;
}
@property (weak,nonatomic)UITableView *ju_tableView;
@property (assign,nonatomic)CGFloat ju_topSpace;

@end


@interface JuMultiTableView : UITableView{
    CGPoint startPoint;
    CGPoint lastPoint;
}
@property (weak,nonatomic)JuMultiScrollView *ju_scrollView;
//@property (assign)BOOL isDrag;
@end
