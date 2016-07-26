//
//  ReadPingLunViewController.m
//  product-A
//
//  Created by lanou on 16/7/4.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ReadPingLunViewController.h"
#import "ReadPinglunModel.h"
#import "ReadPingLunTableViewCell.h"

@interface ReadPingLunViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property(nonatomic,strong)UITableView *tab;

@property(nonatomic,strong)NSMutableArray *modelArr;

@property(nonatomic,strong)NSMutableDictionary *pardic3 ;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,assign)NSInteger star;

@property(nonatomic,strong)UITextView *myTextView;

@end

@implementation ReadPingLunViewController


-(NSMutableArray *)modelArr
{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}



-(UITextView *)myTextView
{
    if (!_myTextView) {
        _myTextView =  [[UITextView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 40)];
     
        _myTextView.backgroundColor = [UIColor yellowColor];
        _myTextView.delegate = self;
        _myTextView.returnKeyType = UIReturnKeySend;
    
   
    }
    return _myTextView ;
    
}

-(void)shujujiexi
{
    
    
    [RequestManager requestWithURLString:KPOSTContentURL pardic:self.pardic3 requesttype:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.modelArr = [ReadPinglunModel conmentModelConfigureJson:dic];
        
        NSDictionary *dataDic = dic[@"data"];
        
        NSArray *arr= dataDic[@"list"];
        
        if (arr.count==0) {
            
            NSLog(@"没有更多数据");
            
            [self.tab.mj_footer endRefreshing];
            
            return;
            
        }
        
        if (self.star == 0) {
            [self.modelArr removeAllObjects];
            
        }
        
        NSArray *array =[ReadPinglunModel conmentModelConfigureJson:dic];
        
        for (ReadPinglunModel *model in array) {
            [self.modelArr addObject:model];
        }
        
        
        [self.tab.mj_header endRefreshing];
        
        [self.tab.mj_footer endRefreshing];
        

        [self.tab reloadData];
        
        
    } error:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.star = 0;
    
    self.index= 1;
    
    self.pardic3 = [@{@"auth":[UserInfoManager getUserAuth],@"client":@"1",@"contentid":self.conmentid,@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31",@"limit":[NSString stringWithFormat:@"%ld",self.index*10],@"start":[NSString stringWithFormat:@"%ld",self.star],@"version":@"3.0.6"}mutableCopy];
    
    
    [self shujujiexi];
    
    [self createTab];

    [self.tab registerNib:[UINib nibWithNibName:@"ReadPingLunTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ss"];
    
    UIButton *BTN = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    BTN.frame = CGRectMake(kScreenWidth-100, 30, 30, 30);
    
    [BTN addTarget:self action:@selector(pinglun) forControlEvents:(UIControlEventTouchUpInside)];
    
    [BTN setBackgroundImage:[UIImage imageNamed:@"comments"] forState:(UIControlStateNormal)];

    [self.view addSubview:BTN];
    
    [self.view addSubview:self.myTextView];

}
-(void)pinglun
{
    
    [self.myTextView becomeFirstResponder];
    
}


-(void)keyboardShow:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] integerValue] animations:^{

        CGRect nerRect = [note.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        [UIView animateWithDuration:[note.userInfo [UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            self.myTextView.transform = CGAffineTransformMakeTranslation(0, -nerRect.size.height - self.myTextView.height);
        }];
    }];
   
    
}



-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] integerValue] animations:^{

        self.myTextView.transform = CGAffineTransformIdentity;
        
    }];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.myTextView resignFirstResponder];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.myTextView resignFirstResponder];
}


-(void)createTab
{
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, KNaviH+21, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab.delegate  =self;
    self.tab.dataSource =self;
    self.tab.rowHeight = 150;
    [self.view addSubview:self.tab];
    
    
    self.tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.star = 0;
        
        self.pardic3[@"star"]=[NSString stringWithFormat:@"%ld",(long)self.star];
        
        self.pardic3[@"limit"] = [NSString stringWithFormat:@"%ld",self.index*10];
        
        [self shujujiexi];
        

        
    }];
    
    self.tab.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        
        self.star = self.index*10;
        
        self.pardic3[@"star"]= [NSString stringWithFormat:@"%ld",(long)self.star];
        
        self.pardic3[@"limit"] = @"10";
        
        self.index++;
        
        [self shujujiexi];
        

    }];
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.modelArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ReadPinglunModel *model = self.modelArr[indexPath.row];
    
    
    ReadPingLunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss"];
    if (cell == nil) {
        
        cell = [[ReadPingLunTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"ss"];
    }
    
    [cell.iconL sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil completed:nil];
    
    cell.unameL.text = model.uname;
    
    cell.titleL.text = model.content;
    
    cell.addtimeL.text = model.addtime_f;
    
    // addtime——f；
    
    return cell;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
         [self uploadComment:self.myTextView.text];

        return NO;
    }

    return YES;

}

#pragma mark ---提交评论

-(void)uploadComment:(NSString *)comment
{
    //auth -- 用户信息 content--内容 contentid--文章
    
    [RequestManager requestWithURLString:KPOSTSetContentURL pardic:@{@"auth":[UserInfoManager getUserAuth],@"content":comment,@"contentid":self.conmentid} requesttype:RequestPOST finish:^(NSData *data)
     
    {
        
        [self.tab.mj_header beginRefreshing];
        
    } error:^(NSError *error) {
        
    }];

}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadPinglunModel *model = self.modelArr[indexPath.row];
    
    if (model.isdel) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
        
            [self.modelArr removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
            
            [self.tab reloadData];
            
            [self deleteComment:model];
        }
    }else
    {
        
       
    }
  
   
    
}


-(void)deleteComment:(ReadPinglunModel *)model
{
    
    
    [RequestManager requestWithURLString:KreadDeleadPinglun pardic:@{@"auth":[UserInfoManager getUserAuth],@"contentid":self.conmentid,@"commentid":model.contentid} requesttype:RequestPOST finish:^(NSData *data) {
        
        [self.tab.mj_header beginRefreshing];
        
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}








@end
