//
//  RightViewController.h
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , MOVETYPE)
{
    MOVETYPELEFT,
    MOVETYPERIGHT

};

@interface RightViewController : UIViewController
@property(nonatomic,strong)UILabel *titleLabel;

// hide or show

@property(nonatomic,assign)MOVETYPE movetype;


-(void)ChangeFrameWithType:(MOVETYPE)type;




@end
