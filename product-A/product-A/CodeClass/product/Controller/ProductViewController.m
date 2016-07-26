//
//  ProductViewController.m
//  product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductTableViewCell.h"
#import "ProductModel.h"
#import "ProductDetailViewController.h"

@interface ProductViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)UITableView *table;

@property(nonatomic,strong)NSMutableDictionary *pardic3;

@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)NSInteger limitIndex;

@end




@implementation ProductViewController

-(NSMutableArray *)arr
{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
    
}

-(void)shujujixe
{
    
    [RequestManager requestWithURLString:KPostProductURL pardic:self.pardic3 requesttype:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSDictionary *dica = dic[@"data"];
        
        NSMutableArray *arr  = dica[@"list"];
        
        if (arr.count==0) {
            
            [self.table.mj_footer endRefreshing];
            
            return ;
        }
        if (self.limitIndex==0) {
            
            [self.arr removeAllObjects];
            
        };
        
        [self.table.mj_header endRefreshing];
        
        [self.table.mj_footer endRefreshing];
        
        self.arr = [ProductModel modelConfigure:dic];
        
        [self.table reloadData];
        
    } error:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    
    self.limitIndex =1;
    
    self.pardic3 = [@{@"start":[NSString stringWithFormat:@"%ld",(long)self.index],@"client":@"1",@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"limit":[NSString stringWithFormat:@"%ld",self.limitIndex*10],@"auth":@"XMdnEiW0m3qxDCMVzGMTikDJxQ8aoNbKF8W1rUDRicWP23tBNQhpd6fw",@"version":@"3.0.2"}mutableCopy];
    
    [self shujujixe];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, KNaviH+24, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.table.dataSource = self;
    
    self.table.delegate =self;
    
    [self.view addSubview:self.table];
    
    [self.table registerClass:[ProductTableViewCell class] forCellReuseIdentifier:@"ss"];
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.pardic3[@"limit"] = [NSString stringWithFormat:@"%ld",self.limitIndex*10];
        
            [self shujujixe];
    }];
    self.table.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
      
            self.limitIndex +=1;
            
            self.pardic3[@"limit"] = [NSString stringWithFormat:@"%d",self.limitIndex*10];
        
            [self shujujixe];
    
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss" forIndexPath:indexPath];
    
    ProductModel *model = self.arr[indexPath.row];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
    
    cell.label.text = model.title;
    
    [cell.btn setTitle:@"点击购买" forState:(UIControlStateNormal)];
    
    [cell.btn addTarget:self action:@selector(next:) forControlEvents:(UIControlEventTouchUpInside)];

    return cell;
    
}

-(void)next:(UIButton *)btn
{
    
    ProductTableViewCell *cell = (ProductTableViewCell *)btn.superview.superview;
    
    NSIndexPath *index = [self.table indexPathForCell:cell];
    
    ProductModel *model = self.arr[index.row];
    
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.buyurl]];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
    
    ProductModel *model = self.arr[indexPath.row];
    
    vc.contentid = model.contentid;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
