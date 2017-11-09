//
//  SetFreeDistanceViewController.h
//  EatAway商户端
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetFreeDistanceViewController : UIViewController

@property(nonatomic,assign) id delegate;

@end

@protocol SetFreeDistanceViewControllerDelegate <NSObject>

@required

-(void)SetFreeDistance:(NSString *)strResult;
-(void)deleteFreeDistance;

@end
