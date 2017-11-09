//
//  setKmHowMoneyCtrl.h
//  EatAway商户端
//
//  Created by 张子国 on 17/10/12.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setKmHowMoneyCtrl : UIViewController
@property(nonatomic,assign) id delegate;

@end

@protocol setKmHowMoneyCtrlDelegate <NSObject>

@required

-(void)SetKmHowMoney:(NSString *)strResult;
-(void)deleteMoeny;


@end
