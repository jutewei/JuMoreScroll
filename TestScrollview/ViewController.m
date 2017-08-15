//
//  ViewController.m
//  TestScrollview
//
//  Created by Juvid on 2017/8/15.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import "ViewController.h"
#import "JuTableView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet JuTableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *juScroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.ju_scrollView=_juScroll;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y>64||_tableView.contentOffset.y>0) {
        scrollView.contentOffset=CGPointMake(0, 64);
    }
    
//    if (_tableView.contentOffset.y==_tableView.contentSize.height-_tableView.frame.size.height) {
//        _tableView.contentOffset=CGPointMake(0, _tableView.contentSize.height-_tableView.frame.size.height-1);
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
