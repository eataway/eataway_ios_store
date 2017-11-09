//
//  foodListDetailsModel.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/17.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "JSONModel.h"

@interface foodListDetailsModel : JSONModel
@property (nonatomic, copy)NSString <Optional> *addtime;
@property (nonatomic, copy)NSString <Optional> *cid;
@property (nonatomic, copy)NSString <Optional> *flag;
@property (nonatomic, copy)NSString <Optional> *goodscontent;
@property (nonatomic, copy)NSString <Optional> *goodsid;
@property (nonatomic, copy)NSString <Optional> *goodsname;
@property (nonatomic, copy)NSString <Optional> *goodsphoto;
@property (nonatomic, copy)NSString <Optional> *goodsprice;
@property (nonatomic, copy)NSString <Optional> *shopid;

//{
//    msg =     (
//               {
//                   addtime = "2017-07-07 10:37:55";
//                   cid = 8;
//                   flag = 1;
//                   goodscontent = "\U70e4\U5168\U9c7c";
//                   goodsid = 4;
//                   goodsname = "\U70e4\U5168\U9c7c";
//                   goodsphoto = "uploads/e66202a835c1558de685bb9cf7abc95e.jpg";
//                   goodsprice = "88.00";
//                   shopid = 4;
//               },
//               {
//                   addtime = "2017-07-07 10:38:27";
//                   cid = 9;
//                   flag = 1;
//                   goodscontent = "\U8349\U9c7c";
//                   goodsid = 5;
//                   goodsname = "\U8349\U9c7c";
//                   goodsphoto = "uploads/338f0cd8e9bc837dea4bf59d05b8e2e9.png";
//                   goodsprice = "99.00";
//                   shopid = 4;
//               }
//               );
//    status = 1;
//}

@end
