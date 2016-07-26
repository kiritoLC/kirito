//
//  ReadViewController.m
//  product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ReadViewController.h"
#import "ReadModel.h"
#import "CarouselView.h"
#import "ReadCollectionViewCell.h"
#import "ReadDetadilViewController.h"
#import "ReadCollectionDetailViewController.h"
@interface ReadViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)NSMutableArray *itemArr;
@property(nonatomic,strong)UICollectionView *collection;



@end

@implementation ReadViewController

-(NSMutableArray *)itemArr
{
    if (!_itemArr) {
        _itemArr = [NSMutableArray array];
        
    }
    return _itemArr;
}


-(NSMutableArray *)arr
{
    if (!_arr) {
        _arr = [NSMutableArray array];
        
    }
    return _arr;
    
}

-(void)shujujiexi
{
  
    [RequestManager requestWithURLString:Kread pardic:nil requesttype:requestGET finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.arr = [ReadModel ModelConfigure:dic];

        
        NSMutableArray *Imagearr= [NSMutableArray array];
        for (ReadModel *model in self.arr) {
            
            NSString *string = model.img;
            
            [Imagearr addObject:string];
        }
        
        CarouselView *carousView = [[CarouselView alloc]initWithFrame:CGRectMake(0, KNaviH+21 , kScreenWidth, 200) imageURLs:Imagearr];
        
        [self.view addSubview:carousView];
        
      
        carousView.userInteractionEnabled  = YES;
        carousView.imageClick = ^(NSInteger index){
    
            ReadModel *model = self.arr[index];
            
            
            ReadDetadilViewController *readDetail = [[ReadDetadilViewController alloc]init];
            
            readDetail.html = model.url;
            [self.navigationController pushViewController:readDetail animated:YES];
        };
        
        
        

        self.itemArr = [ReadModel itemModelConfigure:dic];
        [self.collection reloadData];

    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    

}


-(void)collectionV
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumInteritemSpacing = 5;
    
    layout.minimumLineSpacing = 5;
    
    layout.itemSize = CGSizeMake((kScreenWidth-30)/3, 150);
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 270, kScreenWidth, kScreenHeight-270) collectionViewLayout:layout];
    
    self.collection.backgroundColor = [UIColor whiteColor];
   
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    self.collection.showsVerticalScrollIndicator = NO;
    
    UINib *nib = [UINib nibWithNibName:@"ReadCollectionViewCell" bundle:[NSBundle mainBundle]];
    
    [self.collection registerNib:nib forCellWithReuseIdentifier:@"ss"];
    
    [self.view addSubview:self.collection];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReadModel *model = self.itemArr[indexPath.row];
    
    ReadCollectionViewCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:@"ss" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:model.coverimg];
    
    [cell.imageV sd_setImageWithURL:url placeholderImage:nil completed:nil];
    
    cell.nameL.text = model.name;
    
    cell.nameL.textColor = [UIColor whiteColor];
    
    cell.nameL.textAlignment = 1;
    
    cell.nameL.font = [UIFont systemFontOfSize:15];
    
    cell.l2.text = model.enname;
    
    cell.l2.textColor = [UIColor whiteColor];
    
    cell.l2.textAlignment = 0;
    
    cell.l2.font = [UIFont systemFontOfSize:12];
    
    [cell.nameL sizeToFit];
    
    [cell.l2 sizeToFit];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    
    animation.toValue = [NSNumber numberWithFloat:M_PI*2];
    
    animation.duration = 1;
    
    animation.repeatCount = 1;
    
    [cell.layer addAnimation:animation forKey:nil];
    
    
    
    
    
    
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ReadModel *model = self.itemArr[indexPath.row];
    
    ReadCollectionDetailViewController *coll = [[ReadCollectionDetailViewController alloc]init];
    
   
    
    
    
    coll.typedid = model.type;
    
    
    [self.navigationController pushViewController:coll animated:YES];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self shujujiexi];
    
    [self collectionV];
 
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
