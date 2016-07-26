//
//  ProductTableViewCell.m
//  product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ProductTableViewCell.h"

@implementation ProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        self.imageV = [[UIImageView alloc]init];
        self.label = [[UILabel alloc]init];
        self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];

        
        [self.contentView addSubview:self.btn];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.label];
        
    }
    
    
    return self;
    
    
}

-(void)layoutSubviews
{
    self.imageV.frame = CGRectMake(10, 10, kScreenWidth-20, self.frame.size.height-60);
    
    self.label.frame = CGRectMake(20, self.frame.size.height-60+10, kScreenWidth/2, 40);
    
    self.btn.frame = CGRectMake(kScreenWidth-140-10-20, self.frame.size.height-60+10, kScreenWidth-(kScreenWidth-140-10-20)-50, 40);
    
}








@end
