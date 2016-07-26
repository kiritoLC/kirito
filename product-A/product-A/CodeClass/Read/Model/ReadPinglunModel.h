//
//  ReadPinglunModel.h
//  product-A
//
//  Created by lanou on 16/7/4.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadPinglunModel : NSObject

@property (nonatomic,strong)NSString *icon;

@property (nonatomic,strong)NSString *addtime_f;

@property (nonatomic,strong)NSString *uname;

@property (nonatomic,assign)NSInteger uid;

@property (nonatomic,strong)NSString *content;

@property(nonatomic,assign)BOOL isdel;

@property(nonatomic,strong)NSString *contentid;

+ (NSMutableArray *)conmentModelConfigureJson:(NSDictionary *)jsonDic;





@end
