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
@interface ViewController (){
    CGPoint startScrollPoint;
    CGPoint startTablePoint;
    CGPoint lastPoint;
}
@property (weak, nonatomic) JuTableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *juScroll;
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
        table.juFrame(CGRectMake(0.01+375*i,0,0,0));
        if (i==0) {
            _tableView=table;
        }
    }
  
    _scrollBox.contentSize=CGSizeMake(375*2, 0);
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_juScroll]) {
        startScrollPoint=_juScroll.contentOffset;
        startTablePoint=_tableView.contentOffset;
        NSLog(@"开始位置 1:%f 2:%f",startScrollPoint.y,startTablePoint.y);
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_juScroll]) {
        if (scrollView.contentOffset.y>64) {///< 当往上拖动，最外层scroll定位到标题头
            _juScroll.contentOffset=CGPointMake(0, 64);///防止外层滚动
            return;
        }
        
        if (lastPoint.y>scrollView.contentOffset.y) {///< 当table往下拉&&startPoint.y>64
            if (_tableView.contentOffset.y>0) { ///< 定位最外层scroll标题头
                 _juScroll.contentOffset=CGPointMake(0, 64);///防止外层滚动
            }
        }else{
            
        }
        
          lastPoint=scrollView.contentOffset;
        if (startTablePoint.y>0&&startScrollPoint.y<64) {
            
            return;
        }
        
        
    }
  
    
//    if (_tableView.contentOffset.y==_tableView.contentSize.height-_tableView.frame.size.height) {
//        _tableView.contentOffset=CGPointMake(0, _tableView.contentSize.height-_tableView.frame.size.height-1);
//    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_scrollBox]) {
        NSInteger tag= scrollView.contentOffset.x/scrollView.frame.size.width;
        _tableView=[_scrollBox viewWithTag:10+tag];
//        [_juScroll setContentOffset:CGPointMake(0, 64) animated:YES];///方法一每次置顶
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
