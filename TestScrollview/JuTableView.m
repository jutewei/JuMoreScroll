//
//  JuTableView.m
//  TestScrollview
//
//  Created by Juvid on 2017/8/15.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import "JuTableView.h"

@implementation JuTableView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.delegate=self;
    self.dataSource=self;
    UIView *vie =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 44)];
    self.tableHeaderView=vie;
    self.scrollIndicatorInsets=UIEdgeInsetsMake(44, 0, 0, 0);
     [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
//    self.bounces=NO;
//    self.panGestureRecognizer
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return 50;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (point.y<scrollView.contentOffset.y) {
        if (_ju_scrollView.contentOffset.y<64) {
            scrollView.contentOffset=CGPointMake(0, 0);
        }
    }
    if (self.contentOffset.y<0) {
        self.contentOffset=CGPointMake(0, 0);
    }
    point=scrollView.contentOffset;
   
//    if (scrollView.contentOffset.y>0) {
//         _ju_scrollView.contentOffset=CGPointMake(0, 64);
//    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text=[NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
