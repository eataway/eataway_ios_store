//
//  foodListPopupView.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol foodListPopupDelegate <NSObject>

- (void)cancelMethod;
- (void)confirmMethod;


@end

@interface foodListPopupView : UIView
@property (nonatomic, assign) NSInteger vcClass;
@property (nonatomic, retain) UILabel *titleLab;
@property (nonatomic, retain) UITextField *titleField;
@property (nonatomic, retain) UIButton *cancelBtn;
@property (nonatomic, retain) UIButton *confirmBtn;
@property (nonatomic, assign)id<foodListPopupDelegate>popupDelegate;


@end
