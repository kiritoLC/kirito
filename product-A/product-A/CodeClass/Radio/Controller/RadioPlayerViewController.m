//
//  RadioPlayerViewController.m
//  product-A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RadioPlayerViewController.h"
#import "RadioDetailLastModel.h"
#import "NSString+Html.h"
#import "DownLoadManager.h"
#import "DownLoad.h"
#import "MyplayerManager.h"



@interface RadioPlayerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIScrollView *src;

@property(nonatomic,strong)UISlider *slider;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)UILabel *titel;

@property(nonatomic,strong)UIImageView *imageV;

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)UIImageView *imageV1;

@property(nonatomic,strong)UILabel *nowTime;

@property(nonatomic,strong)UILabel *allTime;

@property(nonatomic,strong)CABasicAnimation *basic;


@property(nonatomic,strong)UITableView *downLoadTableView;

@property(nonatomic,strong)NSMutableArray *downLoadModelArr;

@end

@implementation RadioPlayerViewController


-(NSMutableArray *)downLoadModelArr
{
    if (!_downLoadModelArr) {
        _downLoadModelArr = [NSMutableArray array];
    }
    return _downLoadModelArr;
}




-(UILabel *)nowTime
{
    if (!_nowTime) {
        _nowTime = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-self.titel.frame.origin.y+50, kScreenWidth/5, 50)];
    }
    return _nowTime;
}


-(UILabel *)allTime
{
    if (!_allTime) {
        _allTime = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*4/5, kScreenHeight-self.titel.frame.origin.y+50, kScreenWidth/5, 50)];

    }
    return _allTime;
}






-(void)timerAction
{
    if ([VideoManager sharInstance].player.currentTime.timescale==0||[VideoManager sharInstance].player.currentItem.duration.timescale==0) {
        return;
    }
    
    long long int currentTime = [VideoManager sharInstance].player.currentTime.value/[VideoManager sharInstance].player.currentTime.timescale;

    long long int allTime  = [VideoManager sharInstance].player.currentItem.duration.value/[VideoManager sharInstance].player.currentItem.duration.timescale;
    
    self.nowTime.text = [NSString stringWithFormat:@"%02lld:%02lld",currentTime/60,currentTime%60];
    self.allTime.text = [NSString stringWithFormat:@"%02lld:%02lld",allTime/60,allTime%60];
    

    self.slider.maximumValue = allTime;
    
    self.slider.value = currentTime;
    
    if (self.slider.value>=allTime-1) {
        
        
        
         NSInteger index = [VideoManager sharInstance].index;
        
        RadioDetailLastModel *model = [VideoManager sharInstance].arr[index];
        
        model.isPlaying = !model.isPlaying;
        
        [[VideoManager sharInstance]playerAutoNext];
        
        index = [VideoManager sharInstance].index;

        model = [VideoManager sharInstance].arr[index];
        
        [[VideoManager sharInstance]playerReplaceItemWithUrlstring:model.musicUrl];
        
        self.titel.text = model.title;
        
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
        
        [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:model.webview_url]]];
        
        [self.imageV1 sd_setImageWithURL:[NSURL URLWithString:model.coverimg] completed:nil];
        
        
        
        model.isPlaying = !model.isPlaying;
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
     [VideoManager sharInstance].isplay = self.isplay;
  
    
    NSInteger index = [VideoManager sharInstance].index;
    RadioDetailLastModel *model = [VideoManager sharInstance].arr[index];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    [self.timer fire];
    
    self.src = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KNaviH+21, kScreenWidth, kScreenHeight)];
    
    self.src.contentSize = CGSizeMake(kScreenWidth*3, kScreenHeight);
    
    self.src.showsVerticalScrollIndicator=NO;
    
    self.src.showsHorizontalScrollIndicator = NO;
    
    self.src.pagingEnabled = YES;
    
    self.src.bounces = NO;
    
    self.src.contentOffset = CGPointMake(kScreenWidth, 0);

    UIView *viewplayer = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    
    self.imageV1 = [[UIImageView alloc]initWithFrame:viewplayer.frame];
    
    [self.imageV1 sd_setImageWithURL:[NSURL URLWithString:model.coverimg] completed:nil];
    
    UIToolbar *blur = [[UIToolbar alloc]init];
    
    blur.barStyle = UIBarStyleBlack;
    
    blur.frame = self.imageV1.bounds;
    
    [self.imageV1 addSubview:blur];
    
    [self.src addSubview:self.imageV1];
    
    [self.src addSubview:viewplayer];
    
    
    
    
#pragma mark ---左侧webView
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.htmlUrl = [NSString importStyleWithHtmlString:self.htmlUrl];
    
    [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:model.webview_url]]];
    
    
    [self.src addSubview:self.webView];

#pragma mark ---图片
    
   self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-(kScreenHeight-64)*2/5)/2, (kScreenHeight)/10, (kScreenHeight-64)*2/5, (kScreenHeight-64)*2/5)];
    
    self.imageV.layer.masksToBounds = YES;
    
    self.imageV.layer.cornerRadius =(kScreenHeight-64)*2/5/2;
    
    
    self.basic = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
     self.basic.toValue = [NSNumber numberWithFloat:M_PI*2];
    
     self.basic.duration = 8.888;
    
     self.basic.repeatCount = FLT_MAX;

    [self.imageV.layer addAnimation: self.basic forKey:nil];

    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
    
    [viewplayer addSubview:self.imageV];
    
    
    
#pragma mark --- 标题
    self.titel = [[UILabel alloc]init];
    
    self.titel.frame = CGRectMake(0,kScreenHeight-self.imageV.frame.origin.y-self.imageV.frame.size.height-30, kScreenWidth, 50);
    
    self.titel.textAlignment = NSTextAlignmentCenter;
    
    self.titel.font = [UIFont systemFontOfSize:17];
    
    self.titel.textColor = [UIColor whiteColor];

    self.titel.text = model.title;
    
    [viewplayer addSubview:self.titel];
    
    
#pragma mark ---进度条
    
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(kScreenWidth/5, kScreenHeight-self.titel.frame.origin.y+50, kScreenWidth*3/5, 10)];
    
    [self.slider addTarget:self action:@selector(changeSlider) forControlEvents:(UIControlEventValueChanged)];
    
    [viewplayer addSubview:self.slider];
    

#pragma mark ---时间
    
    [viewplayer addSubview:self.nowTime];
    [viewplayer addSubview:self.allTime];

#pragma mark --- 下载按钮
    UIButton *downBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    downBtn.frame = CGRectMake(kScreenWidth/2-25, kScreenHeight-self.titel.frame.origin.y+50+20, 50, 50);
    
    [downBtn addTarget:self action:@selector(down) forControlEvents:(UIControlEventTouchUpInside)];
    
    [downBtn setImage:[[UIImage imageNamed:@"downloading2"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    
    [viewplayer addSubview:downBtn];
    
#pragma mark ---小线
    
    UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/10,self.slider.frame.origin.y+80, kScreenWidth*8/10, 1)];
    
    xian.backgroundColor = [UIColor blackColor];
    
    [viewplayer addSubview:xian];
    
#pragma mark ---播放按钮/暂停
    
    if ([VideoManager sharInstance].isplay) {
        
        [self.button setImage:[[UIImage imageNamed:@"play"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        
    }else
    {
        
        [self.button setImage:[[UIImage imageNamed:@"pause"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        
    }
    
    [VideoManager sharInstance].isplay = YES;
    
    [ self.button addTarget:self action:@selector(play:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [viewplayer addSubview: self.button];
    
     self.button.frame = CGRectMake(kScreenWidth/2-25,xian.frame.origin.y+20, 50, 50);
    
    [self.view addSubview:self.src];

#pragma mark ---上一首按钮
    UIButton *aboveBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    [aboveBtn addTarget:self action:@selector(above:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [aboveBtn setImage:[[UIImage imageNamed:@"aboveMusic"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    
    aboveBtn.frame = CGRectMake(kScreenWidth/8, xian.frame.origin.y+20, 50, 50);
    
    [viewplayer addSubview:aboveBtn];
    
#pragma mark ---下一首按钮
    
    UIButton *nextBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    [nextBtn addTarget:self action:@selector(next:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [nextBtn setImage:[[UIImage imageNamed:@"nextMusic.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    
    nextBtn.frame = CGRectMake(kScreenWidth*6/8, xian.frame.origin.y+20, 50, 50);
    
    [viewplayer addSubview:nextBtn];
    
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 40)];
    
    [button1 addTarget:self action:@selector(returen) forControlEvents:(UIControlEventTouchUpInside)];
    
    [button1 setTitle:@"aa" forState:(UIControlStateNormal)];
    
    [button1 setImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]forState:(UIControlStateNormal)];
    
    button1.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:button1];
    
#pragma mark ---右侧 下载栏目
    self.downLoadModelArr = [VideoManager sharInstance].arr;
    
    self.downLoadTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight)style:(UITableViewStylePlain)];
    
    
    self.downLoadTableView.delegate = self;
    
    self.downLoadTableView.dataSource =self;
    
    self.downLoadTableView.backgroundColor = [UIColor redColor];
    
    self.downLoadTableView.rowHeight = 150;
    
    
    [self.src addSubview:self.downLoadTableView];
    
    
}


#pragma mark --- 右侧下载栏的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.downLoadModelArr.count;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RadioDetailLastModel *model = self.downLoadModelArr[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"ss"];
        
    }
    
    cell.textLabel.text = model.title;
    
    cell.detailTextLabel.text = model.uname;
    
    return cell;
}





-(void)changeSlider
{
    [[VideoManager sharInstance]playerprogressWithSliderValue:self.slider.value];
}

-(void)returen
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)play:(UIButton *)btn
{
    
    
    
    [[VideoManager sharInstance] playerplayAndPause];
    
    
    if ([VideoManager sharInstance].isplay == YES) {
        
        [btn setImage:[[UIImage imageNamed:@"pause"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        
        
        [self.imageV.layer addAnimation:self.basic forKey:nil];

    }else{
        
        [btn setImage:[[UIImage imageNamed:@"play"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        
        [self.imageV.layer removeAllAnimations];
        
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"setimage" object:nil];
    
    
    
    
    
}

-(void)above:(UIButton *)btn
{
      [self.imageV.layer removeAllAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger index = [VideoManager sharInstance].index;
        
        RadioDetailLastModel *model = [VideoManager sharInstance].arr[index];
        
        model.isPlaying= !model.isPlaying;
        
        
        [[VideoManager sharInstance]playerAbove];
        
        index = [VideoManager sharInstance].index;
        
        model = [VideoManager sharInstance].arr[index];
        
        model.isPlaying= !model.isPlaying;
        
        [[VideoManager sharInstance]playerReplaceItemWithUrlstring:model.musicUrl];
        
        self.titel.text = model.title;
        
        
        
        
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
        
        [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:model.webview_url]]];
        
        [self.imageV1 sd_setImageWithURL:[NSURL URLWithString:model.coverimg] completed:nil];
        
        
        if (model.isPlaying==YES) {
            
            
            [self.button setImage:[[UIImage imageNamed:@"pause"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
            
            
            [self.imageV.layer addAnimation:self.basic forKey:nil];
            
        }else
        {
            
            [self.button setImage:[[UIImage imageNamed:@"play"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
            
        }
    });
   


}

-(void)next:(UIButton *)btn
{
    
    [self.imageV.layer removeAllAnimations];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSInteger index = [VideoManager sharInstance].index;
        
        RadioDetailLastModel *model = [VideoManager sharInstance].arr[index];
        
        model.isPlaying= !model.isPlaying;
        
        [[VideoManager sharInstance]playerAutoNext];
        
        index = [VideoManager sharInstance].index;
        
        model = [VideoManager sharInstance].arr[index];
        
        model.isPlaying= !model.isPlaying;
        
        self.titel.text = model.title;
        
        [[VideoManager sharInstance]playerReplaceItemWithUrlstring:model.musicUrl];
        
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
        
        [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:model.webview_url]]];
        
        [self.imageV1 sd_setImageWithURL:[NSURL URLWithString:model.coverimg] completed:nil];
        
        if (model.isPlaying==YES) {
            
            [self.button setImage:[[UIImage imageNamed:@"pause"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
            
            [self.imageV.layer addAnimation:self.basic forKey:nil];
            
        }else
            
        {
            
            [self.button setImage:[[UIImage imageNamed:@"play"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        }
        
    });

}

-(void)down
{
    
    RadioDetailLastModel *model = [VideoManager sharInstance].arr[[VideoManager sharInstance].index];
    
    NSString *url = model.musicUrl;
    
    DownLoadManager *manager = [DownLoadManager defaultManager];
    
    DownLoad *task = [manager creatDownload:url];
    
    [task start];
    
    [task monitorDownload:^(long long bytesWritten, NSInteger progress, long long allTimes) {
        
        NSLog(@"%ld",(long)progress);
        
    } DidDownload:^(NSString *savePath, NSString *url) {
        
        NSLog(@"+++++++++%@",savePath);
        
        MusicDownloadTable *table = [[MusicDownloadTable alloc]init];
        
        [table creatTable];
        
        [table insertIntoTable:@[model.title,model.musicUrl,model.imgUrl,savePath,model.uname]];
        
        NSLog(@"%@",savePath);
        
    }];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (RadioDetailLastModel *model in [VideoManager sharInstance].arr) {
        model.isPlaying=NO;
        
    }
    
    RadioDetailLastModel *model = [VideoManager sharInstance].arr[indexPath.row];
    
    model.isPlaying = YES;
    
    [[VideoManager sharInstance]playerReplaceItemWithUrlstring:model.musicUrl];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
    
    [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:model.webview_url]]];
    
    [self.imageV1 sd_setImageWithURL:[NSURL URLWithString:model.coverimg] completed:nil];
    
    [self.button setImage:[[UIImage imageNamed:@"pause"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
    
     [self.imageV.layer removeAllAnimations];
    
    [UIView animateWithDuration:1 animations:^{
        
           self.src.contentOffset = CGPointMake(kScreenWidth*1, 0);
        
    } completion:^(BOOL finished) {
        
        self.src.contentOffset = CGPointMake(kScreenWidth*1, 0);
        
    }];
    
    [self.imageV.layer addAnimation:self.basic forKey:nil];
   
}


@end
