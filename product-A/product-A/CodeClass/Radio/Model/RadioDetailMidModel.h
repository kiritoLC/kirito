//
//  RadioDetailMidModel.h
//  product-A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioDetailMidModel : NSObject

@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *uname;
@property(nonatomic,strong)NSNumber *musicvisitnum;
@property(nonatomic,strong)NSString *desc;



+(RadioDetailMidModel *)midConfigure:(NSDictionary *)jsonDic;


@end
