//
//  MerchantReplyViewController.h
//  EatAway商户端
//
//  Created by apple on 2017/7/21.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantReplyViewController : UIViewController

@property(nonatomic,assign)id delegate;
@property(nonatomic,assign)NSInteger cellIndex;

@end

@protocol MerchantReplyViewControllerDelegate <NSObject>

@required
-(void)MerchantReplayContent:(NSString *)strContent index:(NSInteger)cellIndex;

@end
