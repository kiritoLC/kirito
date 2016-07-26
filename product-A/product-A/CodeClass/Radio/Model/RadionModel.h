//
//  RadionModel.h
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadionModel : NSObject

@property(nonatomic,strong)NSString *img;

@property(nonatomic,strong)NSString *coverimg;

@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *radioid;



+(NSMutableArray *)modelConfigure:(NSDictionary *)dic;

+(NSMutableArray *)collectionModelConfigure:(NSDictionary *)dic;

+(NSMutableArray *)tableModelConfigure:(NSDictionary *)dic;

@end
