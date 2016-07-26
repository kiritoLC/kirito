//
//  DBManager.h
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FMDatabase.h>

@interface DBManager : NSObject

@property(nonatomic , strong)FMDatabase *dataBase;

+(DBManager *)shareManager;

//关闭数据库
-(void)close;

@end
