//
//  ReadPinglunModel.m
//  product-A
//
//  Created by lanou on 16/7/4.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ReadPinglunModel.h"

@implementation ReadPinglunModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (NSMutableArray *)conmentModelConfigureJson:(NSDictionary *)jsonDic{

NSMutableArray *array = [NSMutableArray array];

NSDictionary *dataDic = jsonDic[@"data"];

NSArray *listArray = dataDic[@"list"];

for (NSDictionary *dic in listArray) {
    
    ReadPinglunModel *model = [[ReadPinglunModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dic];
    
    NSDictionary *dic2 = dic[@"userinfo"];
    
    [model setValuesForKeysWithDictionary:dic2];
    
    [array addObject:model];
    
}

return array;

}











@end
