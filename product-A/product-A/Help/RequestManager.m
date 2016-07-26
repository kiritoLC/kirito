//
//  RequestManager.m
//  UILessoncocopods
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RequestManager.h"


@implementation RequestManager

+(void)requestWithURLString:(NSString *)urlstring pardic:(NSDictionary *)pardic requesttype:(RequestType)requestType finish:(Finih)finsh error:(Error)error
{
    RequestManager *manaager  = [[RequestManager alloc]init];
    [manaager requestWithURLString:urlstring pardic:pardic requesttype:requestType finish:finsh error:error];


}

-(void)requestWithURLString:(NSString *)urlstring pardic:(NSDictionary *)pardic requesttype:(RequestType)requestType finish:(Finih)finsh error:(Error)error
{
    self.finish = finsh;
    self.error = error;
    
    AFHTTPSessionManager *manage  = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (requestType == requestGET) {
        [manage GET:urlstring parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self finishRequestReturnMainThread:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.error(error);
        }];
        
    }else
    {
        [manage POST:urlstring parameters:pardic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self finishRequestReturnMainThread:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.error(error);
        }];
    }
}

-(void)finishRequestReturnMainThread:(NSData *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.finish(data);
    });


}









@end
