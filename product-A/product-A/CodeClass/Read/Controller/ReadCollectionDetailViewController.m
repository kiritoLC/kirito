//
//  ReadCollectionDetailViewController.m
//  product-A
//
//  Created by lanou on 16/6/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ReadCollectionDetailViewController.h"
#import "ReadDetailCollectionModel.h"
#import "ReadCollectionTableViewCell.h"
#import "ReadDetadilViewController.h"
#import "ReadTableViewDetailViewController.h"

@interface ReadCollectionDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *table;


@property(nonatomic,strong)NSMutableArray *modelArr;
@property(nonatomic,strong)NSMutableArray *modelArr2;


@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIButton *button1;


@property(nonatomic,assign)NSInteger limitindex;
@property(nonatomic,assign)NSInteger starindex;


@property(nonatomic,assign)NSInteger limitindex2;
@property(nonatomic,assign)NSInteger starindex2;


@property(nonatomic,strong)NSMutableDictionary *dic1;
@property(nonatomic,strong)NSMutableDictionary *dic2;


@property(nonatomic,assign)BOOL ishot;

@end

@implementation ReadCollectionDetailViewController

-(NSMutableArray *)modelArr
{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
    
}


-(NSMutableArray *)modelArr2
{
    if (!_modelArr2) {
        _modelArr2 = [[NSMutableArray alloc]init];
    }
    return _modelArr2;
}


-(void)shujujixe
{
    
     self.dic1 = [@{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338876",@"typeid":@"1",@"client":@"1",@"sort":@"addtime",@"limit":[NSString stringWithFormat:@"%ld",self.limitindex*10],@"version":@"3.0.2",@"auth":@"Wc06FCrkoq1DCMVzGMTiDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0",@"start":[NSString stringWithFormat:@"%ld",self.starindex]}mutableCopy];
    
    [self.dic1 setValue:[NSString stringWithFormat:@"%ld",(long)self.typedid] forKey:@"typeid"];
    
    [RequestManager requestWithURLString:KReadCollectionDetail pardic:self.dic1 requesttype:RequestPOST finish:^(NSData *data) {
        NSDictionary *jsDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dica = jsDic[@"data"];
        NSMutableArray *arr  = dica[@"list"];
        if (arr.count==0) {
            [self.table.mj_footer endRefreshing];
            return ;
        }
        if (self.limitindex==0) {
            [self.modelArr removeAllObjects];
        };

        self.modelArr = [ReadDetailCollectionModel modelComfigure:jsDic];
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
        [self.table reloadData];
        
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)shujujixe2
{
    
    
    self.dic2 = [@{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338876",@"typeid":@"1",@"client":@"1",@"sort":@"hot",@"limit":[NSString stringWithFormat:@"%ld",self.limitindex2*10],@"version":@"3.0.2",@"auth":@"Wc06FCrkoq1DCMVzGMTiDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0",@"start":[NSString stringWithFormat:@"%ld",self.starindex2]}mutableCopy];
    
    [self.dic2 setValue:[NSString stringWithFormat:@"%ld",(long)self.typedid] forKey:@"typeid"];
    
    [RequestManager requestWithURLString:KReadCollectionDetail pardic:self.dic2 requesttype:RequestPOST finish:^(NSData *data) {
        
        NSDictionary *jsDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSDictionary *dica = jsDic[@"data"];
        
        NSMutableArray *arr  = dica[@"list"];
        
        if (arr.count==0) {
            [self.table.mj_footer endRefreshing];
            return ;
        }
        
        if (self.limitindex2==0) {
            [self.modelArr2 removeAllObjects];
        };
        
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];

        self.modelArr2 = [ReadDetailCollectionModel modelComfigure:jsDic];
        [self.table reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ishot = NO;
    
    self.starindex=0;
    self.starindex2 =0;
    
    self.limitindex=1;
    
    self.limitindex2=1;

    [self shujujixe];
    
    [self tableView];
    
        self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
            if (self.ishot==NO) {
                self.dic1[@"limit"] = [NSString stringWithFormat:@"%ld",self.limitindex*10];
                [self shujujixe];
            }else
            {
                self.dic2[@"limit"] = [NSString stringWithFormat:@"%ld",self.limitindex2*10];
                [self shujujixe2];
            }

        }];
        
        self.table.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            
            if (self.ishot==NO) {
                
                self.limitindex +=1;
                
                self.dic1[@"limit"] = [NSString stringWithFormat:@"%ld",self.limitindex*10];
                
                [self shujujixe];
            }else
            {
                self.limitindex2++;
                
                self.dic2[@"limit"] = [NSString stringWithFormat:@"%ld",self.limitindex2*10];
                
                [self shujujixe2];
            }
            
        }];
    

    self.button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    self.button.backgroundColor = [UIColor grayColor];
    
    [self.button setTitle:@"NEW" forState:(UIControlStateNormal)];
    
    [self.button addTarget:self action:@selector(new) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.button.frame = CGRectMake(200, 22, 30, 30);
    
    [self.view addSubview:self.button];
    
    [self.button setEnabled:NO];
    
    self.button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.button.layer setMasksToBounds:YES];
    
    [self.button.layer setCornerRadius:5];
  
    self.button1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    self.button1.backgroundColor = [UIColor blackColor];
    
    [self.button1 setTitle:@"HOT" forState:(UIControlStateNormal)];
    
    [self.button1 addTarget:self action:@selector(hot) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.button1.frame = CGRectMake(280, 22, 30, 30);
    
    [self.view addSubview:self.button1];
    
    [self.button1.layer setMasksToBounds:YES];
    
    [self.button1.layer setCornerRadius:5];
    
    [self.button1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    self.button1.titleLabel.font = [UIFont systemFontOfSize:12];

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 40)];
    
    [button addTarget:self action:@selector(returen) forControlEvents:(UIControlEventTouchUpInside)];
    
    [button setTitle:@"aa" forState:(UIControlStateNormal)];
    
    [button setImage:[UIImage imageNamed:@"return"] forState:(UIControlStateNormal)];
    
    button.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:button];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadDetailCollectionModel *model;
    
    if (self.ishot==NO) {
        
       model  = self.modelArr[indexPath.row];
        
    }else{
        
       model  = self.modelArr2[indexPath.row];
        
    }
    
    ReadTableViewDetailViewController *tabVC = [[ReadTableViewDetailViewController alloc]init];
    
    
    tabVC.commitID = model.id;

    
    tabVC.html = model.id;
    
    
    [self.navigationController pushViewController:tabVC animated:YES];
    
    
    
    
    
    
    
//    ReadDetadilViewController *vc =[[ReadDetadilViewController alloc]init];
//    vc.html = model.id;
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
    
}















-(void)returen
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



-(void)new
{
    [self shujujixe];
    self.ishot=NO;
    [self.button setEnabled:NO];
    [self.button1 setEnabled:YES];
    self.button.backgroundColor = [UIColor grayColor] ;
    self.button1.backgroundColor = [UIColor blackColor] ;
    
}

-(void)hot
{
    [self shujujixe2];
    
    self.ishot=YES;
    
    [self.button setEnabled:YES];
    
    [self.button1 setEnabled:NO];
    
    self.button1.backgroundColor = [UIColor grayColor];
    
    self.button.backgroundColor = [UIColor blackColor];
    
}

-(void)tableView
{

    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, KNaviH+21, kScreenWidth, kScreenHeight - 64) style:(UITableViewStylePlain)];
   
    self.table.separatorStyle =  UITableViewCellSeparatorStyleNone;

    self.table.rowHeight = 160;

    [self.table registerNib:[UINib nibWithNibName:@"ReadCollectionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cf"];
    
    self.limitindex = 1;
    
    self.table.delegate = self;
    
    self.table.dataSource =self;
    
    [self.view addSubview:self.table];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (!self.ishot) {
        
        return self.modelArr.count;
        
    }else
        
    {
        
        return self.modelArr2.count;
        
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReadCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cf" forIndexPath:indexPath];
    
    if (self.ishot) {
        
        ReadDetailCollectionModel *model = self.modelArr2[indexPath.row];
        
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
        
        cell.titleL.text = model.title;
        
        cell.titleL.font = [UIFont systemFontOfSize:15];
        
        cell.content.text = model.content;
        
        cell.content.userInteractionEnabled = NO;
        
        cell.titleL.numberOfLines = 0;
        
        

        
    }else
        
    {
        
        ReadDetailCollectionModel *model = self.modelArr[indexPath.row];
        
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
        
        cell.titleL.text = model.title;
        
        cell.titleL.font = [UIFont systemFontOfSize:15];
        
        cell.content.text = model.content;
        
        cell.content.userInteractionEnabled = NO;
        
        cell.titleL.numberOfLines = 0;

      
    }
    
    
  
    
    
   return cell;
}



@end
