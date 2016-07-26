//
//  MyplayerManager.h
//  product-A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
// 播放模式
typedef NS_ENUM(NSInteger,playType){
    
    SingelPlay,
    Randomplay,
    Listplay


};

// 播放状态

typedef NS_ENUM(NSInteger,playState) {
    
    Play,
    Pause
    
};


@interface MyplayerManager : NSObject

@property(nonatomic,assign)playType playtype;
@property(nonatomic,assign)playState playstate;
@property(nonatomic,strong)AVPlayer *avplayer;
@property(nonatomic,strong)NSMutableArray *musicList;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)float currentime;
@property(nonatomic,assign)float totalTime;







+(MyplayerManager *)shareMyplayer;



















@end
