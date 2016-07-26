//
//  RadioDetailMidModel.m
//  product-A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RadioDetailMidModel.h"

@implementation RadioDetailMidModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(RadioDetailMidModel *)midConfigure:(NSDictionary *)jsonDic
{
    NSDictionary *dataDic = jsonDic[@"data"];
    NSDictionary *radioInfo = dataDic[@"radioInfo"];
    RadioDetailMidModel *model = [[RadioDetailMidModel alloc]init];
    [model setValuesForKeysWithDictionary:radioInfo];
    NSDictionary *userinfo = radioInfo[@"userinfo"];
    [model setValuesForKeysWithDictionary:userinfo];
    return model;
}



@end
