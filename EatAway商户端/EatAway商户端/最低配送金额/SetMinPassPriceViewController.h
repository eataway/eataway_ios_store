//
//  SetMinPassPriceViewController.h
//  EatAway商户端
//
//  Created by 张子国 on 17/10/11.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetMinPassPriceViewController : UIViewController
@property(nonatomic,assign) id delegate;

@end

@protocol SetMinPassPriceViewControllerDelegate <NSObject>

@required

-(void)SetMinPassPrice:(NSString *)strResult;

@end
