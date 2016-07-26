//
//  DownLoadTableViewCell.h
//  product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioDetailLastModel.h"
@interface DownLoadTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) IBOutlet UILabel *name;




-(void)passValue:(RadioDetailLastModel *)model;


@end
