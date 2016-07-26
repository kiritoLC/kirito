//
//  MyplayerManager.m
//  product-A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyplayerManager.h"

@implementation MyplayerManager

+(MyplayerManager *)shareMyplayer
{
    static MyplayerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MyplayerManager alloc]init];
    });
    return manager;

}

-(instancetype)init{
    self = [super init];
    if (self) {
        _playtype = Listplay;
        _playstate = Pause;
    }
    return self;
}

-(void)setMusicLists:(NSMutableArray *)musicList{
    [musicList removeAllObjects];
    self.musicList = [musicList mutableCopy];
    AVPlayerItem *avplayerItem =[AVPlayerItem playerItemWithURL:_musicList[_index]];
    
    if (!_avplayer) {
        self.avplayer = [[AVPlayer alloc]initWithPlayerItem:avplayerItem];
    }else{
        [self.avplayer replaceCurrentItemWithPlayerItem:avplayerItem];
    }
}

// 播放
-(void)play{
    
    [_avplayer play];
    _playstate = Play;
    
}

// 暂停
-(void)pause
{
    [_avplayer pause];
    _playstate = Pause;

}

// 停止
-(void)stop{
    
    [self seekToSecondsWith:0];
    _playstate = Pause;
    
}

-(void)seekToSecondsWith:(float)second{
    
    CMTime newTime = _avplayer.currentTime;
    newTime.value = newTime.timescale *second;
    [_avplayer seekToTime:newTime];
    
}

#pragma mark ---获取时间

-(float)currentime{
    
    if (_avplayer.currentTime.timescale ==0) {
        return 0;
    }
    
    return _avplayer.currentTime.value/_avplayer.currentTime.timescale;
}

-(float)totalTime{
    
    if (_avplayer.currentItem.duration.timescale==0) {
        return 0;
    }
    
    return _avplayer.currentItem.duration.value/_avplayer.currentItem.duration.timescale;
}


-(void)lastMusic{
    
    if (self.playtype == Randomplay) {
        _index = arc4random()%self.musicList.count;
    }else{
        if (_index == 0) {
            _index = _musicList.count-1;
        }
        _index--;
  
    }
    [self changeMusicWith:_index];
}

-(void)nextMusic{
    
    if (self.playtype == Randomplay) {
        _index = arc4random()%self.musicList.count;
    }else
    {
        if (_index==_musicList.count-1) {
            _index = 0;
        }
        _index++;
    }
     [self changeMusicWith:_index];
}


// 根据index来切歌
-(void)changeMusicWith:(NSInteger )index{
    
    _index = index;
    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:_musicList[index]]];
    [_avplayer replaceCurrentItemWithPlayerItem:playerItem];
    [self play];
    
}


-(void)playerDidFinish{
    
    if (_playtype == SingelPlay) {
        [self pause];
    }else{
        [self nextMusic];
    }
    
}








@end
