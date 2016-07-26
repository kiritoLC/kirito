//
//  MusicDownloadTable.h
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBManager.h"


@interface MusicDownloadTable : NSObject



@property(nonatomic , strong)FMDatabase *dataBase;



//建表
-(void)creatTable;
//插入
-(void)insertIntoTable:(NSArray *)Info;
//取出
-(NSArray *)selectAll;












@end
