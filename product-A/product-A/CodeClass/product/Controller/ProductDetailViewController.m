//
//  ProductDetailViewController.m
//  product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()
@property (nonatomic , strong)UIWebView *web;
@property (nonatomic , strong)UIButton *btn;
@end

@implementation ProductDetailViewController
-(UIButton *)button{
    
    if (!_btn) {
        
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20 + 10, 20, 20)];
        
        [_btn setImage:[UIImage imageNamed:@"u9_start"] forState:(UIControlStateNormal)];
        
        [_btn setTitleColor:PKCOLOR(25, 25, 25)forState:(UIControlStateNormal)];
        
        [_btn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    
    return _btn;
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.btn];
    
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, KNaviH+21, kScreenWidth, kScreenHeight-60)];
    
    NSDictionary *dic =@{ @"auth":@"XZU7RH7m1861DC8Z8H8HvkTJxQMGoPLGO9zo4XDA0cWP22NdFSh9d7fo",@"client":@"1",@"contentid":self.contentid,@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31",@"version":@"3.0.6"};
    
    [RequestManager requestWithURLString:KGooDDetailURL pardic:dic requesttype:RequestPOST finish:^(NSData *data) {
        
        NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSDictionary *data1 = dic2[@"data"];
        
        NSDictionary *post = data1[@"postsinfo"];
        
        NSDictionary *share = post[@"shareinfo"];
        
        NSString *url = share[@"url"];
        
        [self.web loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]]];
        
        [self.view addSubview:self.web];

    } error:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
    
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
