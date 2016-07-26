//
//  CommunityTableViewCell.h
//  product-A
//
//  Created by lanou on 16/7/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleL;

@property (strong, nonatomic) IBOutlet UIImageView *iconImageV;

@property (strong, nonatomic) IBOutlet UILabel *contentL;

@property (strong, nonatomic) IBOutlet UILabel *addtime_fL;

@property (strong, nonatomic) IBOutlet UILabel *commentL;


@end
