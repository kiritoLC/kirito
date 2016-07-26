//
//  MusicDownloadTable.m
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MusicDownloadTable.h"

@implementation MusicDownloadTable



- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataBase = [DBManager shareManager].dataBase;
    }
    return self;
}

- (void)creatTable
{
    // 判断是否有表存在
    NSString *query = [NSString stringWithFormat:@"select count(*) from sqlite_master where type = 'table' and name = '%@'",kDownloadTable];
    
    FMResultSet *set = [_dataBase executeQuery:query];
    
    [set next];
    
    int count = [set intForColumnIndex:0];
    
    BOOL exist = count;
    
    if (exist) {
        
        NSLog(@"%@表存在",kDownloadTable);
        
    }else{
        // 建表
        // create table 表名(给一个ID  INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL，参数)
        NSString *updata = [NSString stringWithFormat:@"create table %@(musicID  INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,title text,musicUrl text,musicImg text,musicPath text,musicName text)",kDownloadTable];
        
        BOOL result = [_dataBase executeUpdate:updata];
        
        if (result) {
            NSLog(@"%@创建成功",kDownloadTable);
        }else
        {
            NSLog(@"%@创建失败",kDownloadTable);
        }
    }
}
- (void)insertIntoTable:(NSArray *)Info
{
    NSString *updata = [NSString stringWithFormat:@"INSERT INTO %@ (title,musicUrl,musicImg,musicPath,musicName) values(?,?,?,?,?)",kDownloadTable];
    BOOL result = [_dataBase executeUpdate:updata withArgumentsInArray:Info];
    if (result) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败");
    }
}
- (NSArray *)selectAll
{
    NSString *query = [NSString stringWithFormat:@"select *from %@",kDownloadTable];
    
    FMResultSet *set = [_dataBase executeQuery:query];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[set columnCount]];
    
    while ([set next]) {
        
        NSString *title = [set stringForColumn:@"title"];
        
        NSString *musicUrl = [set stringForColumn:@"musicUrl"];
        
        NSString *musicImg = [set stringForColumn:@"musicImg"];
        
        NSString *musicPath = [set stringForColumn:@"musicPath"];
        
        NSString *musicName = [set stringForColumn:@"musicName"];
        
        [array addObject:@[title,musicUrl,musicImg,musicPath,musicName]];
        
    }
    return array;
}




@end
