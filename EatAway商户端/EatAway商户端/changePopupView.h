//
//  changePopupView.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/17.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol changePopupVoewDelegate <NSObject>

- (void)cancelMethod;
- (void)confirmMethod;


@end

@interface changePopupView : UIView

@property (nonatomic, assign)id<changePopupVoewDelegate>changePopupDelegate;

@end
