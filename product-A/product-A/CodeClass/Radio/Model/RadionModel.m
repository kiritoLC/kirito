//
//  RadionModel.m
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RadionModel.h"

@implementation RadionModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(NSMutableArray *)modelConfigure:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = dic[@"data"];
    
    NSDictionary *carouselArr = dataDic[@"carousel"];
    for (NSDictionary *dic in carouselArr) {
        RadionModel *model = [[RadionModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}


+(NSMutableArray *)collectionModelConfigure:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = dic[@"data"];
    NSArray *alllist = dataDic[@"list"];
    for (NSDictionary *dic1 in alllist) {
        RadionModel *model = [[RadionModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr addObject:model];
    }
    return arr;
 
}


+(NSMutableArray *)tableModelConfigure:(NSDictionary *)dic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = dic[@"data"];
    NSArray *hotlistArr = dataDic[@"hotlist"];
    for (NSDictionary *dic2 in hotlistArr) {
        RadionModel *model = [[RadionModel alloc]init];
        [model setValuesForKeysWithDictionary:dic2];
        [arr addObject:model];
    }
    return arr;
}







@end
