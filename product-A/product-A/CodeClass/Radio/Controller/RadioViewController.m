//
//  RadioViewController.m
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "RadioViewController.h"
#import "RadionModel.h"
#import "CarouselView.h"
#import "CollectionViewCell.h"
#import "RadioTableViewCell.h"
#import "RadioDetailViewController.h"
@interface RadioViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *radioModelArr;
@property(nonatomic,strong)NSMutableArray *collectionModelArr;
@property(nonatomic,strong)NSMutableArray *tableModelArr;
@property(nonatomic,strong)NSMutableDictionary *pardic3;
@property(nonatomic,strong)UICollectionView *collection;
@property(nonatomic,strong)UITableView *tableV;


@property(nonatomic,strong)CarouselView *carouseV;

@property(nonatomic,strong)UIView *src;

@property(nonatomic,assign)NSInteger star;

@property(nonatomic,assign)NSInteger limitindex;

@property(nonatomic,strong)UIImageView *imageV;

@property(nonatomic,strong)CABasicAnimation *animation;


@end

@implementation RadioViewController


-(NSMutableArray *)tableModelArr
{
    if (!_tableModelArr) {
        _tableModelArr = [NSMutableArray array];
    }
    return _tableModelArr;
}



-(NSMutableArray *)collectionModelArr
{
    if (!_collectionModelArr) {
        _collectionModelArr = [NSMutableArray array];
    }
    return _collectionModelArr;
}



-(NSMutableArray *)radioModelArr
{
    if (!_radioModelArr) {
        
        _radioModelArr = [NSMutableArray array];
        
    }
    
    return _radioModelArr;
    
}

-(void)shujujiexi
{

    [RequestManager requestWithURLString:Kradio1 pardic:self.pardic3 requesttype:RequestPOST finish:^(NSData *data)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.radioModelArr = [RadionModel modelConfigure:dic];
        NSLog(@"%ld",(unsigned long)self.radioModelArr.count);
        
        NSMutableArray *arr = [NSMutableArray array];
        for (RadionModel *model in self.radioModelArr) {
            NSString *string = model.img;
            [arr addObject:string];
        }
        
        __weak RadioViewController *myself = self;
        
       myself.carouseV = [[CarouselView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) imageURLs:arr];
        
         myself.carouseV.imageClick = ^(NSInteger index){
            
        RadionModel *model = myself.radioModelArr[index];
            
            RadioDetailViewController *vc = [[RadioDetailViewController alloc]init];
            
            NSString *radioid = [model.url componentsSeparatedByString:@"/"][3];
            
            vc.canshu = radioid;
            
            [myself.navigationController pushViewController:vc animated:YES];
            
        };


        [self.tableV reloadData];
        
        self.collectionModelArr = [RadionModel tableModelConfigure :dic];
        
        [self.collection reloadData];
    
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
  
}

-(void)collcetionV
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    layout.itemSize = CGSizeMake(150, 150);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 170) collectionViewLayout:layout];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collection registerNib:nib forCellWithReuseIdentifier:@"aa"];
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.showsHorizontalScrollIndicator = NO;
//    [self.view addSubview:self.collection];
    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionModelArr.count;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RadioDetailViewController *radionDetailV = [[RadioDetailViewController alloc]init];
    
    
    RadionModel *model = self.collectionModelArr [indexPath.row];
    
    
    radionDetailV.canshu =model.radioid;
    
    
    [self.navigationController pushViewController:radionDetailV animated:YES];
    

}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
      CollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aa" forIndexPath:indexPath];
    
    
    
    RadionModel *model = self.collectionModelArr[indexPath.row];
   
    
    [cell.ImageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
    
    return cell;
    
}

-(void)tableView
{
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, KNaviH+21, kScreenWidth, kScreenHeight+KNaviH+21) style:(UITableViewStyleGrouped)];
    
    self.tableV.delegate = self;
    
    self.tableV.dataSource = self;
    
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableV registerNib:[UINib nibWithNibName:@"RadioTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tt"];
    
    self.tableV.rowHeight = 150;
    
    self.tableV.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tableV];
    
    [self shujujiexi2];
    
    
    
    
    self.tableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
       
        
        self.star = self.limitindex*10;
        
        
        self.pardic3[@"start"] = [NSString stringWithFormat:@"%ld",(long)self.star];
        
        
        self.pardic3[@"limit"] = [NSString stringWithFormat:@"10"];
        
        
        self.limitindex++;

        
        [self shujujiexi2];
        
        
    }];
}
-(void)shujujiexi2
{
    
    NSLog(@"%@",self.pardic3);
    
    
    [RequestManager requestWithURLString:KPostLowURL pardic:self.pardic3 requesttype:RequestPOST finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        
        NSDictionary *dataDic = dic[@"data"];
        NSArray *listArr = dataDic[@"list"];
        if (listArr.count==0) {
            
            NSLog(@" 没有更多数据");
            
            [self.tableV.mj_footer endRefreshing];
            
            return ;
            
        }
    
        NSArray *arr = [RadionModel collectionModelConfigure:dic];
        
        for (RadionModel *model in arr) {
            [self.tableModelArr addObject:model];
        }
        
 

        [self.tableV.mj_footer endRefreshing];
        
        [self.tableV reloadData];
        
        
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableModelArr.count;
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tt" forIndexPath:indexPath];
    RadionModel *model = self.tableModelArr[indexPath.row];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:nil];
    cell.titleL.text = model.title;
    
    cell.countL.text =[NSString stringWithFormat:@"%ld",(long)model.count];
    
    cell.detailL.text = model.desc;
    
    cell.titleL.font = [UIFont systemFontOfSize:20];
    
    cell.countL.font = [UIFont systemFontOfSize:12];
    
    cell.detailL.textColor = [UIColor grayColor];
    
    cell.detailL.numberOfLines = 0;
    
    
    
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 360, kScreenWidth, 50)];
    
    view2.backgroundColor = [UIColor whiteColor];
    
    UILabel *laibel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 50)];
    
    laibel.text = @"全部电台All Radios______________________";
    
    laibel.textColor = [UIColor grayColor];
    
    [view2 addSubview:laibel];
    
    [view addSubview:view2];

    [view addSubview:self.collection];
    
    [view addSubview:self.carouseV];

    return view;
}








-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 400;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioDetailViewController *radionDetailV = [[RadioDetailViewController alloc]init];
    
    RadionModel *model = self.tableModelArr[indexPath.row];
    
    
    radionDetailV.canshu =model.radioid;
    
    
    [self.navigationController pushViewController:radionDetailV animated:YES];


}

-(void)next
{
  
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(donghua) name:@"animation" object:nil];
    
    self.limitindex=1;
    
    self.star = 0;
    
     self.pardic3 = [@{@"auth":@"XZU7RH7m1861DC8Z8H8HvkTJxQMGoPLGO9zo4XDA0cWP22NdFSh9d7fo",@"client":@"1",@"deviceid":@"6D4DD967-5EB2-40E2- A202-37E64F3BEA31",@"limit":[NSString stringWithFormat:@"%ld",self.limitindex * 10],@"start":[NSString stringWithFormat:@"%ld",self.star],@"version":@"3.0.6"}mutableCopy];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    [btn setTitle:@"我要当主播" forState:(UIControlStateNormal)];
    
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    
    [btn addTarget:self action:@selector(next) forControlEvents:(UIControlEventTouchUpInside)];
    
    btn.frame = CGRectMake(kScreenWidth*3/5, 30, 100, 30);
    
    [btn setImage:[[UIImage imageNamed:@"macbook"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]  forState:(UIControlStateNormal)];
    
    [self.view addSubview:btn];
    
    [self tableView];
    
    [self shujujiexi];
    
    [self collcetionV];
    
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*2/5, 20, 40, 40)];
    
    self.imageV.image = [UIImage imageNamed:@"music"];
    
    [self.view addSubview:self.imageV];
    
  }

-(void)donghua
{
    if ([[VideoManager sharInstance]isplay]) {
        [self.imageV.layer addAnimation:self.animation forKey:nil];
        
    }else
    {
        [self.imageV.layer removeAllAnimations];
    }
    
    

}






-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[VideoManager sharInstance]isplay]) {
        
        self.animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        self.animation.toValue = [NSNumber numberWithFloat:M_PI*2];
        
        self.animation.duration = 5;
        
        self.animation.repeatCount = FLT_MAX;
        
        [self.imageV.layer addAnimation:self.animation forKey:nil];
        
    }
    
    
    
}





@end
