//
//  HeadImageNameDescriptionViewController.h
//  EatAway商户端
//
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadImageNameDescriptionViewController : UIViewController

@property(nonatomic,assign)id delegate;

@end


@protocol HeadImageNameDescriptionViewControllerDelegate <NSObject>

@required
-(void)HeadImageNameDescriptionChangeSucceedHeadImage:(NSString *)headImage name:(NSString *)strName description:(NSString *)strDescription;

@end
