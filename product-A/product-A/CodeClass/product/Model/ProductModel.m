//
//  ProductModel.m
//  product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigure:(NSDictionary *)dic
{
    NSMutableArray *arr1 = [NSMutableArray array];
    
    NSDictionary *dataDic = dic[@"data"];
    
    NSArray *arr = dataDic[@"list"];
    
    for (NSDictionary *dic1 in arr) {
        ProductModel *model = [[ProductModel alloc]init];
        [model setValuesForKeysWithDictionary:dic1];
        [arr1 addObject:model];
    }
    return arr1;
    
  
}

@end
