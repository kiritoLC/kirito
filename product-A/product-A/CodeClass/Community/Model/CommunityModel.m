//
//  CommunityModel.m
//  product-A
//
//  Created by lanou on 16/7/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityModel.h"

@implementation CommunityModel



-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}

+(NSMutableArray *)modelConfigure:(NSDictionary *)jsdonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsdonDic[@"data"];
    NSArray *listArr = dataDic[@"list"];
    for (NSDictionary *dic1 in listArr) {
        CommunityModel *model = [[CommunityModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        NSDictionary *counterListDic = dic1[@"counterList"];
        [model setValuesForKeysWithDictionary:counterListDic];
        NSDictionary *userinfoDic = dic1[@"userinfo"];
        [model setValuesForKeysWithDictionary:userinfoDic];
        [arr addObject:model];
    }
    return arr;
}







@end
