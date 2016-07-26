//
//  ProductModel.h
//  product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject


@property(nonatomic,strong)NSString *coverimg;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *buyurl;
@property(nonatomic , strong)NSString *contentid;



+(NSMutableArray *)modelConfigure:(NSDictionary *)dic;

@end
