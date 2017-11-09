//
//  SetShopOpenTimeViewController.h
//  EatAway商户端
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetShopOpenTimeViewController : UIViewController

@property(nonatomic,assign)id delegate;

@end

@protocol SetShopOpenTimeViewControllerDelegate <NSObject>

@required
-(void)SetShopOpenTIime:(NSString *)strOpenTime;

@end
