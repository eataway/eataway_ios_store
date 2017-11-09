//
//  foodListManagerModel.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/17.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "JSONModel.h"

@interface foodListManagerModel : JSONModel

@property (nonatomic, copy)NSString <Optional> *cid;
@property (nonatomic, copy)NSString <Optional> *cname;
@property (nonatomic, copy)NSString <Optional> *num;
//{
//    msg =     (
//               {
//                   cid = 8;
//                   cname = "\U70e4\U5168\U9c7c";
//                   num = 1;
//               },
//               {
//                   cid = 9;
//                   cname = "\U8349\U9c7c";
//                   num = 1;
//               },
//               {
//                   cid = 10;
//                   cname = "\U9ca4\U9c7c";
//                   num = 1;
//               }
//               );
//    status = 1;
//}
@end
