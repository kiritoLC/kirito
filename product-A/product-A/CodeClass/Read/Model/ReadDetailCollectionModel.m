//
//  ReadDetailCollectionModel.m
//  product-A
//
//  Created by lanou on 16/6/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ReadDetailCollectionModel.h"

@implementation ReadDetailCollectionModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



+(NSMutableArray *)modelComfigure:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    
    
    NSArray *listArr = dataDic[@"list"];
    for ( NSDictionary *dica in listArr) {
        ReadDetailCollectionModel *model = [[ReadDetailCollectionModel alloc]init];
        [model setValuesForKeysWithDictionary:dica];
        [arr addObject:model];
    }
    return arr;
}


@end
