//
//  ObjectForUser.m
//  EatAway
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "ObjectForUser.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif



@implementation ObjectForUser

+(void)clearLogin
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickname"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phonenumber"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headphoto"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shoppicture"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shoplocation"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shopphonenumber"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"merchantstate"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shopdescription"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"gotime"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lkmoney"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"freedistance"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"freemoney"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"maxdistance"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"minpassprices"];
 
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    } seq:1];

}
+(BOOL)checkLogin
{
    if (USERID == nil || TOKEN == nil)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
