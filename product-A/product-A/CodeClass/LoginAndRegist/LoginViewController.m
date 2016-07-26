//
//  LoginViewController.m
//  product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "UserInfoManager.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *email;

@property (strong, nonatomic) IBOutlet UITextField *password;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden  = YES;
    
}


- (IBAction)back:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)regist:(id)sender {
    
    
    RegistViewController *regisView = [[RegistViewController alloc]init];
    
    [self.navigationController pushViewController:regisView animated:YES];

    
}


- (IBAction)login:(id)sender {
    
    NSDictionary *parms =@{@"email":_email.text,@"passwd":_password.text};
    [RequestManager requestWithURLString:kLoginUrl pardic:parms requesttype:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([dic[@"result"] integerValue] == 0) {
            NSLog(@"%@",dic[@"data"][@"msg"]);
        }
        else{
            
            
            [UserInfoManager conserveUserAuth:dic[@"data"][@"auth"]];
            
            [UserInfoManager conserveUserIcon:dic[@"data"][@"icon"]];
            
            [UserInfoManager conserveUserID:dic[@"data"][@"uid"]];
            
            [UserInfoManager conserveUserName:dic[@"data"][@"uname"]];
            
            
            
            
        }
        if (self.loginSucess) {
            
            self.loginSucess();
        }
        

   [self dismissViewControllerAnimated:YES completion:nil];
        
        
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    /*  
     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     
     NSLog(@"%@",dic);
     
     
     if ([dic[@"result"] integerValue] == 0) {
     NSLog(@"%@",dic[@"data"][@"msg"]);
     }
     
     else{
     
     [UserInfoManager conserveUserAuth:dic[@"data"][@"auth"]];
     
     [UserInfoManager conserveUserIcon:dic[@"data"][@"icon"]];
     
     [UserInfoManager conserveUserID:dic[@"data"][@"uid"]];
     
     [UserInfoManager conserveUserName:dic[@"data"][@"uname"]];
     }
     
     if (self.loginSucess) {
     
     self.loginSucess();
     }
     
     
    
*/
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
