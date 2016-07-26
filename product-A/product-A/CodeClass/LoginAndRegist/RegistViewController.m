//
//  RegistViewController.m
//  product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RegistViewController.h"
#import "UserInfoManager.h"
@interface RegistViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>


{
    NSInteger _gender;
}

@property (strong, nonatomic) IBOutlet UITextField *mailTextField;

@property (strong, nonatomic) IBOutlet UITextField *pwdTextField;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@property (nonatomic,strong) UIImage *uploadImage;


@end

@implementation RegistViewController
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger inter = textField.tag;
    
    if (inter != 3) {
        
         UITextField *nextFT = [self.view viewWithTag:inter+1];
        
        [nextFT becomeFirstResponder];
        
    }else
    {
        [textField resignFirstResponder];
    
    }
    

    return YES;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.pwdTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.mailTextField resignFirstResponder];
    

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.imageBtn.layer setMasksToBounds:YES];
    
    [self.imageBtn.layer setCornerRadius:25];
    
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    [btn setTitle:@"返回" forState:(UIControlStateNormal)];
    
    [btn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    btn.frame = CGRectMake(5, 30, 50, 30);
    
    [self.view addSubview:btn];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.nameTextField.delegate =self;
    
    self.nameTextField.tag = 1;
    
    self.pwdTextField.delegate =self;
    
    self.pwdTextField.tag = 3;
    
    self.mailTextField.delegate =self;
    
    self.mailTextField.tag = 2;
    
}





- (IBAction)man:(id)sender {
    
    _gender = 0;
    
 
}
- (IBAction)women:(id)sender {
    
    _gender = 1;
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark ----键盘回收方法



-(void)keyboardShow:(NSNotification *)note
{
    NSLog(@"键盘将要出现");
    
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] integerValue] animations:^{
        
        CGRect nerRect = [note.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        [UIView animateWithDuration:[note.userInfo [UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            
             self.view.transform = CGAffineTransformMakeTranslation(0, -nerRect.size.height+100);
            
        }];
        
    }];
    
    NSLog(@"%@",note);
}

-(void)keyboardHide:(NSNotification *)note
{
    
    NSLog(@"键盘将要消失");
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] integerValue] animations:^{
        
        self.view.transform = CGAffineTransformIdentity;
    
    }];
    
}









- (IBAction)zhuce:(id)sender {
    
//    NSDictionary *parDic = @{@"email":_mailTextField.text,@"gender":[NSNumber numberWithInteger:_gender],@"passwd":_pwdTextField.text,@"uname":[_nameTextField.text stringByReplacingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)]};
//
//   [RequestManager requestWithURLString:kRegistUrl pardic:parDic requesttype:RequestPOST finish:^(NSData *data) {
//       
//       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//       
//       if ([dic[@"result"] integerValue] == 0) {
//           NSLog(@"%@",dic[@"data"][@"msg"]);
//       }
//       else{
//           // icon uid uname auth
//           [UserInfoManager conserveUserIcon:dic[@"data"][@"icon"]];
//           [UserInfoManager conserveUserID:dic[@"data"][@"uid"]];
//           [UserInfoManager conserveUserName:dic[@"data"][@"uname"]];
//           [UserInfoManager conserveUserAuth:dic[@"data"][@"auth"]];
//           [self.navigationController popViewControllerAnimated:YES];
//       }
//   } error:^(NSError *error) {
//       NSLog(@"%@",error);
//   }];
    
    if (self.nameTextField.text.length==0||self.mailTextField.text.length==0||self.pwdTextField.text==0) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"密码 昵称 邮箱不能为空" message:@"请将信息填写完整" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:nil];
       
        [ac addAction:act];
       
        
        [self presentViewController:ac animated:YES completion:nil];
        
    }else
    {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        // 如果请求出现content-Type相关错误 用一些两种方案解决
        
        // 应该适用于一切出现content-type的相关错误案例 但请求成功成功后返回值转换成NSData，可读性不强
        
        [manager POST:kRegistUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFormData:[self.mailTextField.text dataUsingEncoding:NSUTF8StringEncoding] name:@"email"];
            
            [formData appendPartWithFormData:[self.nameTextField.text dataUsingEncoding:NSUTF8StringEncoding] name:@"uname"];
            
            [formData appendPartWithFormData:[self.pwdTextField.text dataUsingEncoding:NSUTF8StringEncoding] name:@"passwd"];
            
            [formData appendPartWithFormData:[[NSString stringWithFormat:@"%ld",(long)_gender]dataUsingEncoding:NSUTF8StringEncoding] name:@"gender"];
            
            [formData appendPartWithFileData:UIImagePNGRepresentation(self.uploadImage) name:@"iconfile" fileName:@"uploadheadimage.png" mimeType:@"image/png"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            NSLog(@"%lf",1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSLog(@"%@",dic);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            
        }];

    }
  
}

    




//        if ([dic[@"result"] integerValue] == 0) {
//            NSLog(@"%@",dic[@"data"][@"msg"]);
//        }
//        else{
//            // icon uid uname auth
//            [UserInfoManager conserveUserIcon:dic[@"data"][@"icon"]];
//            [UserInfoManager conserveUserID:dic[@"data"][@"uid"]];
//            [UserInfoManager conserveUserName:dic[@"data"][@"uname"]];
//            [UserInfoManager conserveUserAuth:dic[@"data"][@"auth"]];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        
//    } error:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    

// 选取照片方法
- (IBAction)selectImage:(id)sender {
    
    // 默认只打开相册
    
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
        
        UIImagePickerController *pc = [[UIImagePickerController alloc]init];
        
        pc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        pc.allowsEditing = YES;
        
        pc.delegate = self;
        
        [self presentViewController:pc animated:YES completion:^{
            NSLog(@"移除控件");
            
        }];
        
    }else
        
    {
        
        NSLog(@"你没有相册");
        
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
//    NSLog(@"%@",info);
    
    [self.imageBtn setBackgroundImage:  info[UIImagePickerControllerEditedImage] forState:(UIControlStateNormal)];
    
    
    self.uploadImage = info[UIImagePickerControllerEditedImage];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
