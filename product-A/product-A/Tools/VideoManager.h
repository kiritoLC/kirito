//
//  VideoManager.h
//  Mplayer
//
//  Created by lanou on 16/6/10.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void (^block) ();


@interface VideoManager : NSObject

@property(nonatomic,strong)NSMutableArray *arr;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)AVPlayer *player;

@property(nonatomic,assign)BOOL isplay;

@property(nonatomic,copy)block BLOCK;

+(VideoManager *)sharInstance;

#pragma mark ---修改音量
-(void)playerVolumWithValue:(CGFloat )silderValue;
#pragma mark ---切换歌曲
-(void)playerReplaceItemWithUrlstring:(NSString *)urlstring;
#pragma mark ---控制进度
-(void)playerprogressWithSliderValue:(CGFloat)sliderValue;
#pragma mark ---播放和暂停
-(void)playerplayAndPause;
#pragma mark ---上一首
-(void)playerAbove;
#pragma mark ---下一首
-(void)playerAutoNext;









@end
