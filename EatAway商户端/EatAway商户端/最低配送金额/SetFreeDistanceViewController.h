//
//  SetFreeDistanceViewController.h
//  EatAway商户端
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetFreeDistanceViewController1 : UIViewController

@property(nonatomic,assign) id delegate;

@end

@protocol SetFreeDistanceViewControllerDelegate1 <NSObject>

@required

-(void)SetMinprice:(NSString *)strResult;
-(void)deleteFreeDistance;

@end
