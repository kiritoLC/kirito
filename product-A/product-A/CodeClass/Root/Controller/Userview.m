//
//  Userview.m
//  product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "Userview.h"
#import "LoginViewController.h"
#import "UserInfoManager.h"
#import "DownViewController.h"


@implementation Userview




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)uiimageV:(id)sender {
    
}

- (IBAction)login:(id)sender {
    
    
    LoginViewController *loginView = [[LoginViewController alloc]init];
    UINavigationController *loginNave = [[UINavigationController alloc]initWithRootViewController:loginView];
    
    
    loginView.loginSucess=^(){
        
        
        [self.login setTitle:[UserInfoManager getUserName] forState:(UIControlStateNormal)];
       
        [self.imagev sd_setImageWithURL:[NSURL URLWithString:[UserInfoManager getUserIcon]]];
        
    };
    
    
    
    [self.RootVC presentViewController:loginNave animated:YES completion:nil];
}


- (IBAction)downLoad:(id)sender {
    
    
    DownViewController *vc = [[DownViewController alloc]init];
    
    MusicDownloadTable *table = [[MusicDownloadTable alloc]init];
    
    vc.modelArr  = [[table selectAll]mutableCopy];;
    
    [self.RootVC  presentViewController:vc animated:YES completion:nil];
    
    
}

- (IBAction)love:(id)sender {
    
    
}


- (IBAction)comments:(id)sender {
    
    
}

- (IBAction)edit:(id)sender {
    
    
}







@end
