//
//  AddressSetViewController.h
//  EatAway商户端
//
//  Created by apple on 2017/7/17.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressSetViewController : UIViewController

@property(nonatomic,assign)id delegate;

@end

@protocol AddressSetViewControllerDelegate <NSObject>

@required

-(void)SelectAddress:(NSString *)strSelectAddress addAddress:(NSString *)strAddressAdd location:(NSString *)strLocation;

@end
