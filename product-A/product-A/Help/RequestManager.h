//
//  RequestManager.h
//  UILessoncocopods
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

// 这个类的作用是基于AFNetWorking的一个二次封装
// 之前我们请求的方式使用NSURLSession 现在我们请求的方式变成AFNetWorking

// 请求方式的枚举
typedef NS_ENUM(NSInteger , RequestType) {
    requestGET, // get 请求
    RequestPOST // POST请求

};

// 请求成功回调的block
typedef void(^Finih) (NSData *data);

// 请求失败的回调的block
typedef void(^Error) (NSError *error);


@interface RequestManager : NSObject

// block属性
@property(nonatomic,copy)Finih finish;
@property(nonatomic,copy)Error error;
// 给controller 提供的接口 传进来字符串 字典 请求类型 成功block 失败blcok

+(void)requestWithURLString:(NSString *)urlstring pardic:(NSDictionary *)pardic requesttype:(RequestType)requestType finish:(Finih)finsh error:(Error)error;





@end
