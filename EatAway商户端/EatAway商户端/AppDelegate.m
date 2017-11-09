//
//  AppDelegate.m
//  EatAway商户端
//
//  Created by apple on 2017/7/11.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "AppDelegate.h"

#import "OrderManagementViewController.h"
#import "FoodListManagementViewController.h"
#import "ReviewsViewController.h"
#import "MerchantViewController.h"


// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


@import GoogleMaps;
@import GooglePlaces;

@interface AppDelegate ()<JPUSHRegisterDelegate>
{
    UITabBarController *tabbar;
    OrderManagementViewController *OMVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self dataInit];
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"a81b6096697fa2f544fc0157"
                          channel:@"APPStore"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    
    
    if ([ObjectForUser checkLogin])
    {
        [JPUSHService setAlias:USERID completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            nil;
        } seq:1];
    }
    
    
    
    
    OMVC = [[OrderManagementViewController alloc]init];
    UINavigationController *OMNC = [[UINavigationController alloc]initWithRootViewController:OMVC];
    OMNC.navigationBar.barTintColor = MAINCOLOR;
    OMNC.navigationBar.tintColor = [UIColor whiteColor];
    OMNC.title = ZEString(@"订单管理", @"Orders");
    [[NSNotificationCenter defaultCenter] addObserver:OMVC selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    
    
    FoodListManagementViewController *FLMVC = [[FoodListManagementViewController alloc]init];
    UINavigationController *FLMNC = [[UINavigationController alloc]initWithRootViewController:FLMVC];
    FLMNC.navigationBar.barTintColor = MAINCOLOR;
    FLMNC.navigationBar.tintColor = [UIColor whiteColor];
    FLMNC.title = ZEString(@"菜单管理", @"Menu");
    [[NSNotificationCenter defaultCenter] addObserver:FLMVC selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];

    ReviewsViewController *RVC = [[ReviewsViewController alloc]init];
    UINavigationController *RNC = [[UINavigationController alloc]initWithRootViewController:RVC];
    RNC.navigationBar.barTintColor = MAINCOLOR;
    RNC.navigationBar.tintColor = [UIColor whiteColor];
    RNC.title = ZEString(@"评论", @"Reviews");
    [[NSNotificationCenter defaultCenter] addObserver:RVC selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];


    MerchantViewController *MVC = [[MerchantViewController alloc]init];
    UINavigationController *MNC = [[UINavigationController alloc]initWithRootViewController:MVC];
    MNC.navigationBar.barTintColor = MAINCOLOR;
    MNC.navigationBar.tintColor = [UIColor whiteColor];
    MNC.title = ZEString(@"商家信息",@"Business");
    [[NSNotificationCenter defaultCenter] addObserver:MVC selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    

    tabbar = [[UITabBarController alloc]init];

    [tabbar setViewControllers:@[OMNC,FLMNC,RNC,MNC]];
    
    NSArray *arrImageName = @[@"tab_icon_1order_nor.png",@"tab_icon_2food_nor.png",@"tab_icon_3comment_nor.png",@"tab_icon_4business_nor.png"];
    NSArray *arrSelectedImageName = @[@"tab_icon_1order_sel.png",@"tab_icon_2food_sel.png",@"tab_icon_3comment_sel.png",@"tab_icon_4business_sel.png"];
    
    NSArray *items = tabbar.tabBar.items;
    for (int a = 0; a < items.count; a ++)
    {
        UITabBarItem *item = items[a];
        item.image = [[UIImage imageNamed:arrImageName[a]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:arrSelectedImageName[a]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    tabbar.tabBar.barTintColor = [UIColor whiteColor];
    
    self.window.rootViewController = tabbar;
    
    return YES;
}
-(void)changeLanguage
{
    
}
-(void)dataInit
{
    if (ISOPEN == nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isopen"];
    }
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"firstopen"];

    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"push"];

    [GMSPlacesClient provideAPIKey:@"AIzaSyBa3r2GEXn-tdOHMX_b8TS4v4rHwn6xIVU"];
    [GMSServices provideAPIKey:@"AIzaSyDZNFNTehOoQgH9T_glAnsDLRWSItBroWo"];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//极光推送
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    

    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    [tabbar setSelectedIndex:0];
    [OMVC refreshViewToDoViewAddDic:userInfo];
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    [tabbar setSelectedIndex:0];
    [OMVC refreshViewToDoView];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"push"];
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];

    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}


@end
