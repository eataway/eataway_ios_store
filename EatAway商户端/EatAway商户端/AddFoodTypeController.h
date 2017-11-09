//
//  AddFoodTypeController.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addFoodTypeDelegate <NSObject>

- (void)addRefresh;

@end
@interface AddFoodTypeController : UIViewController
@property (nonatomic, assign) NSInteger vcClass;
@property (nonatomic, assign) NSInteger cidClass;
@property (nonatomic, assign) NSInteger editCid;
@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic, assign) id<addFoodTypeDelegate>addDelegate;

@end
