//
//  DownViewController.m
//  product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DownViewController.h"
#import "DownLoadTableViewCell.h"
#import "RadioPlayerViewController.h"

@interface DownViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *table;

@end

@implementation DownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor orangeColor];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, KNaviH+20+4, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    
    self.table.delegate = self;
    
    self.table.dataSource =self;
    
    [self.view addSubview:self.table];
    
    [self.table registerNib:[UINib nibWithNibName:@"DownLoadTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"downLoad"];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 40)];
    
    [button addTarget:self action:@selector(returen) forControlEvents:(UIControlEventTouchUpInside)];
    
    [button setTitle:@"aa" forState:(UIControlStateNormal)];
    
    [button setImage:[UIImage imageNamed:@"return"] forState:(UIControlStateNormal)];
    
    button.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:button];
    
    
    
    
}

-(void)returen
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownLoadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downLoad"];
    
    NSArray *arr = self.modelArr[indexPath.row];
    
    cell.title.text = arr[0];
    
    cell.name.text = [NSString stringWithFormat:@"by:%@",arr[4]];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:arr[2]] placeholderImage:nil completed:nil];
    
    
    cell.name.numberOfLines = 0;
    
    cell.title.numberOfLines = 0;
    
    return cell;
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    RadioPlayerViewController *vc = [[RadioPlayerViewController alloc]init];
//    
//    
//    [VideoManager sharInstance].arr = self.modelArr;
//    
//    [VideoManager sharInstance].index = indexPath.row;
//    
////    RadioDetailLastModel *model = self.modelArr[indexPath.row];
//    
////    vc.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
////    
////    vc.isplay = model.isPlaying;
//    
////    if (model.isPlaying) {
////        
////    }else
////        
////    {
////        
////        [[VideoManager sharInstance]playerReplaceItemWithUrlstring:model.musicUrl];
////        model.isPlaying = YES;

////    }
//    [self presentViewController:vc animated:YES completion:nil];
//}










@end
