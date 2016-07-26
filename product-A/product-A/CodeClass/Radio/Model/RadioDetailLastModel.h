//
//  RadioDetailLastModel.h
//  product-A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioDetailLastModel : NSObject

@property(nonatomic,strong)NSString *coverimg;

@property(nonatomic,strong)NSString *musicUrl;

@property(nonatomic,strong)NSNumber *musicVisit;

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSNumber *tingid;

@property(nonatomic,strong)NSString *webview_url;

@property(nonatomic,assign)BOOL isPlaying;

@property(nonatomic,strong)NSString *uname;

@property(nonatomic,strong)NSString *imgUrl;

+(NSMutableArray *)modelConfigure:(NSDictionary *)jsonDic;


@end
