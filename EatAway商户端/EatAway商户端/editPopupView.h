//
//  editPopupView.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/17.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol editPopupViewDelegate <NSObject>

- (void)changeMethod;
- (void)deleteMethod;

@end
@interface editPopupView : UIView

@property (nonatomic, retain) UIButton *changeBtn;
@property (nonatomic, retain) UIButton *deleteBtn;
@property (nonatomic, assign) id<editPopupViewDelegate>editPopupDelegate;

@end
