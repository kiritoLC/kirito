//
//  RadionDetailModel.m
//  product-A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RadionDetailModel.h"

@implementation RadionDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}




+(RadionDetailModel *)upModelConfigure:(NSDictionary *)jsonDic
{
  
    NSDictionary *dataDic = jsonDic[@"data"];
    NSDictionary *radionInfoDic  = dataDic[@"radioInfo"];
    RadionDetailModel *model = [[RadionDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:radionInfoDic];
    
    return model;
    
    

}





@end
