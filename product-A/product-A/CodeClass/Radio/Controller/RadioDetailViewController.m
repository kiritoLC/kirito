//
//  RadioDetailViewController.m
//  product-A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RadioDetailViewController.h"
#import "RadionDetailModel.h"
#import "RadioDetailMidModel.h"
#import "RadioDetailLastModel.h"
#import "RadioDetailTableViewCell.h"
#import "RadioPlayerViewController.h"


@interface RadioDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)RadionDetailModel *upModel;
@property(nonatomic,strong)RadioDetailMidModel *midModel;

@property(nonatomic,strong)NSMutableArray *lastModelArr;

@property(nonatomic,strong)UITableView *tabV;


@property(nonatomic,strong)UIImageView *imageV;





#pragma mark ---上拉加载 下拉刷新数据

@property(nonatomic,assign)NSInteger star;
@property(nonatomic,assign)NSInteger limit;



@end

@implementation RadioDetailViewController

-(RadionDetailModel *)upModel
{
    if (!_upModel) {
        _upModel = [[RadionDetailModel alloc]init];
    }
    return _upModel;
}

-(RadioDetailMidModel *)midModel
{
    if (!_midModel) {
        _midModel = [[RadioDetailMidModel alloc]init];
    }
    return _midModel;
}

-(NSMutableArray *)lastModelArr
{
    if (!_lastModelArr) {
        _lastModelArr = [[NSMutableArray alloc]init];
    }
    return _lastModelArr;
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.star = 0;
    self.limit = 1;
    
    
    
    [self upView];
    
    
    [self lastTableView];
    self.titleLabel.text = self.upModel.title;
    
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 40)];
    [button addTarget:self action:@selector(returen) forControlEvents:(UIControlEventTouchUpInside)];
    
    [button setTitle:@"aa" forState:(UIControlStateNormal)];
    
    [button setImage:[UIImage imageNamed:@"return"] forState:(UIControlStateNormal)];
    button.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:button];
    
    
    
    
}

-(void)returen
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark ---最上面的图片
-(void)upView
{
   self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    
    NSString *postString  = [NSString stringWithFormat:@"auth=&client=1&deviceid=63A94D37-33-33F9-40FF-9EBB-481182338873&radioid=%@&version=3.0.4",self.canshu];
    
    NSURL *url = [NSURL URLWithString:KradioDetail];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    request.timeoutInterval = 10;
    
    [request setHTTPMethod:@"POST"];
    
    NSData *data =[postString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *jsondic  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.upModel = [RadionDetailModel upModelConfigure:jsondic];
            [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.upModel.coverimg] placeholderImage:nil completed:nil];
            
            
            self.titleLabel.text = self.upModel.title;
        });
        
    }];
    
    [task resume];

}

#pragma mark ---最下面的tableView
-(void)lastTableView
{
    
    self.tabV = [[UITableView alloc]initWithFrame:CGRectMake(0, KNaviH+21,kScreenWidth,kScreenHeight-KNaviH) style:(UITableViewStyleGrouped)];
    
    self.tabV.dataSource =self;
    
    self.tabV.delegate = self;
    
    self.tabV.separatorColor = [UIColor grayColor];
    
    [self.view addSubview:self.tabV];
    
    self.tabV.rowHeight = 100;

    NSString *postString  = [NSString stringWithFormat:@"auth=&client=1&deviceid=63A94D37-33-33F9-40FF-9EBB-481182338873&radioid=%@&version=3.0.4&limit=%@&start=%@",self.canshu,[NSString stringWithFormat:@"%ld",self.limit],[NSString stringWithFormat:@"%ld",self.star]];
    
    NSURL *url = [NSURL URLWithString:KradioDetail];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.timeoutInterval = 10;
    [request setHTTPMethod:@"POST"];
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
   
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            
            
            self.lastModelArr = [RadioDetailLastModel modelConfigure:jsonDic];
            [self.tabV reloadData];
        });
    }];
    [task resume];
    
    
    
    
    
    
    
    
    
    [self.tabV registerNib:[UINib nibWithNibName:@"RadioDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"radioDetailCell"];
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lastModelArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioDetailLastModel *model = self.lastModelArr[indexPath.row];
    
    RadioDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioDetailCell" forIndexPath:indexPath];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
    cell.titleL.text = model.title;
    cell.VisitL.text = [NSString stringWithFormat:@"%@",model.musicVisit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioPlayerViewController *vc = [[RadioPlayerViewController alloc]init];
    
    
    [VideoManager sharInstance].arr = self.lastModelArr;
    
    [VideoManager sharInstance].index = indexPath.row;
    
    RadioDetailLastModel *model = self.lastModelArr[indexPath.row];
    
    vc.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    vc.isplay = model.isPlaying;
    
    
    [self.navigationController pushViewController:vc animated:YES];

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    
     [view addSubview:self.imageV];
    
    UIImageView *iconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, KNaviH+20+100+20+30, 40, 40)];
    iconImageV.layer.masksToBounds = YES;
    
    iconImageV.layer.cornerRadius = 20;
    
    [view addSubview:iconImageV];
    
    UILabel *unameL = [[UILabel alloc]initWithFrame:CGRectMake(65, KNaviH+20+100+20+30, 80, 40)];
    
    unameL.textColor = [UIColor grayColor];
    
    [view addSubview:unameL];
    
    UILabel *musicvisitnumL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100, KNaviH+20+100+20+30, 80, 50)];
    
    musicvisitnumL.textColor = [UIColor grayColor];
    
    [view addSubview:musicvisitnumL];
    
    UILabel *descL = [[UILabel alloc]initWithFrame:CGRectMake(20, KNaviH+20+100+50+20+30, 200, 50)];
    
    descL.textColor = [UIColor grayColor];
    
    [view addSubview:descL];
    
    NSString *postString  = [NSString stringWithFormat:@"auth=&client=1&deviceid=63A94D37-33-33F9-40FF-9EBB-481182338873&radioid=%@&version=3.0.4",self.canshu];
    
    NSURL *url = [NSURL URLWithString:KradioDetail];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    request.timeoutInterval = 10;
    
    [request setHTTPMethod:@"POST"];
    
    NSData *data = [postString  dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            RadioDetailMidModel *model = [[RadioDetailMidModel alloc]init];
            
            model = [RadioDetailMidModel midConfigure:dic];
            
            [iconImageV sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil completed:nil];
            
            unameL.text = model.uname;
            
            descL.text = model.desc;
            
            musicvisitnumL.text = [NSString stringWithFormat:@"%@",model.musicvisitnum];
        });
        
    }];
    
    [task resume];

    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 300;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RadioDetailLastModel *model = self.lastModelArr[indexPath.row];
    
    model.isPlaying = NO;
    
}
@end
