//
//  VideoManager.m
//  Mplayer
//
//  Created by lanou on 16/6/10.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "VideoManager.h"

@implementation VideoManager
+(VideoManager *)sharInstance
{
    static VideoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VideoManager alloc]init];
    });
    return manager;
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.player = [[AVPlayer alloc]init];
    }
    return self;

}



-(void)playerPlay{
    [self.player play];
    self.isplay = YES;

}

-(void)playerPause
{
    [self.player pause];
    self.isplay = NO;


}


#pragma mark ---修改音量
-(void)playerVolumWithValue:(CGFloat )silderValue
{
    self.player.volume = silderValue;


}


#pragma mark ---切换歌曲

-(void)playerReplaceItemWithUrlstring:(NSString *)urlstring
{
    
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:urlstring]];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    [self.player play];
    
    self.isplay=YES;
    
    
    
    
    self.BLOCK();
    
}

#pragma mark ---控制进度
-(void)playerprogressWithSliderValue:(CGFloat)sliderValue
{
    
    [self.player seekToTime:CMTimeMakeWithSeconds(sliderValue, 1)completionHandler:^(BOOL finished) {
        
        [self playerPlay];
        
    }];

}
#pragma mark ---播放和暂停
-(void)playerplayAndPause
{
    
    if (self.isplay == YES) {
        
        [self playerPause];
        
    } else {
        
        [self playerPlay];
        
    }
    
}
#pragma mark ---上一首
-(void)playerAbove
{
    if (self.index == 0) {
        
        self.index = self.arr.count-1;
        
    }else
        
    {
        
        self.index = self.index-1;
        
    }
}
#pragma mark ---下一首
-(void)playerAutoNext
{
    if (self.index == self.arr.count-1) {
        self.index = 0;
    }
    else
    {
        self.index++;
    }
    
}











@end
