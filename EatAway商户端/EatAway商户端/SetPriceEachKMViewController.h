//
//  SetPriceEachKMViewController.h
//  EatAway商户端
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPriceEachKMViewController : UIViewController

@property(nonatomic,assign) id delegate;

@end

@protocol SetPriceEachKMViewControllerDelegate <NSObject>

@required

-(void)SetPriceEachKM:(NSString *)strResult;

@end
