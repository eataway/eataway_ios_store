//
//  SetDelivertDistanceViewController.h
//  EatAway商户端
//
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetDelivertDistanceViewController : UIViewController

@property(nonatomic,assign) id delegate;

@end

@protocol SetDelivertDistanceViewControllerDelegate <NSObject>

@required

-(void)SetDeliveryDistance:(NSString *)strDistance;

@end
