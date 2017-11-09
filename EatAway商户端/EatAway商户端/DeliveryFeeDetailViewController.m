//
//  DeliveryFeeDetailViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "DeliveryFeeDetailViewController.h"

#import "SelectViewController.h"
#import "SetFreeMoneyViewController.h"
#import "SetFreeDistanceViewController.h"
#import "SetPriceEachKMViewController.h"
#import "setKmHowMoneyCtrl.h"
//#import "SetMinPassPriceViewController.h"

#import <MBProgressHUD.h>

@interface DeliveryFeeDetailViewController ()<SelectViewControllerDelegate,SetFreeMoneyViewControllerDelegate,SetFreeDistanceViewControllerDelegate,SetPriceEachKMViewControllerDelegate,setKmHowMoneyCtrlDelegate>
{
    
    
    UIView *viewFreeMoney;
    UIView *viewFreeDistance;
    UIView *viewEachKM;
    UIView *viewAdd;
    
    NSString *strFreeMoney;
    NSString *strFreeDistance;
    NSString *strEachKM;
    NSString *strHowKmMoney;
    
    UILabel *labelFreeMoney;
    UILabel *labelFreeDistance;
    UILabel *labelEachKM;
    
    MBProgressHUD *progress;
    SetFreeMoneyViewController *SFMVC;
    SetFreeDistanceViewController *SFDVC;
    SetPriceEachKMViewController *SPEKMVC;
    setKmHowMoneyCtrl *SKMC;
    //SetMinPassPriceViewController *SMPP;
    
    
}
@end

@implementation DeliveryFeeDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = ZEString(@"配送费", @"Delivery fee");
    self.view.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    
    UIView *viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTop.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTop];
    
    UIView *viewUpBorder = [[UIView alloc]initWithFrame:CGRectMake(0, 64 , WINDOWWIDTH, 10)];
    viewUpBorder.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:viewUpBorder];

    
    strFreeMoney = FREEMONEY;
    strFreeDistance = FREEDISTANCE;
    strEachKM = LKMONEY;
    strHowKmMoney = MAXMONEY;

    [self viewFreeMoneyInit];
    [self viewFreeDistanceInit];
    [self viewEachKMInit];
    [self viewAddInit];
    
    
    

    [self refreshView];
    
    
}
-(void)refreshView
{
    CGFloat viewx = 64 + 10;
    
    BOOL hiddenAddBtn = YES;
    
    if (strFreeMoney == nil || [strFreeMoney integerValue] < 0)
    {
        hiddenAddBtn = NO;
        viewFreeMoney.hidden = YES;
    }
    else
    {
        viewFreeMoney.frame = CGRectMake(0, viewx, WINDOWWIDTH, 45);
        viewx = viewx + 45;
        viewFreeMoney.hidden = NO;
        [self labelFreeMoneyContent];
    }
    
//    if (strHowKmMoney == nil || [strHowKmMoney integerValue] < 0)
//    {
//        hiddenAddBtn = NO;
//        viewFreeDistance.hidden = YES;
//    }else{
//        viewFreeDistance.frame = CGRectMake(0, viewx, WINDOWWIDTH, 45);
//        viewFreeDistance.hidden = NO;
//        viewx = viewx + 45;
//        [self labelFreeDistanceContent];
//    }
//
    
    if ((strFreeDistance == nil || [strFreeDistance integerValue] < 0) || (strHowKmMoney == nil || [strHowKmMoney integerValue] < 0) )
    {
        hiddenAddBtn = NO;
        viewFreeDistance.hidden = YES;
    }
    else
    {
        viewFreeDistance.frame = CGRectMake(0, viewx, WINDOWWIDTH, 45);
        viewFreeDistance.hidden = NO;
        viewx = viewx + 45;
        [self labelFreeDistanceContent];
    }
    
    viewEachKM.frame = CGRectMake(0, viewx, WINDOWWIDTH , 45);
    viewx = viewx + 45;
    [self labelEachKMContent];
    
    if (hiddenAddBtn)
    {
        viewAdd.hidden = YES;
    }
    else
    {
        viewAdd.hidden = NO;
    }
    
    
    
}
-(void)viewFreeMoneyInit
{

    viewFreeMoney = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + 10, WINDOWWIDTH, 45)];
    viewFreeMoney.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewFreeMoney];
    
    UIButton *btnFreeMoney = [UIButton buttonWithType:UIButtonTypeCustom];
    btnFreeMoney.frame = CGRectMake(0, 0, WINDOWWIDTH, 44);
    [btnFreeMoney addTarget:self action:@selector(btnFreeMoneyClick) forControlEvents:UIControlEventTouchUpInside];
    [viewFreeMoney addSubview:btnFreeMoney];
    
    labelFreeMoney = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WINDOWWIDTH - 40, 44)];
    labelFreeMoney.font = [UIFont systemFontOfSize:13];
    [viewFreeMoney addSubview:labelFreeMoney];
 
    [self labelFreeMoneyContent];
    
    UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 44, WINDOWWIDTH, 1)];
    viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewFreeMoney addSubview:viewDown];
    
    
}
-(void)labelFreeMoneyContent
{
    NSString *strCN = [NSString stringWithFormat:@"满$%@免配送费",strFreeMoney];
    NSString *strEN = [NSString stringWithFormat:@"Full $%@ free delivery fee",strFreeMoney];
    NSString *strAll = ZEString(strCN,strEN);
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:strAll];
    
    NSRange range;
    if (ISCHINESE)
    {
        range = [strCN rangeOfString:[NSString stringWithFormat:@"$%@",strFreeMoney]];
    }
    else
    {
        range = [strEN rangeOfString:[NSString stringWithFormat:@"$%@",strFreeMoney]];
    }
    
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:range];
    // 为label添加Attributed
    [labelFreeMoney setAttributedText:noteStr];
}
-(void)viewFreeDistanceInit
{
    
    
    viewFreeDistance = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + 10 + 45, WINDOWWIDTH, 45)];
    viewFreeDistance.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewFreeDistance];
    
    UIButton *btnFreeDistance = [UIButton buttonWithType:UIButtonTypeCustom];
    btnFreeDistance.frame = CGRectMake(0, 0, 40, 44);
    [btnFreeDistance addTarget:self action:@selector(btnFreeDistanceClick1) forControlEvents:UIControlEventTouchUpInside];
    [viewFreeDistance addSubview:btnFreeDistance];
    
    
    
    UIButton *btnFreeDistance1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnFreeDistance1.frame = CGRectMake(50, 0, 100, 44);
    [btnFreeDistance1 addTarget:self action:@selector(btnFreeDistanceClick) forControlEvents:UIControlEventTouchUpInside];
    [viewFreeDistance addSubview:btnFreeDistance1];
    
    
    
    
    labelFreeDistance = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WINDOWWIDTH - 40, 44)];
    labelFreeDistance.font = [UIFont systemFontOfSize:13];
    [viewFreeDistance addSubview:labelFreeDistance];
    
    [self labelFreeDistanceContent];
    
    UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 44, WINDOWWIDTH, 1)];
    viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewFreeDistance addSubview:viewDown];
    
    
}
-(void)labelFreeDistanceContent
//$0在0km内
{
    NSString *strCN = [NSString stringWithFormat:@"$%@在%@km内",strHowKmMoney,strFreeDistance];
    NSString *strEN = [NSString stringWithFormat:@"$%@ for orders within %@km kilometers",strHowKmMoney,strFreeDistance];
    NSString *strAll = ZEString(strCN,strEN);
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:strAll];
    
    NSRange range;
    NSRange range1;
    if (ISCHINESE)
    {
        range = [strCN rangeOfString:[NSString stringWithFormat:@"$%@",strHowKmMoney]];
        range1 =[strCN rangeOfString:[NSString stringWithFormat:@"%@km",strFreeDistance]];
    
    }
    else
    {
        range = [strEN rangeOfString:[NSString stringWithFormat:@"$%@",strHowKmMoney]];
        range1 = [strEN rangeOfString:[NSString stringWithFormat:@" %@ km",strFreeDistance]];
    }
    
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:range];
    
    [noteStr addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:range1];
    // 为label添加Attributed
    [labelFreeDistance setAttributedText:noteStr];
}
-(void)viewEachKMInit
{
    viewEachKM = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + 10 + 45 + 45, WINDOWWIDTH, 45)];
    viewEachKM.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewEachKM];
    
    UIButton *btnEachKM = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEachKM.frame = CGRectMake(0, 0, WINDOWWIDTH, 44);
    [btnEachKM addTarget:self action:@selector(btnEachKMClick) forControlEvents:UIControlEventTouchUpInside];
    [viewEachKM addSubview:btnEachKM];
    
    labelEachKM = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WINDOWWIDTH - 40, 44)];
    labelEachKM.font = [UIFont systemFontOfSize:13];
    [viewEachKM addSubview:labelEachKM];
    
    [self labelEachKMContent];
    
    UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 44, WINDOWWIDTH, 1)];
    viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewEachKM addSubview:viewDown];

}
-(void)labelEachKMContent
{
    NSString *strCN = [NSString stringWithFormat:@"每km配送费$%@",strEachKM];
    NSString *strEN = [NSString stringWithFormat:@"$%@ per km",strEachKM];
    NSString *strAll = ZEString(strCN,strEN);
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:strAll];
    
    NSRange range;
    if (ISCHINESE)
    {
        range = [strCN rangeOfString:[NSString stringWithFormat:@"$%@",strEachKM]];
    }
    else
    {
        range = [strEN rangeOfString:[NSString stringWithFormat:@"$%@",strEachKM]];
    }
    
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:range];
    // 为label添加Attributed
    [labelEachKM setAttributedText:noteStr];

}
-(void)viewAddInit
{
    
    viewAdd = [[UIView alloc]initWithFrame:CGRectMake(0, WINDOWHEIGHT - 50, WINDOWHEIGHT, 50)];
    viewAdd.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewAdd];
    
    
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAdd.frame = CGRectMake(0, 0, WINDOWHEIGHT, 50);
    btnAdd.backgroundColor = [UIColor whiteColor];
    [btnAdd addTarget:self action:@selector(btnAddRuleClick) forControlEvents:UIControlEventTouchUpInside];
    [viewAdd addSubview:btnAdd];
    
    UIImageView *IVJia = [[UIImageView alloc]initWithFrame:CGRectMake(100, 10, 30, 30)];
    IVJia.image = [UIImage imageNamed:@"3.2.0_tabbar_add.png"];
    [viewAdd addSubview:IVJia];
    
    UILabel *labelJia = [[UILabel alloc]initWithFrame:CGRectMake(100 + 30 + 10, 10, WINDOWWIDTH - 100 - 30 - 10 - 100, 30)];
    labelJia.text = ZEString(@"添加配送规则", @"New rule");
    labelJia.textColor = MAINCOLOR;
    labelJia.font = [UIFont systemFontOfSize:15];
    labelJia.textAlignment = NSTextAlignmentCenter;
    [viewAdd addSubview:labelJia];
}
-(void)btnAddRuleClick
{
    SelectViewController *SVC = [[SelectViewController alloc]init];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    if (viewFreeMoney.hidden == YES)
    {
        [arr addObject:ZEString(@"满金额免配送费", @"Free delivery for order over")];
    }
    if (viewFreeDistance.hidden == YES)
    {
        [arr addObject:ZEString(@"多少千米多少配送费", @"How much delivery for orders whthin(km)")];
    }
    SVC.arrSelect = arr;
    SVC.delegate = self;
    [self.navigationController pushViewController:SVC animated:YES];
    
    
}
-(void)btnFreeMoneyClick
{
    SFMVC = [[SetFreeMoneyViewController alloc]init];
    SFMVC.delegate = self;
    [self.view addSubview:SFMVC.view];
}
-(void)btnFreeDistanceClick
{
    SFDVC = [[SetFreeDistanceViewController alloc]init];
    SFDVC.delegate = self;
    [self.view addSubview:SFDVC.view];
}

-(void)btnFreeDistanceClick1{
    SKMC = [[setKmHowMoneyCtrl alloc]init];
    SKMC.delegate = self;
    [self.view addSubview:SKMC.view];
}




-(void)btnEachKMClick
{
    SPEKMVC = [[SetPriceEachKMViewController alloc]init];
    SPEKMVC.delegate = self;
    [self.view addSubview:SPEKMVC.view];
}
-(void)selectViewControllerResult:(NSString *)selectResult identifier:(NSInteger)identifier
{
    if ([selectResult isEqualToString:@"Free delivery for order over"] || [selectResult isEqualToString:@"满金额免配送费"])
    {
        strFreeMoney = @"0";
        [self viewFreeMoneyInit];
        [self SetFreeMoney:@"0"];
    }
    else if ([selectResult isEqualToString:@"How much delivery for orders whthin(km)"] || [selectResult isEqualToString:@"多少千米多少配送费"])
    {
        strFreeDistance = @"0";
        [self SetFreeDistance:@"0"];
    }
    [self refreshView];
    
    
}
-(void)SetFreeMoney:(NSString *)strResult
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        __weak DeliveryFeeDetailViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/user/editprice" parameter:@{@"shopid":USERID,@"token":TOKEN,@"maxprice":strResult} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                strFreeMoney = strResult;
                [blockSelf labelFreeMoneyContent];
                [[NSUserDefaults standardUserDefaults] setObject:strResult forKey:@"freemoney"];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }

            
        }];
        
    }

}
-(void)DeleteFreeMoney
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        __weak DeliveryFeeDetailViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/shop/backprice" parameter:@{@"shopid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"删除失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                strFreeMoney = @"-1";
                [blockSelf refreshView];
                [[NSUserDefaults standardUserDefaults] setObject:@"-1" forKey:@"freemoney"];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"删除失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }
            
            
        }];
        
    }

}

-(void)SetFreeDistance:(NSString *)strResult
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        __weak DeliveryFeeDetailViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/user/editmaxlong" parameter:@{@"shopid":USERID,@"token":TOKEN,@"maxlong":strResult} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                strFreeDistance = strResult;
                [blockSelf labelFreeDistanceContent];
                [[NSUserDefaults standardUserDefaults] setObject:strResult forKey:@"freedistance"];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }
            
            
        }];
        
    }

}


-(void)SetKmHowMoney:(NSString *)strResult{
    
    
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        __weak DeliveryFeeDetailViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/user/editmaxmoney" parameter:@{@"shopid":USERID,@"token":TOKEN,@"maxmoney":strResult} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                strHowKmMoney = strResult;
                [blockSelf labelFreeDistanceContent];
                [[NSUserDefaults standardUserDefaults] setObject:strResult forKey:@"maxmoney1111"];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }
            
            
        }];
        
    }
    
}

-(void)deleteMoeny{
    [self deleteFreeDistance];
}




-(void)deleteFreeDistance
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        __weak DeliveryFeeDetailViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/shop/backlong" parameter:@{@"shopid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"删除失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                strFreeDistance = @"-1";
                [blockSelf refreshView];
                [[NSUserDefaults standardUserDefaults] setObject:@"-1" forKey:@"freedistance"];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"删除失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }
            
            
        }];
        
    }
}

-(void)SetPriceEachKM:(NSString *)strResult
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        __weak DeliveryFeeDetailViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/user/editlkmoney" parameter:@{@"shopid":USERID,@"token":TOKEN,@"lkmoney":strResult} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                strEachKM = strResult;
                [blockSelf labelEachKMContent];
                [[NSUserDefaults standardUserDefaults] setObject:strResult forKey:@"lkmoney"];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"operation failed, please check the network connection") onViewController:blockSelf];
            }
            
            
        }];
        
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
