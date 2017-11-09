//
//  SeverHeader.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/17.
//  Copyright © 2017年 allen. All rights reserved.
//

#ifndef SeverHeader_h
#define SeverHeader_h

#define Server_Address @"http://wm.sawfree.com/index.php/server/"
//#define Server_Address @"http://108.61.96.39/index.php/server/"

/**
 * 商户菜单列表
 */
#define Server_Categorylist [Server_Address stringByAppendingString:@"shop/categorylist"]

/**
 * 添加商铺菜单
 */
#define Server_Addcategory [Server_Address stringByAppendingString:@"shop/addcategory"]

/**
 * 修改商铺菜单
 */
#define Server_Editcategory [Server_Address stringByAppendingString:@"shop/editcategory"]

/**
 * 删除商铺菜单
 */
#define Server_Deletecategory [Server_Address stringByAppendingString:@"shop/deletecategory"]

/**
 * 商户商品列表
*/
#define Server_Menugoods [Server_Address stringByAppendingString:@"shop/menugoods"]

/**
 * 商户菜品详情
 */
#define Server_Menudetail [Server_Address stringByAppendingString:@"shop/menudetail"]

/**
 * 添加菜品
 */
#define Server_Addgoods [Server_Address stringByAppendingString:@"shop/addgoods"]

/**
 * 删除菜品
 */
#define Server_Deletegoods [Server_Address stringByAppendingString:@"shop/deletegoods"]

/**
 * 商户修改菜品
 */
#define Server_Editgoods [Server_Address stringByAppendingString:@"shop/editgoods"]


/**
 * 修改商品状态为已售完
 */
#define Server_Editflagb [Server_Address stringByAppendingString:@"shop/editflagb"]

/**
 * 修改商品状态为在售
 */
#define Server_Editflaga [Server_Address stringByAppendingString:@"shop/editflaga"]


#endif /* SeverHeader_h */
