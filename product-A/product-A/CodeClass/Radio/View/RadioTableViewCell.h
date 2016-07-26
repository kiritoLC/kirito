//
//  RadioTableViewCell.h
//  product-A
//
//  Created by lanou on 16/6/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *imageV;


@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UILabel *detailL;
@property (strong, nonatomic) IBOutlet UILabel *countL;

@end
