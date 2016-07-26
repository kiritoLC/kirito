//
//  ReadDetailCollectionModel.h
//  product-A
//
//  Created by lanou on 16/6/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadDetailCollectionModel : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *coverimg;
@property(nonatomic,strong)NSString *contentid;
@property(nonatomic,strong)NSString *id;


+(NSMutableArray *)modelComfigure:(NSDictionary *)jsonDic;



@end
