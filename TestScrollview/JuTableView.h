//
//  JuTableView.h
//  TestScrollview
//
//  Created by Juvid on 2017/8/15.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuTableView : UITableView<UITableViewDelegate,UITableViewDataSource>{
    CGPoint point;
}
@property (weak,nonatomic)UIScrollView *ju_scrollView;
@end
