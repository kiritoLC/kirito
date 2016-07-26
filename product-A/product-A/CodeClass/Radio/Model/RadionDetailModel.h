//
//  RadionDetailModel.h
//  product-A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadionDetailModel : NSObject


#pragma mark ---最上面的model
@property(nonatomic,strong)NSString *coverimg;


@property(nonatomic,strong)NSString *title;






//@property(nonatomic,strong)NSString *radioid;



+(RadionDetailModel *)upModelConfigure:(NSDictionary *)jsonDic;







@end
