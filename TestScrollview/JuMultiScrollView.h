//
//  JuMultiScrollView.h
//  TestScrollview
//
//  Created by Juvid on 2017/8/16.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuMultiScrollView : UIScrollView{
    CGPoint startPoint;
    CGPoint lastPoint;
    BOOL isTable;
}
@property (weak,nonatomic)UITableView *ju_tableView;
@end


@interface JuMultiTableView : UITableView{
    CGPoint startPoint;
    CGPoint lastPoint;
}
@property (weak,nonatomic)UIScrollView *ju_scrollView;
//@property (assign)BOOL isDrag;
@end
