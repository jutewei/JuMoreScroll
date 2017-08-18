//
//  ViewController.m
//  TestScrollview
//
//  Created by Juvid on 2017/8/15.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import "ViewController.h"
#import "JuTableView.h"
#import "UIView+JuLayGroup.h"
#define Screen_Width     [[UIScreen mainScreen] bounds].size.width    //屏幕宽
@interface ViewController (){
    CGPoint startPoint;
    CGPoint lastPoint;
}
@property (weak, nonatomic) JuTableView *tableView;
@property (weak, nonatomic) IBOutlet JuMultiScrollView *juScroll;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollBox;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
    for (int i=0; i<2; i++) {
        JuTableView *table=[[JuTableView alloc]init];
        table.tag=i+10;
        [_scrollBox addSubview:table];
          table.ju_scrollView=_juScroll;
        table.juFrame(CGRectMake(0.01+Screen_Width*i,0,0,0));
        if (i==0) {
            _juScroll.ju_tableView=table;
        }
    }
  
    _scrollBox.contentSize=CGSizeMake(Screen_Width*2, 0);
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    if ([scrollView isEqual:_juScroll]) {
//        startPoint=_juScroll.contentOffset;
////        NSLog(@"开始位置 1:%f",startPoint.y);
//    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    if ([scrollView isEqual:_juScroll]) {
//        if (scrollView.contentOffset.y>64) {///< 当往上拖动，最外层scroll定位到标题头
//            _juScroll.contentOffset=CGPointMake(0, 64);///防止外层滚动
//            return;
//        }
//        if (_tableView.dragging) {///< table滚动带动的才响应
//            if (lastPoint.y>scrollView.contentOffset.y) {///< 当table往下拉&&startPoint.y>64
//                if (_tableView.contentOffset.y>0) { ///< 定位最外层scroll标题头
//                    if (startPoint.y<64) {/// 当拖动的时候位置就已经偏移  ///< scroll 固定在以前位置
//                        _juScroll.contentOffset=startPoint;
//                    }else{
//                        _juScroll.contentOffset=CGPointMake(0, 64);///防止外层滚动
//                    }
//                }
//            }else{/// 往上拖动坐标会改变
//                startPoint=scrollView.contentOffset;
//            }
//        }
//        lastPoint=scrollView.contentOffset;
//    }
  
//    if (_tableView.contentOffset.y==_tableView.contentSize.height-_tableView.frame.size.height) {
//        _tableView.contentOffset=CGPointMake(0, _tableView.contentSize.height-_tableView.frame.size.height-1);
//    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_scrollBox]) {
        NSInteger tag= scrollView.contentOffset.x/scrollView.frame.size.width;
//        _tableView=[_scrollBox viewWithTag:10+tag];
        _juScroll.ju_tableView=[_scrollBox viewWithTag:10+tag];
//        [_juScroll setContentOffset:CGPointMake(0, 64) animated:YES];///方法一每次置顶
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
