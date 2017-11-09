//
//  SetFreeMoneyViewController.h
//  EatAway商户端
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetFreeMoneyViewController : UIViewController

@property(nonatomic,assign) id delegate;

@end

@protocol SetFreeMoneyViewControllerDelegate <NSObject>

@required

-(void)SetFreeMoney:(NSString *)strResult;
-(void)DeleteFreeMoney;

@end
