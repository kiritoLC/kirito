//
//  RightViewController.m
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UITapGestureRecognizer *tap;
@property(nonatomic,strong)UIPanGestureRecognizer *pan;
@end

@implementation RightViewController


-(UITapGestureRecognizer *)tap
{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideRootVC:)];
    }
    return _tap;
}



-(UIButton *)button
{
    if (!_button)
    {
        
        _button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20+10, 20, 20)];
        
        [_button setTitle:@"三" forState:(UIControlStateNormal)];
        
        [_button setTitleColor:PKCOLOR(25, 25, 25) forState:(UIControlStateNormal)];
        
        [_button addTarget:self action:@selector(shouRootVC:) forControlEvents:(UIControlEventTouchUpInside)];

    }
    return _button;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 20+10, 200, 20)];
        
        _titleLabel.font = [UIFont systemFontOfSize:18];
        
        _titleLabel.textColor = PKCOLOR(25, 25, 25);
        
    }
    return _titleLabel;
}

-(UIPanGestureRecognizer *)pan
{
    if (!_pan) {
        
        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panShowRootVC:)];
        
    }
    
    return _pan;
}


#pragma mark --- 抽屉实现---

-(void)shouRootVC:(UIButton *)btn
{
    
    [self ChangeFrameWithType:MOVETYPERIGHT];
    
}

-(void)hideRootVC:(UITapGestureRecognizer *)sender
{
    
    [self ChangeFrameWithType:MOVETYPELEFT];
    
}

-(void)panWithFinger:(UIScreenEdgePanGestureRecognizer *)sender
{
    
   CGPoint point = [sender locationInView:self.navigationController.view.superview];
    
    CGRect newFrame = self.navigationController.view.frame;
    
    newFrame.origin.x = point.x;
    
    [self constraintNewFrame:&newFrame];
    
    self.navigationController.view.frame = newFrame;
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        [self ChangeFrameWithType:MOVETYPERIGHT];
        
    }
    
}

-(void)panShowRootVC:(UIPanGestureRecognizer *)sender
{
    
    CGPoint point = [sender locationInView:self.navigationController.view.superview];
    
    NSLog(@"%@",NSStringFromCGPoint(point));
    
    CGRect newFrame = self.navigationController.view.frame;
    
    newFrame.origin.x = point.x;
    
    self.navigationController.view.frame = newFrame;
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
      [self ChangeFrameWithType:MOVETYPELEFT];
        
    }
    
}


-(void)constraintNewFrame:(CGRect *)newFrame{
    
    if (newFrame->origin.x>=kScreenWidth-kMoveDistance) {
        
        newFrame->origin.x = kScreenWidth-kMoveDistance;
        
    }else if (newFrame->origin.x<=0){
        
        newFrame->origin.x=0;
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.button];
    
    [self.view addSubview:self.titleLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *vertival = [[UIView alloc]initWithFrame:CGRectMake(40, 20, 1, KNaviH)];
    
    vertival.backgroundColor = PKCOLOR(100, 100, 100);
    
    [self.view addSubview:vertival];
    
    UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(0, 20+KNaviH, kScreenWidth, 1)];
    
     horizontal.backgroundColor = PKCOLOR(10, 10, 10);
    
    [self.view addSubview:horizontal];
    
    [self.view addGestureRecognizer:self.tap];
    
    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(panWithFinger:)];
    
    screenEdgePan.edges = UIRectEdgeLeft;
    
    [self.view addGestureRecognizer:screenEdgePan];
    
    [self.view addGestureRecognizer:self.pan];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
        
    {
        return NO;
        
    }
    if ([touch.view isKindOfClass:[UITableViewCell class]]) {
        
        return NO;
        
    }
    
    return YES;
    
}

-(void)ChangeFrameWithType:(MOVETYPE)type
{
    CGRect newFrame = self.navigationController.view.frame;
    
    if (type==MOVETYPELEFT) {
        
        newFrame.origin.x=0;
        self.button.userInteractionEnabled = YES;
        
        self.tap.enabled = NO;
        
        self.pan.enabled = NO;
    }
    
    else if (type==MOVETYPERIGHT)
    {
        self.pan.enabled = YES;
        
        self.tap.enabled = YES;
        
        self.button.userInteractionEnabled = NO;
        
        newFrame.origin.x = kScreenWidth-kMoveDistance;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.view.frame = newFrame;
    } completion:nil];
    
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
