//
//  RootViewController.m
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RootViewController.h"
#import "RadioDetailLastModel.h"
#import "Userview.h"
#import "RadioDetailLastModel.h"
#import "RadioPlayerViewController.h"


#define gradientLayerH kScreenHeight/3.0


@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *iconarr;
@property(nonatomic,strong)UIButton *btn;


@end

@implementation RootViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;

}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initGradientLayer];
    [self initTableView];
    [self player];
    
}

-(void)player
{
    
    UIView *lastView = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight-(kScreenHeight-20-KCAGradientLayerHeight-(kScreenHeight - 20 - KCAGradientLayerHeight - 64)) ,kScreenWidth,kScreenHeight-20-KCAGradientLayerHeight-(kScreenHeight - 20 - KCAGradientLayerHeight - 64))];
    
    lastView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:lastView];
    
    [self.view  sendSubviewToBack:lastView];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5,kScreenWidth/6,kScreenHeight-20-KCAGradientLayerHeight-(kScreenHeight - 20 - KCAGradientLayerHeight - 64)-10)];

    [lastView addSubview:imageV];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/6+10, 5, kScreenWidth/4, (kScreenHeight-20-KCAGradientLayerHeight-(kScreenHeight - 20 - KCAGradientLayerHeight - 64)-10)/2)];

    name.textColor = [UIColor whiteColor];

    
    [lastView addSubview:name];
    
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/6+10, 5+(kScreenHeight-20-KCAGradientLayerHeight-(kScreenHeight - 20 - KCAGradientLayerHeight - 64)-10)/2+5 , kScreenWidth/4, (kScreenHeight-20-KCAGradientLayerHeight-(kScreenHeight - 20 - KCAGradientLayerHeight - 64)-10)/2)];
    
    title.textColor = [UIColor whiteColor];
    
    title.font = [UIFont systemFontOfSize:12];
    
    [lastView addSubview:title];
    
    
    self.btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    self.btn.frame = CGRectMake(kScreenWidth*3.5/6, 5, kScreenWidth/6,kScreenHeight-20-KCAGradientLayerHeight-(kScreenHeight - 20 - KCAGradientLayerHeight - 64)-10);
    
    
    [self.btn addTarget:self action:@selector(bofang:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.btn.hidden = YES;
    
    [lastView addSubview:self.btn];
    
    [VideoManager sharInstance].BLOCK = ^(){
        
        NSInteger index = [VideoManager sharInstance].index;
        
        RadioDetailLastModel *model = [VideoManager sharInstance].arr[index];
        
    [imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
        
        name.text = model.uname;
        
        title.text = model.title;
        
        self.btn.hidden = NO;

        
        if ([VideoManager sharInstance].isplay) {
            [self.btn setImage:[[UIImage imageNamed:@"pause"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ]forState:(UIControlStateNormal)];
        }else
        {
            
            [self.btn setImage:[[UIImage imageNamed:@"play"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ]forState:(UIControlStateNormal)];
        }

    };
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setimage) name:@"setimage" object:nil];

}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    if ([VideoManager sharInstance].isplay) {
//        [self.btn setImage:[[UIImage imageNamed:@"play"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ]forState:(UIControlStateNormal)];
//    }else
//    {
//        [self.btn setImage:[[UIImage imageNamed:@"pause"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ]forState:(UIControlStateNormal)];
//    }
//    
//}


-(void)setimage
{
    if ([VideoManager sharInstance].isplay) {
        
        [self.btn setImage:[[UIImage imageNamed:@"pause"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ]forState:(UIControlStateNormal)];
        
    }else
        
    {
        
        [self.btn setImage:[[UIImage imageNamed:@"play"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ]forState:(UIControlStateNormal)];
    }
}




-(void)bofang:(UIButton *)btn
{
    [[VideoManager sharInstance] playerplayAndPause];

    if ([VideoManager sharInstance].isplay) {
        
        [btn setImage:[[UIImage imageNamed:@"pause"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ]forState:(UIControlStateNormal)];
        
    }else
        
    {
        
        [btn setImage:[[UIImage imageNamed:@"play"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal) ]forState:(UIControlStateNormal)];
        
    }
    
   [[NSNotificationCenter defaultCenter]postNotificationName:@"animation" object:nil];
    
}

-(void)initGradientLayer{
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc]init];
    
    gradientLayer.frame = CGRectMake(0, 20, kScreenWidth, gradientLayerH);
    
    gradientLayer.colors = @[(id)PKCOLOR(180, 180, 180).CGColor,(id)PKCOLOR(100, 90, 100).CGColor,(id)PKCOLOR(40, 40, 40).CGColor];
    
    [self.view.layer addSublayer:gradientLayer];
    
    Userview *user =  [[NSBundle mainBundle] loadNibNamed:@"View" owner:nil options:nil].firstObject;
    
    user.RootVC = self;
    
    user.frame =CGRectMake(0, 20, kScreenWidth, gradientLayerH);
    
    user.backgroundColor = [UIColor clearColor];

    user.imagev.image  = [UIImage imageNamed:@"head"];
   
    [self.view addSubview:user];

}


-(void)initTableView
{
    
    _controllers = @[@"RadioViewController",@"ReadViewController",@"CommunityViewController",@"ProductViewController",@"SettingViewController"];
    
    _titles = @[@"电台",@"阅读",@"社区",@"良品",@"设置"];
    
    self.iconarr = [NSMutableArray arrayWithObjects:@"radio",@"read",@"comment",@"shop",@"settings", nil];
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20 + KCAGradientLayerHeight, kScreenWidth, kScreenHeight - 20 - KCAGradientLayerHeight - 64) style:(UITableViewStylePlain)];
  
    table.delegate = self;
    
    table.dataSource = self;
    
   [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"rootCell"];
    
    table.rowHeight = table.height/_titles.count;
    
    table.scrollEnabled = NO;
    
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:table];
    
    [table selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    
    _rightVC = [[NSClassFromString(_controllers[0])alloc]init];
    
    _rightVC.titleLabel.text = _titles[0];
    
    _myNaviVC = [[UINavigationController alloc]initWithRootViewController:_rightVC];
    
    _myNaviVC.navigationBar.hidden = YES;
    
    [self addChildViewController:_myNaviVC];
    
    [self.view addSubview:_myNaviVC.view];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootCell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:self.iconarr[indexPath.row]];

    cell.textLabel.text = _titles[indexPath.row];
    
    cell.textLabel.textColor = PKCOLOR(80, 80, 80);
    
    cell.textLabel.font = [UIFont systemFontOfSize:cell.height/4];
   
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
    
    cell.backgroundColor = PKCOLOR(40, 40, 40);
    
  
  if ([cell isSelected]) {
        
        cell.textLabel.textColor = PKCOLOR(240, 240, 240);
        
            }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.textLabel.textColor = PKCOLOR(240, 240, 240);
    
    if ([_rightVC isMemberOfClass:[NSClassFromString(_controllers[indexPath.row])class]]) {
        
        [_rightVC ChangeFrameWithType:MOVETYPELEFT];
        
        return;
    }
    
    [_myNaviVC.view removeFromSuperview];
    
    _rightVC = [[NSClassFromString(_controllers[indexPath.row])alloc]init];
    
    _rightVC.titleLabel.text = _titles[indexPath.row];
    
    _myNaviVC = [[UINavigationController alloc]initWithRootViewController:_rightVC];
    
    _myNaviVC.navigationBar.hidden = YES;
    
    [self.view addSubview:_myNaviVC.view];
    
    CGRect newFrame = _myNaviVC.view.frame;
    
    newFrame.origin.x = kScreenWidth-kMoveDistance;
    
    _myNaviVC.view.frame = newFrame;
    
    [_rightVC ChangeFrameWithType:(MOVETYPELEFT)];
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.textLabel.textColor = PKCOLOR(80, 80, 80);
    
    cell.backgroundColor = PKCOLOR(40, 40, 40);

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}





#pragma mark ---跳转到播放页面
//-(void)playerview:(UIViewController*)view;
//{
//    
//    NSLog(@"2");
//    
//    RadioPlayerViewController *radioPlayer = [[RadioPlayerViewController alloc]init];
//    
//    RootViewController *vc = [[RootViewController alloc]init];
//
////    self.navigationController = vc.navigationController;
//    
//    [vc.navigationController pushViewController:radioPlayer animated:YES];
//    
//    
////    [vc presentViewController:radioPlayer animated:YES completion:nil];
//    
////  [self presentViewController:radioPlayer animated:YES completion:nil];
//    
//
//}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
