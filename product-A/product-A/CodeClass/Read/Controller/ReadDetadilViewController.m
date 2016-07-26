//
//  ReadDetadilViewController.m
//  product-A
//
//  Created by lanou on 16/6/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ReadDetadilViewController.h"
#import "NSString+Html.h"
@interface ReadDetadilViewController ()

@end

@implementation ReadDetadilViewController


- (void)viewDidLoad {
        
        [super viewDidLoad];
        
        [self createWebView];
        
    }
    
-(void)createWebView
    {
        
        NSString *string = [self.html componentsSeparatedByString:@"/"][3];
        
        NSMutableDictionary *dic = [@{@"contentid":@"54603f3d8ead0e195000028e",@"client":@"1",@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0",@"version":@"3.0.2"} mutableCopy];
        
        [dic setObject:string forKey:@"contentid"];
        
        [RequestManager requestWithURLString:kReadDetail pardic:dic requesttype:RequestPOST finish:^(NSData *data) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSDictionary *dict = dic[@"data"];
            
            NSString *html = dict[@"html"];
            
            html = [NSString importStyleWithHtmlString:html];
            
            UIWebView *webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, 63, kScreenWidth, kScreenHeight)];
            [webV loadHTMLString:html baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
            [self.view addSubview:webV];
            
            
        } error:^(NSError *error) {
            
            NSLog(@"error == %@", error);
            
        }];
        
        self.titleLabel.text = @"阅读";
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 40)];
        
        [button addTarget:self action:@selector(returen) forControlEvents:(UIControlEventTouchUpInside)];
        
        [button setTitle:@"aa" forState:(UIControlStateNormal)];
        
        [button setImage:[UIImage imageNamed:@"return"] forState:(UIControlStateNormal)];
        
        button.backgroundColor = [UIColor whiteColor];
       
        [self.view addSubview:button];

    }





















-(void)returen
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
