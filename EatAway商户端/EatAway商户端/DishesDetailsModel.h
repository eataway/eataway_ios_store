//
//  DishesDetailsModel.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/18.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "JSONModel.h"

@interface DishesDetailsModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *cid;
@property (nonatomic, copy) NSString <Optional> *fenlei;
@property (nonatomic, copy) NSString <Optional> *flag;
@property (nonatomic, copy) NSString <Optional> *goodscontent;
@property (nonatomic, copy) NSString <Optional> *goodsname;
@property (nonatomic, copy) NSString <Optional> *goodsphoto;
@property (nonatomic, copy) NSString <Optional> *goodsprice;
@property (nonatomic, copy) NSString <Optional> *num;

//{
//    msg =     {
//        cid = 8;
//        fenlei = "\U70e4\U5168\U9c7c";
//        flag = 1;
//        goodscontent = "\U70e4\U5168\U9c7c";
//        goodsname = "\U70e4\U5168\U9c7c";
//        goodsphoto = "uploads/e66202a835c1558de685bb9cf7abc95e.jpg";
//        goodsprice = "88.00";
//        num = 2;
//    };
//    status = 1;
//}
@end
