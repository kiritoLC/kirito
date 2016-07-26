//
//  ReadModel.m
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ReadModel.h"

@implementation ReadModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}


+(NSMutableArray *)ModelConfigure:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = dic[@"data"];
    NSArray *carouselArr = dataDic[@"carousel"];
    for (NSDictionary *dic1 in carouselArr) {
        ReadModel *read = [[ReadModel alloc]init];
        [read setValuesForKeysWithDictionary:dic1];
        [arr addObject:read];
    }
    return arr;
}


+(NSMutableArray *)itemModelConfigure:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = dic[@"data"];
    NSArray *list = dataDic[@"list"];
    for (NSDictionary *dic1 in list) {
        ReadModel *model = [[ReadModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
    

}







@end
