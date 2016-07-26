//
//  DownLoadManager.m
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DownLoadManager.h"

static DownLoadManager *manger = nil;
@interface DownLoadManager()<DownLoadDelegate>
@property (nonatomic , strong)NSMutableDictionary *dic;//存放下载任务

@end

@implementation DownLoadManager

+(DownLoadManager *)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger  = [[DownLoadManager alloc]init];
    });
    return manger;
}

-(NSMutableDictionary *)dic
{
    if (!_dic) {
        _dic = [[NSMutableDictionary alloc]init];
    }
    return _dic;
}

-(DownLoad *)creatDownload:(NSString *)url
{
    DownLoad *task = self.dic[url];
    if (!task) {
        task = [[DownLoad alloc]initWith:url];
        [self.dic setValue:task forKey:url];
    }
    task.delegate = self;
    return task;
}

-(void)removeDownloadTask:(NSString *)url
{
    [self.dic removeObjectForKey:url];
}






@end
