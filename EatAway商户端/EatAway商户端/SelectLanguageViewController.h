//
//  SelectLanguageViewController.h
//  EatAway商户端
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectLanguageViewController : UIViewController

@property(nonatomic,assign)id delegate;

@end

@protocol SelectLanguageViewControllerDelegate <NSObject>

@required
-(void)SelectLanguageSucceedWithTag:(NSInteger)indexTag;

@end
