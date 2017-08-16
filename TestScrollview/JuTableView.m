//
//  JuTableView.m
//  TestScrollview
//
//  Created by Juvid on 2017/8/15.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import "JuTableView.h"

@interface JuTableView (){
    CGPoint startScrollPoint;
    CGPoint startTablePoint;
    CGPoint lastPoint;
}

@end


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
-(id)init{
    self=[super init];
    if (self) {
        [self awakeFromNib];
    }
    return self;
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
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
  
    startScrollPoint=_ju_scrollView.contentOffset;
    startTablePoint=self.contentOffset;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.contentOffset.y<0) {/// 当table下拉时防止table出现弹性效果
        self.contentOffset=CGPointMake(0, 0);
        return;
    }
    if (lastPoint.y<scrollView.contentOffset.y) { /// 当上拉table时
        if (_ju_scrollView.contentOffset.y<64) {///< 外层还没有置顶 保持table与外层粘合在一起
            scrollView.contentOffset=CGPointMake(0, 0);
        }
    }else{///< 下拉
        
    }
    
     lastPoint=scrollView.contentOffset;
    
    if (startTablePoint.y>0&&startScrollPoint.y<64) {
        
        return;
    }
   
   
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
