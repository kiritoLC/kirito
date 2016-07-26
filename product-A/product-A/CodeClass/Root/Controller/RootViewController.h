//
//  RootViewController.h
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightViewController.h"
#define KCAGradientLayerHeight (kScreenHeight / 3.0)

@interface RootViewController : UIViewController


@property(nonatomic,strong)NSArray *controllers;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)RightViewController *rightVC;
@property(nonatomic,strong)UINavigationController *myNaviVC;



@end
