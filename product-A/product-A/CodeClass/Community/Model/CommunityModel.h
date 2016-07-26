//
//  CommunityModel.h
//  product-A
//
//  Created by lanou on 16/7/3.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityModel : NSObject

//@property(nonatomic,assign)NSInteger addtime;
@property(nonatomic,strong)NSString *addtime_f;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *contentid;
//@property(nonatomic,strong)NSString *counterList;
@property(nonatomic,strong)NSString *coverimg;
//@property(nonatomic,strong)NSString *userinfo;
@property(nonatomic,strong)NSString *title;


#pragma mark ---counterList里面的
@property(nonatomic,assign)NSInteger comment;
@property(nonatomic,assign)NSInteger like;
@property(nonatomic,assign)NSInteger view;

#pragma mark ---userinfo里面的

@property(nonatomic,strong)NSString *icon;
@property(nonatomic,assign)NSInteger uid;
@property(nonatomic,strong)NSString *uname;





+(NSMutableArray *)modelConfigure:(NSDictionary *)jsdonDic;





@end
