//
//  ReadModel.h
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadModel : NSObject

@property(nonatomic,strong)NSString *img;

@property(nonatomic,strong)NSString *url;

@property(nonatomic,strong)NSString *coverimg;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *enname;

@property(nonatomic,assign)NSInteger type;


+(NSMutableArray *)ModelConfigure:(NSDictionary *)dic;

+(NSMutableArray *)itemModelConfigure:(NSDictionary *)dic;


@end
