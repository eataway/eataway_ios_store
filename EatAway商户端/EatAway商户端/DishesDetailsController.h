//
//  DishesDetailsController.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol dishesDetailsDelegate <NSObject>

- (void)refresh;

@end

@interface DishesDetailsController : UIViewController
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic, retain) NSIndexPath *deleteIndex;
@property (nonatomic, assign)id<dishesDetailsDelegate>detailsDelegate;
@property (nonatomic, assign) NSInteger judge;

@end
