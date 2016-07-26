//
//  ReadTableViewDetailViewController.m
//  product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ReadTableViewDetailViewController.h"

#import "ReadPingLunViewController.h"

#import "NSString+Html.h"

@interface ReadTableViewDetailViewController ()

@end

@implementation ReadTableViewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *BTN = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    BTN.frame = CGRectMake(kScreenWidth-100, 30, 20, 20);
    
    [BTN addTarget:self action:@selector(pinglun) forControlEvents:(UIControlEventTouchUpInside)];
    
//    BTN.backgroundColor = [UIColor redColor];
    
//    [BTN setImage:[UIImage imageNamed:@"comments"] forState:(UIControlStateNormal)];

    [BTN setBackgroundImage:[UIImage imageNamed:@"comments"] forState:(UIControlStateNormal)];
    
    [self.view addSubview:BTN];
    
    [self creatWebView];

    UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    shareBtn.frame = CGRectMake(kScreenWidth-50, 30, 20, 20);
    
    [shareBtn addTarget:self action:@selector(share) forControlEvents:(UIControlEventTouchUpInside)];
    
    [shareBtn setTitle:@"分享" forState:(UIControlStateNormal)];
    
    [self.view addSubview:shareBtn];
    
}


-(void)share
{
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"mm.jpg"]];
    
//images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]title:@"分享标题"type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        NSArray *ARR = @[@"998",@"997",@"1"];
        
        [ShareSDK showShareActionSheet:nil
                                 items:ARR
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}


}





-(void)pinglun
{
    
    ReadPingLunViewController *pinglunVC = [[ReadPingLunViewController alloc]init];
    
    pinglunVC.conmentid = self.commitID;
    
    [self.navigationController pushViewController:pinglunVC animated:YES];
    
}


-(void)creatWebView
{
    
    
    NSMutableDictionary *dic =[@{@"contentid":@"",@"client":@"1",@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0",@"version":@"3.0.2"}mutableCopy];

    [dic setObject:self.html forKey:@"contentid"];
    
    [RequestManager requestWithURLString:@"http://api2.pianke.me/article/info" pardic:dic requesttype:RequestPOST finish:^(NSData *data) {
       
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
        NSDictionary *dataDic = dic1[@"data"];
       
        
        self.html = dataDic[@"html"];
        UIWebView *wev = [[UIWebView alloc]initWithFrame:CGRectMake(0, KNaviH+21, kScreenWidth, kScreenHeight)];
      
        
        self.html= [NSString importStyleWithHtmlString:self.html];
       
        
        [wev loadHTMLString:self.html baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
        
        [self.view addSubview:wev];
        
    } error:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
   
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
