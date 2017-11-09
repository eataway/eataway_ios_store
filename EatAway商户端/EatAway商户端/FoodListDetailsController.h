//
//  FoodListDetailsController.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol foodListDetailsDelegate <NSObject>

- (void)listDetailsRefresh;

@end

@interface FoodListDetailsController : UIViewController
@property (nonatomic, retain) NSString *titleStr;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign)id<foodListDetailsDelegate>detailsDelegate;
@end
