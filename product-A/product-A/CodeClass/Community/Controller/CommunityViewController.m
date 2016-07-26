//
//  CommunityViewController.m
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityModel.h"
#import "CommunityTableViewCell.h"
#import "CommunitydetailViewController.h"



@interface CommunityViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scr;

@property(nonatomic,strong)UITableView *HotTab;

@property(nonatomic,strong)UITableView *NewTab;

@property(nonatomic,strong)NSMutableArray *hotModelArr; // 最热数组

@property(nonatomic,strong)NSMutableArray *NewModelArr;

@property(nonatomic,strong)NSMutableDictionary *parDichot;

@property(nonatomic,strong)NSMutableDictionary *parDicnew;

@property(nonatomic,strong)UISegmentedControl *seg;

@property(nonatomic,assign)NSInteger starthot;

@property(nonatomic,assign)NSInteger limithot;

@property(nonatomic,assign)NSInteger startnew;

@property(nonatomic,assign)NSInteger limitnew;



@end

@implementation CommunityViewController

-(NSMutableArray *)hotModelArr
{
    if (!_hotModelArr) {
        _hotModelArr = [NSMutableArray array];
    }
    return _hotModelArr;
    
}

-(NSMutableArray *)NewModelArr
{
    if (!_NewModelArr) {
        _NewModelArr = [NSMutableArray array];
    }
    return _NewModelArr;
    
    
    
}




-(void)shujujiexi
{
   
    if (self.seg.selectedSegmentIndex==0)
        
    {
        
#pragma mark ---最热的数据解析
        
        [RequestManager requestWithURLString:KCommunityURL pardic:self.parDichot requesttype:RequestPOST finish:^(NSData *data) {
            
            NSLog(@"%@",self.parDichot);
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSDictionary *dataDic = dic[@"data"];
            
            NSArray *listArr = dataDic[@"list"];
            
            if (listArr.count==0) {
                NSLog(@"没有数据了");
                
                [self.HotTab.mj_footer endRefreshing];
                
                return ;
            }
            
            
            if (self.starthot==0) {
                [self.hotModelArr removeAllObjects];
            }
            

            NSArray *arr = [CommunityModel modelConfigure:dic];
            
            for (CommunityModel *model in arr) {
                
                [self.hotModelArr addObject:model];
            }
            
            [self.HotTab.mj_header endRefreshing];
            
            [self.HotTab.mj_footer endRefreshing];
            
            [self.HotTab reloadData];

        } error:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
        
    }else
     
#pragma mark ---最新的数据解析
    {
        
        [RequestManager requestWithURLString:KCommunityURL pardic:self.parDicnew requesttype:RequestPOST finish:^(NSData *data) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSDictionary *dataDic = dic[@"data"];
            
            NSArray *listArr = dataDic[@"list"];
            
            if (listArr.count == 0) {
                
                NSLog(@"没有更多数据了");
                
                [self.NewTab.mj_footer endRefreshing];
             
                return;
            }
 
            if (self.startnew==0) {
                [self.NewModelArr removeAllObjects];
            }
            
            NSArray *arr = [CommunityModel modelConfigure:dic];
            
            for (CommunityModel *model in arr) {
                
                [self.NewModelArr addObject:model];
                
            }
            
            [self.NewTab.mj_header endRefreshing];
 
            [self.NewTab.mj_footer endRefreshing];
            
            [self.NewTab reloadData];
            
        } error:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
    
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.starthot = 0;
    
    self.startnew = 0;
    
    self.limithot = 1;
    
    self.limitnew = 1;
    
    
    self.scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KNaviH+21+30, kScreenWidth, kScreenHeight)];
    
    self.scr.contentSize = CGSizeMake(kScreenWidth*2, 0);
    
    self.scr.contentOffset = CGPointMake(0, 0);
    
    self.scr.pagingEnabled = YES;
    
    self.scr.bounces = NO;
    
    self.scr.delegate =self;
    
    
    
    
    [self.view addSubview:self.scr];
    
    [self createSeg];
    
    self.parDichot = [@{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"client":@"1",@"sort":@"hot",@"limit":@10,@"version":@"3.0.2",@"start":@0,@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0"}mutableCopy];
    
    self.parDicnew = [@{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"client":@"1",@"sort":@"addtime",@"limit":@10,@"version":@"3.0.2",@"start":@0,@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0"}mutableCopy];
   
    [self shujujiexi];
    
    [self createHotTab];
    
    [self createNewTab];
    
    [self.HotTab registerNib:[UINib nibWithNibName:@"CommunityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ss"];
    
     [self.NewTab registerNib:[UINib nibWithNibName:@"CommunityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ss"];

}


-(void)createNewTab
{
    self.NewTab = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    
    self.NewTab.delegate = self;
    
    self.NewTab.dataSource =self;
    
    self.NewTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.NewTab.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
        self.startnew = 0;
        
        self.parDicnew[@"start"] = [NSString stringWithFormat:@"%ld",self.startnew];
        
        self.parDicnew[@"limit"] = [NSString stringWithFormat:@"%ld",self.limitnew*10];
        
        [self shujujiexi];
        
    }];
    
    self.NewTab.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        self.startnew = self.limitnew*10;
        
        
        
        self.parDicnew[@"start"] = [NSString stringWithFormat:@"%ld",self.startnew];
        
        self.parDicnew[@"limit"] = [NSString stringWithFormat:@"10"];
        
        self.limitnew++;
        
        [self shujujiexi];
        
    }];
    
    [self.scr addSubview:self.NewTab];
    
}




-(void)createSeg
{
    
   self.seg = [[UISegmentedControl alloc]initWithItems:@[@"Hot",@"New"]];

    self.seg.center = CGPointMake(kScreenWidth/2, 75);
    
    self.seg.selectedSegmentIndex = 0;
    
    [self.seg addTarget:self action:@selector(changgeValue:) forControlEvents:(UIControlEventValueChanged)];
    
//    self.seg.backgroundColor = [UIColor blackColor];
    
    self.seg.tintColor = [UIColor redColor];
    
    [self.view addSubview:self.seg];
    
}

-(void)changgeValue:(UISegmentedControl *)seg;
{
    
    self.scr.contentOffset = CGPointMake(seg.selectedSegmentIndex*kScreenWidth, 0);
    
    [self.HotTab reloadData];
    
    [self.NewTab reloadData];
    
     [self shujujiexi];
}



-(void)createHotTab
{
    self.HotTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.HotTab.delegate = self;
    
    self.HotTab.dataSource =self;
    
    self.HotTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.scr addSubview:self.HotTab];
    
    self.HotTab.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        self.starthot = 0;
        
        self.parDichot[@"start"] = [NSString stringWithFormat:@"%ld",self.starthot];
       
        self.parDichot[@"limit"] = [NSString stringWithFormat:@"%ld",self.limithot*10];
        
    }];
    
    
    self.HotTab.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        self.starthot = self.limithot*10;
        
        self.parDichot[@"start"] = [NSString stringWithFormat:@"%ld",self.starthot];
        
        self.limithot++;
        
        [self shujujiexi];
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.seg.selectedSegmentIndex==0) {
        return self.hotModelArr.count;
    }else
        return self.NewModelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    CommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss" forIndexPath:indexPath];
    
    if (self.seg.selectedSegmentIndex==0) {
        CommunityModel *model = self.hotModelArr[indexPath.row];
        
        cell.titleL.text = model.title;
        
        [cell.iconImageV sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil completed:nil];
       
        cell.contentL.text = model.content;
        
        cell.addtime_fL.text = model.addtime_f;
        
        cell.commentL.text = [NSString stringWithFormat:@"%ld",model.comment];
       
        cell.contentL.numberOfLines = 0;
        
        return cell;
        
    }else
        
    {
        
        CommunityModel *model = self.NewModelArr[indexPath.row];

        cell.titleL.text = model.title;
        
        [cell.iconImageV sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil completed:nil];
        cell.contentL.text = model.content;
        cell.addtime_fL.text = model.addtime_f;
        cell.commentL.text = [NSString stringWithFormat:@"%ld",model.comment];
        cell.contentL.numberOfLines = 0;
        
        
        
        return cell;
    
    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (kScreenHeight-KNaviH-20)/3;

}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.seg.selectedSegmentIndex = self.scr.contentOffset.x/kScreenWidth;
    
    
    [self shujujiexi];

}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     CommunitydetailViewController *detail = [[CommunitydetailViewController alloc]init];
    
    if (self.seg.selectedSegmentIndex==0) {
        CommunityModel *model = self.hotModelArr[indexPath.row];
        detail.uid = model.contentid;
        
    }else
    {
        CommunityModel *model = self.NewModelArr[indexPath.row];
        
        detail.uid = model.contentid;
    
    }
    
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
   
    
    
    
    
    
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
