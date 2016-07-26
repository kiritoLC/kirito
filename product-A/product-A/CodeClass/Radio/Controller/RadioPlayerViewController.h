//
//  RadioPlayerViewController.h
//  product-A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RightViewController.h"

@interface RadioPlayerViewController : RightViewController


@property(nonatomic,strong)NSString *htmlUrl;

@property(nonatomic,strong)UIButton *button;

@property(nonatomic,assign)BOOL isplay;

@end
