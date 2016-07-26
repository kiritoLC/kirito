//
//  ReadPingLunViewController.h
//  product-A
//
//  Created by lanou on 16/7/4.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RightViewController.h"
@implementation UIScrollView (UITouchEvent)
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { [self.nextResponder touchesBegan:touches withEvent:event]; }
@end
@interface ReadPingLunViewController : RightViewController

@property(nonatomic,strong)NSString *conmentid;

@property(nonatomic,assign)NSInteger deviceid;

@end
