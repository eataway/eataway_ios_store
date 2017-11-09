//
//  MerchantCenterSettingViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantCenterSettingViewController.h"

#import "AboutUsViewController.h"

#import <MBProgressHUD.h>

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


@interface MerchantCenterSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    MBProgressHUD *progress;
}
@end

@implementation MerchantCenterSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = ZEString(@"设置", @"Setting");
    
    UIView *viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTop.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTop];
    
    [self tableViewInit];
    
}
-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 10, WINDOWWIDTH, 145) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 45;
    }
    else
    {
        return 100;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:13];
        }
        
        cell.textLabel.text = ZEString(@"关于我们", @"About us");
        
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            
            UIButton *btnQuit = [UIButton buttonWithType:UIButtonTypeCustom];
            btnQuit.frame = CGRectMake(22, 50, WINDOWWIDTH - 44, 45);
            btnQuit.backgroundColor = [UIColor whiteColor];
            btnQuit.layer.cornerRadius = 7;
            btnQuit.clipsToBounds = YES;
            [btnQuit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btnQuit.titleLabel.font = [UIFont systemFontOfSize:13];
            [btnQuit setTitle:ZEString(@"退出登录", @"Exit") forState:UIControlStateNormal];
            [btnQuit addTarget:self action:@selector(btnQuitClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnQuit];
            
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        AboutUsViewController *AUVC = [[AboutUsViewController alloc]init];
        [self.navigationController pushViewController:AUVC animated:YES];
    }
}
-(void)btnQuitClick
{
    
    
    
    
    
    __weak MerchantCenterSettingViewController *blockSelf = self;
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/user/logout" parameter:@{@"shopid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
        
        
        NSLog(@"%@",resultDic);
        
        if(resultDic == nil)
        {
            [TotalFunctionView alertContent:ZEString(@"操作失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
        }
        else if ([resultDic[@"status"] isEqual:@(9)])
        {
            ALERTCLEARLOGINBLOCK
        }
        else if ([resultDic[@"status"] isEqual:@(1)])
        {
            
            [TotalFunctionView alertAndDoneWithContent:ZEString(@"停止营业", @"Close the business") onViewController:blockSelf];
            
            progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                [progress hide:YES];
                [ObjectForUser clearLogin];
                [self.navigationController popViewControllerAnimated:YES];
            } seq:1];

        }
        else
        {
            [TotalFunctionView alertContent:ZEString(@"操作失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
        }

        
        
        
    }];
    
    
    
    
    
//    [ObjectForUser clearLogin];
//    [self.navigationController popViewControllerAnimated:YES];


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
