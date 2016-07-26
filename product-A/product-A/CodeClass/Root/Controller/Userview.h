//
//  Userview.h
//  product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface Userview : UIView

@property(nonatomic,strong) RootViewController*RootVC;

@property (strong, nonatomic) IBOutlet UIImageView *imagev;

@property (strong, nonatomic) IBOutlet UIButton *login;


@end
