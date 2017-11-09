//
//  MerchantViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/11.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantViewController.h"

#import "LoginWithPhoneViewController.h"
#import "MerchantDetailTableViewCell.h"
#import "MerchantCertificationViewController.h"
#import "MerchantCenterSettingViewController.h"
#import "FeedbackViewController.h"
#import "MerchantIncomeViewController.h"
#import "CertificationInfoViewController.h"

#import "MerchantDetailViewController.h"


#import <UIButton+WebCache.h>
#import <MBProgressHUD.h>

@interface MerchantViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIButton *btnHead;
    
    UILabel *labelName;
    UILabel *labelAddress;
    
    UILabel *labelOrderMoneyTips;
    UILabel *labelOrderNumTips;
    UILabel *labelTitleIsOpen;
    
    UISwitch *switchOpen;
    
    CGFloat allSellPrice;
    NSInteger allSellOrderNum;
    
    UILabel *labelOrderMoney;
    UILabel *labelOrderNum;
    MBProgressHUD *progress;
}
@end

@implementation MerchantViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
//    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 300, WINDOWWIDTH, 200)];
//    iv.image = [UIImage imageNamed:@"5.1.0_pic_bg.png"];
//    [self.view addSubview:iv];
    
    [self tableViewInit];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [switchOpen setOn:[ISOPEN isEqual:@"1"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];

    
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"userid = %@,token = %@",USERID,TOKEN);
    if ([ObjectForUser checkLogin])
    {
        __weak MerchantViewController *blockSelf = self;
        [[ObjectForRequest shareObject]requestWithURL:@"index.php/server/user/shopmesa" parameter:@{@"shopid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"获取商户信息错误，请检查网络连接", @"Get information error, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                NSDictionary *dic = resultDic[@"msg"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"shopname"]forKey:@"nickname"];
                
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"shophead"] forKey:@"headphoto"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"coordinate"] forKey:@"shoplocation"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"detailed_address"] forKey:@"shopaddress"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"shopphoto"] forKey:@"shoppicture"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"mobile"] forKey:@"shopphonenumber"];

                [[NSUserDefaults standardUserDefaults] setObject:dic[@"gotime"] forKey:@"gotime"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"lkmoney"] forKey:@"lkmoney"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"maxlong"] forKey:@"freedistance"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"maxprice"] forKey:@"freemoney"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"long"] forKey:@"maxdistance"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"content"] forKey:@"shopdescription"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"lmoney"] forKey:@"minpassprices"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"maxmoney"] forKey:@"maxmaxmoney1111"];
                

                if ([dic[@"state"] isEqualToString:@"3"])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"merchantstate"];
                    labelName.text = ZEString(@"认证中", @"Authenticating");
                    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"isopen"];
                    labelAddress.text = @"";
                }
//                else if ([dic[@"state"] isEqualToString:@"1"] || [dic[@"state"] isEqualToString:@"2"])
                else
                {
                    allSellOrderNum = [dic[@"nums"] integerValue];
                    labelOrderNum.text = [NSString stringWithFormat:@"%ld",allSellOrderNum];
                    
                    allSellPrice = [dic[@"allmoney"] floatValue];
                    labelOrderMoney.text = [NSString stringWithFormat:@"%.2f",allSellPrice];
                    
                    labelName.text = NICKNAME;
                    labelAddress.text = SHOPADDRESS;
                    [btnHead sd_setImageWithURL:[NSURL URLWithString:HEADPHOTO] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"5.2.0_pic_head.png"]];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:dic[@"state"] forKey:@"merchantstate"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic[@"state"] forKey:@"isopen"];

                    if ([MERCHANTSTATE isEqualToString:@"4"])
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"isopen"];
                    }
                    switchOpen.on = [ISOPEN isEqual:@"1"];
                }

                
            }
            else if([resultDic[@"status"] isEqual:@(2)])
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"5" forKey:@"merchantstate"];
                labelName.text = ZEString(@"未认证商户", @"Unauthenticated merchant");
                labelAddress.text = @"";
            }
            else if([resultDic[@"status"] isEqual:@(3)])
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"merchantstate"];
                labelName.text = ZEString(@"认证中", @"Authenticating");
                labelAddress.text = @"";
            }


            else
            {
                [TotalFunctionView alertContent:ZEString(@"获取商户信息错误，请检查网络连接", @"Get information error, please check the network connection") onViewController:blockSelf];
            }
        }];
    }
    else
    {
        [btnHead sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"5.2.0_pic_head.png"]];
        labelName.text = ZEString(@"未登录", @"No login");
        labelAddress.text = @"";
        labelOrderMoney.text = @"0.00";
        labelOrderNum.text = @"0";
        

    }

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)changeLanguage
{
    labelOrderMoneyTips.text = ZEString(@"销售额", @"Sales");
    labelOrderNumTips.text = ZEString(@"订单数", @"Orders");
    labelTitleIsOpen.text = ZEString(@"是否营业", @"Open");

    
    MerchantDetailTableViewCell *cell6 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    cell6.labelTitle.text = ZEString(@"收入明细", @"Income");

    MerchantDetailTableViewCell *cell7 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    cell7.labelTitle.text = ZEString(@"认证状态", @"Certification");

    MerchantDetailTableViewCell *cell8 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    cell8.labelTitle.text = ZEString(@"系统设置", @"Setting");
    
    MerchantDetailTableViewCell *cell9 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0]];
    cell9.labelTitle.text = ZEString(@"问题反馈", @"Feedback");
    
    self.navigationController.tabBarItem.title = ZEString(@"商家信息", @"Business");

    

}
-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, WINDOWWIDTH,20 + WINDOWHEIGHT - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(12, 22, 8, 20);
    [btnBack setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 180;
    }
    else if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 )
    {
        return 15;
    }
    else if (indexPath.row == 2)
    {
        return 70;
    }
    else if (indexPath.row == 4)
    {
        return 50;
    }
    else if (indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9)
    {
        return 50;
    }
    else
    {
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell00"];
        if (!cell)
        {
            CGFloat cellHeght = 180;
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell00"];
            
            UIImageView *IVBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, cellHeght)];
            IVBG.image = [UIImage imageNamed:@"5.1.0_pic_bg.png"];
            [cell addSubview:IVBG];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            btnHead = [UIButton buttonWithType:UIButtonTypeCustom];
            btnHead.clipsToBounds = YES;
            btnHead.layer.cornerRadius = 80 * cellHeght/360;
            [btnHead sd_setImageWithURL:[NSURL URLWithString:HEADPHOTO] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"5.2.0_pic_head.png"]];
            btnHead.frame = CGRectMake(10, 130 * cellHeght/360, 160 * cellHeght/360 , 160 * cellHeght/360);
            [btnHead addTarget:self action:@selector(btnHeadImageClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnHead];
            
            labelName = [[UILabel alloc]initWithFrame:CGRectMake(10 +  160 * cellHeght/360 + 10, 140 * cellHeght/360, WINDOWWIDTH - (10 + 160 * cellHeght/360 + 40),  90 * cellHeght/360)];
            labelName.font = [UIFont systemFontOfSize:15];
            [cell addSubview:labelName];
            
            labelAddress = [[UILabel alloc]initWithFrame:CGRectMake(10 +  160 * cellHeght/360 + 10, 230 * cellHeght/360 , WINDOWWIDTH - (10 + 160 * cellHeght/360 + 40), 60 * cellHeght/360)];
            labelAddress.numberOfLines = 2;
            labelAddress.font = [UIFont systemFontOfSize:13];
            [cell addSubview:labelAddress];
            

            
        }
        
    }
    else if (indexPath.row == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell02"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell02"];
            
            cell.backgroundColor = [UIColor whiteColor];
            
            labelOrderMoney = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH/2 - 10 - 10 - 1, 30)];
            labelOrderMoney.textColor = MAINCOLOR;
            labelOrderMoney.textAlignment = NSTextAlignmentCenter;
            labelOrderMoney.font = [UIFont systemFontOfSize:18];
            [cell addSubview:labelOrderMoney];
            
            labelOrderMoneyTips = [[UILabel alloc]initWithFrame:CGRectMake(10 , 40, WINDOWWIDTH/2 - 10 - 10 -1, 20)];
            labelOrderMoneyTips.font = [UIFont systemFontOfSize:15];
            labelOrderMoneyTips.textAlignment = NSTextAlignmentCenter;
            labelOrderMoneyTips.textColor = [UIColor blackColor];
            labelOrderMoneyTips.text = ZEString(@"销售额", @"Sales");
            [cell addSubview:labelOrderMoneyTips];
            
            UIView *viewl = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH/2, 10, 1, 50)];
            viewl.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewl];
            
            labelOrderNum = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH/2 + 10, 10, WINDOWWIDTH/2 - 10 - 10 - 1, 30)];
            labelOrderNum.textColor = MAINCOLOR;
            labelOrderNum.textAlignment = NSTextAlignmentCenter;
            labelOrderNum.font = [UIFont systemFontOfSize:18];
            [cell addSubview:labelOrderNum];
            
            labelOrderNumTips = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH/2 + 10 , 40 , WINDOWWIDTH/2 - 10 - 10 -1, 20)];
            labelOrderNumTips.font = [UIFont systemFontOfSize:15];
            labelOrderNumTips.textAlignment = NSTextAlignmentCenter;
            labelOrderNumTips.textColor = [UIColor blackColor];
            labelOrderNumTips.text = ZEString(@"订单数", @"Orders");
            [cell addSubview:labelOrderNumTips];
            
            
        }
        
    }
    else if (indexPath.row == 4)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell04"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell04"];
            
            UIImageView *IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
            IVHead.image = [UIImage imageNamed:@"5.1.0_icon_01.png"];
            [cell addSubview:IVHead];
            
            labelTitleIsOpen = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, WINDOWWIDTH - 40 - 30, 30)];
            labelTitleIsOpen.font = [UIFont systemFontOfSize:13];
            labelTitleIsOpen.text = ZEString(@"是否营业", @"Open");
            [cell addSubview:labelTitleIsOpen];
            
            switchOpen = [[UISwitch alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 70, 10, 50, 30)];
            [switchOpen addTarget:self action:@selector(switchOpenValueChange:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:switchOpen];
        }
        switchOpen.on = [ISOPEN isEqualToString:@"1"];

    }
    else if (indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 ||indexPath.row == 9)
    {
        MerchantDetailTableViewCell *cell0;
        cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell6789"];
        if (!cell0)
        {
            cell0 = [[MerchantDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell6789"];
            cell0.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        NSArray *arrImageName = @[@"5.1.0_icon_02.png",@"5.1.0_icon_03.png",@"5.1.0_icon_04.png",@"5.1.0_icon_05.png"];
        NSArray *arrTitle = @[ZEString(@"收入明细", @"Income"),ZEString(@"认证状态", @"Certification"),ZEString(@"系统设置", @"Setting"),ZEString(@"问题反馈", @"Feedback")];
        [cell0 setContentWithImage:[UIImage imageNamed:arrImageName[indexPath.row - 6]] title:arrTitle[indexPath.row - 6]];
        cell = cell0;
        
    }
    else if (indexPath.row == 1 ||indexPath.row == 3 ||indexPath.row == 5 )
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellblank"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellblank"];
        }
        cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        [self btnHeadImageClick];
    }
    else if ([ObjectForUser checkLogin])
    {
        if(indexPath.row == 6)
        {
            MerchantIncomeViewController *MIVC = [[MerchantIncomeViewController alloc]init];
            MIVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:MIVC animated:YES];
        }
        else if (indexPath.row == 7)
        {
            if ([MERCHANTSTATE isEqualToString:@"3"])
            {
                CertificationInfoViewController *CIVC = [[CertificationInfoViewController alloc]init];
                CIVC.hidesBottomBarWhenPushed = YES;
                CIVC.hideQuitBtn = YES;
                [self.navigationController pushViewController:CIVC animated:YES];
            }
            else if([MERCHANTSTATE isEqualToString:@"1"] || [MERCHANTSTATE isEqualToString:@"2"])
            {
                CertificationInfoViewController *CIVC = [[CertificationInfoViewController alloc]init];
                CIVC.hidesBottomBarWhenPushed = YES;
                CIVC.hideQuitBtn = NO;
                [self.navigationController pushViewController:CIVC animated:YES];
            }
            else if ( [MERCHANTSTATE isEqualToString:@"4"])
            {
                CertificationInfoViewController *CIVC = [[CertificationInfoViewController alloc]init];
                CIVC.hidesBottomBarWhenPushed = YES;
                CIVC.hideQuitBtn = YES;
                [self.navigationController pushViewController:CIVC animated:YES];
            }
            else if([MERCHANTSTATE isEqualToString:@"5"])
            {
                MerchantCertificationViewController *MCVC = [[MerchantCertificationViewController alloc]init];
                MCVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:MCVC animated:YES];

            }
            
            
            
        }
        else if (indexPath.row == 8)
        {
            MerchantCenterSettingViewController *MCSVC = [[MerchantCenterSettingViewController alloc]init];
            MCSVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:MCSVC animated:YES];
        }
        else if(indexPath.row == 9)
        {
            FeedbackViewController *FVC = [[FeedbackViewController alloc]init];
            FVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:FVC animated:YES];
        }
        else if ([MERCHANTSTATE isEqualToString:@"1"])
        {
            if (indexPath.row == 6)
            {
                MerchantIncomeViewController *MIVC = [[MerchantIncomeViewController alloc]init];
                MIVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:MIVC animated:YES];
                
            }
            else if (indexPath.row == 9)
            {
                FeedbackViewController *FVC = [[FeedbackViewController alloc]init];
                FVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:FVC animated:YES];
            }

        }
        else if([MERCHANTSTATE isEqualToString:@"5"])
        {
            [TotalFunctionView alertContent:ZEString(@"未认证商户", @"Unauthenticated merchant") onViewController:self];
        }
        else if([MERCHANTSTATE isEqualToString:@"3"])
        {
            [TotalFunctionView alertContent:ZEString(@"认证中", @"Authenticating") onViewController:self];
        }
        
    }
    else
    {
        [TotalFunctionView alertContent:ZEString(@"您还未登陆", @"Please log in first") onViewController:self];
    }

}
//Click事件
-(void)btnHeadImageClick
{
    if ([ObjectForUser checkLogin])
    {
        if([MERCHANTSTATE isEqualToString:@"1"] || [MERCHANTSTATE isEqualToString:@"2"] || [MERCHANTSTATE isEqualToString:@"4"])
        {
            MerchantDetailViewController *MDVC = [[MerchantDetailViewController alloc]init];
            MDVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:MDVC animated:YES];
        }
        else if([MERCHANTSTATE isEqualToString:@"4"])
        {
            [TotalFunctionView alertContent:ZEString(@"未认证商户", @"Unauthenticated merchant") onViewController:self];
        }
        else if([MERCHANTSTATE isEqualToString:@"3"])
        {
            [TotalFunctionView alertContent:ZEString(@"认证中", @"Authenticating") onViewController:self];
        }

    }
    else
    {

        LoginWithPhoneViewController *LWPVC = [[LoginWithPhoneViewController alloc]init];
        LWPVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:LWPVC animated:YES];

    }
}

-(void)switchOpenValueChange:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    NSString *strIsOpen;
    if (isButtonOn)
    {
        strIsOpen = @"1";
    }
    else
    {
        strIsOpen = @"2";
    }
    
    if (![ObjectForUser checkLogin])
    {
        switchOpen.on = NO;
        ALERTNOTLOGIN
    }
    else
    {
        if ([MERCHANTSTATE isEqualToString:@"1"] || [MERCHANTSTATE isEqualToString:@"2"])
        {
            __weak MerchantViewController *blockSelf = self;
            progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/user/editstate" parameter:@{@"shopid":USERID,@"token":TOKEN,@"state":strIsOpen} resultBlock:^(NSDictionary *resultDic) {
                [progress hide:YES];
                if(resultDic == nil)
                {
                    [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
                    switchOpen.on = ![switchOpen isOn];
                }
                else if ([resultDic[@"status"] isEqual:@(9)])
                {
                    switchOpen.on = NO;
                    ALERTCLEARLOGINBLOCK
                }
                else if ([resultDic[@"status"] isEqual:@(1)])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:strIsOpen forKey:@"isopen"];
                }
                else
                {
                    [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
                    switchOpen.on = ![switchOpen isOn];
                }
                
                
            }];

        }
        else if ([MERCHANTSTATE isEqualToString:@"3"])
        {
            [TotalFunctionView alertContent:ZEString(@"操作失败，还未通过认证", @"Operation failed, not yet certified") onViewController:self];
        }
        else if ([MERCHANTSTATE isEqualToString:@"4"])
        {
            [TotalFunctionView alertContent:ZEString(@"操作失败，申请退出加盟中", @"Operation failed, exiting state") onViewController:self];
        }
        else if ([MERCHANTSTATE isEqualToString:@"5"])
        {
            [TotalFunctionView alertContent:ZEString(@"操作失败，未进行认证", @"Operation failed, unauthenticated state") onViewController:self];
        }

       
    }
    

}


- (void)didReceiveMemoryWarning {
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
