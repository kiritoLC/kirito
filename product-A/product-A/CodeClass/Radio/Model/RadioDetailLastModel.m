//
//  RadioDetailLastModel.m
//  product-A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RadioDetailLastModel.h"

@implementation RadioDetailLastModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigure:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *listarr = dataDic[@"list"];
    
    for (NSDictionary *dic in listarr) {
        RadioDetailLastModel *model = [[RadioDetailLastModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        
        NSDictionary *dic3 = dataDic[@"radioInfo"];
        NSDictionary *dic4 = dic3[@"userinfo"];
        [model setValuesForKeysWithDictionary:dic4];
        
        NSDictionary *dic2 = dic[@"playInfo"];
        
        [model setValuesForKeysWithDictionary:dic2];
        
        [arr addObject:model];
        
    }
    return arr;
}


@end
