//
//  OrderManagementViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/11.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "OrderManagementViewController.h"
#import "OrderDetailTableViewCell.h"

#import "LoginWithPhoneViewController.h"

#import <MBProgressHUD.h>

@interface OrderManagementViewController ()<UITableViewDelegate,UITableViewDataSource,OrderDetailTableViewCellDelegate>
{
    MBProgressHUD *progress;
    NSMutableArray *arrOrderToDo;
    NSMutableArray *arrOrderHaveDone;
    UITableView *_tableView;
    
    UILabel *labelNoResult;
    
    UISegmentedControl *segment;
    UIBarButtonItem *itemRefresh;
    BOOL pageDone;
}
@end

@implementation OrderManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    pageDone = NO;
    
    arrOrderToDo = [[NSMutableArray alloc]init];
    arrOrderHaveDone = [[NSMutableArray alloc]init];
    
    
    [self titleViewInit];
    [self tableViewInit];
    
    
    
    
}
-(void)titleViewInit
{

    NSArray *array = [NSArray arrayWithObjects:ZEString(@"未处理", @"In progress"),ZEString(@"已完成", @"Completed"), nil];
    //初始化UISegmentedControl
    segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.frame = CGRectMake(0, 0, 200, 30);
    segment.clipsToBounds = YES;
    segment.layer.cornerRadius = 15;
    [segment setSelectedSegmentIndex:0];
    segment.layer.borderColor = [UIColor whiteColor].CGColor;
    segment.layer.borderWidth = 1;
    [segment addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    


    itemRefresh = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(btnRefreshView)];
    self.navigationItem.rightBarButtonItem = itemRefresh;
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([PUSH isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"push"];
    }
    else
    {
        if ([ObjectForUser checkLogin])
        {
            [self btnRefreshView];
        }
        else
        {
            LoginWithPhoneViewController *LWPVC = [[LoginWithPhoneViewController alloc]init];
            LWPVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:LWPVC animated:YES];
        }
    }

    
}
-(void)refreshViewToDoViewAddDic:(NSDictionary *)dic
{
    if (pageDone)
    {
        
    }
    else
    {
        [arrOrderToDo addObject:dic];
        labelNoResult.hidden = YES;
        [_tableView reloadData];
    }
}
-(void)refreshViewToDoView
{
    [segment setSelectedSegmentIndex:0];
    pageDone = NO;
    [self getOrderToDo];
}

-(void)btnRefreshView
{
        if (pageDone)
        {
            [self getOrderDone];
        }
        else
        {
            [self getOrderToDo];
        }
 
}

-(void)getOrderToDo
{
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak OrderManagementViewController *blockSelf = self;
    itemRefresh.enabled = NO;
    labelNoResult.hidden = YES;
    [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/order/norderlist" parameter:@{@"shopid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
        [progress hide:YES];
        itemRefresh.enabled = YES;
        if (resultDic == nil)
        {
            [TotalFunctionView alertContent:ZEString(@"获取订单信息失败，请检查网络连接", @"Get the order information failed, please check the network connection") onViewController:blockSelf];
        }
        else if ([resultDic[@"status"] isEqual:@(9)])
        {
            ALERTCLEARLOGINBLOCK
        }
        else if ([resultDic[@"status"] isEqual:@(1)])
        {
            [arrOrderToDo removeAllObjects];
            [arrOrderToDo addObjectsFromArray:resultDic[@"msg"]];
            if (arrOrderToDo.count == 0)
            {
                labelNoResult.hidden = NO;
            }
            else
            {
                labelNoResult.hidden = YES;
            }
            [_tableView reloadData];
            
        }
        else
        {
            [TotalFunctionView alertContent:ZEString(@"获取订单信息失败，请检查网络连接", @"Get the order information failed, please check the network connection") onViewController:blockSelf];
        }
    }];
}
-(void)getOrderDone
{
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak OrderManagementViewController *blockSelf = self;
    itemRefresh.enabled = NO;
    labelNoResult.hidden = YES;
    [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/order/yorderlist" parameter:@{@"shopid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
        [progress hide:YES];
        itemRefresh.enabled = YES;
        if (resultDic == nil)
        {
            [TotalFunctionView alertContent:ZEString(@"获取订单信息失败，请检查网络连接", @"Get the order information failed, please check the network connection") onViewController:blockSelf];
        }
        else if ([resultDic[@"status"] isEqual:@(9)])
        {
            ALERTCLEARLOGINBLOCK
        }
        else if ([resultDic[@"status"] isEqual:@(1)])
        {
            [arrOrderToDo removeAllObjects];
            [arrOrderToDo addObjectsFromArray:resultDic[@"msg"]];
            if (arrOrderToDo.count == 0)
            {
                labelNoResult.hidden = NO;
            }
            else
            {
                labelNoResult.hidden = YES;
            }
            [_tableView reloadData];
            
        }
        else
        {
            [TotalFunctionView alertContent:ZEString(@"获取订单信息失败，请检查网络连接", @"Get the order information failed, please check the network connection") onViewController:blockSelf];
        }
    }];
}
-(void)changeLanguage
{
    self.navigationController.tabBarItem.title = ZEString(@"订单管理", @"Orders");
    
    [segment setTitle:ZEString(@"未处理", @"In progress") forSegmentAtIndex:0];
    [segment setTitle:ZEString(@"已完成", @"Completed") forSegmentAtIndex:1];
}

-(void)segmentValueChange:(id)sender
{
    if ([ObjectForUser checkLogin])
    {
        UISegmentedControl * SC = (UISegmentedControl *)sender;
        NSLog(@"value = %ld",SC.selectedSegmentIndex);
        if (SC.selectedSegmentIndex == 0)
        {
            pageDone = NO;
            [self getOrderToDo];
        }
        else
        {
            pageDone = YES;
            [self getOrderDone];
        }
        
    }
    else
    {
        ALERTNOTLOGIN
    }

    
    
    
}
-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64 - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    labelNoResult = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, 40)];
    labelNoResult.text = ZEString(@"无当前订单", @"No order now");
    labelNoResult.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
    labelNoResult.textAlignment = NSTextAlignmentCenter;
    labelNoResult.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:labelNoResult];
    labelNoResult.hidden = YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOrderToDo.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[OrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    cell.orderDone = pageDone;
    NSDictionary *dic = arrOrderToDo[indexPath.row];
    cell.tag = indexPath.row;
    [cell setContentWithDictionary:dic];
    return cell;
}
-(void)orderDetailCellMainButtonClick:(NSString *)strState cellTag:(NSInteger)index
{
    
    if([ObjectForUser checkLogin])
    {
        __weak OrderManagementViewController *blockSelf = self;
        NSDictionary *dic = arrOrderToDo[index];
        NSString *strOrderID = dic[@"orderid"];
        OrderDetailTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        
        if ([strState isEqualToString:@"1"])
        {
            progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/order/queren" parameter:@{@"shopid":USERID,@"token":TOKEN,@"orderid":strOrderID} resultBlock:^(NSDictionary *resultDic) {
                [progress hide:YES];
                if(resultDic == nil)
                {
                    [TotalFunctionView alertContent:ZEString(@"接单失败，请检查网络连接", @"Opreation failed, please check the network connection") onViewController:blockSelf];
                }
                else if ([resultDic[@"status"] isEqual:@(9)])
                {
                    ALERTCLEARLOGINBLOCK
                }
                else if ([resultDic[@"status"] isEqual:@(1)])
                {
                    cell.strOrderState = @"2";
                    [cell changeMainButton];
                    
                    NSMutableDictionary *dicNew = [[NSMutableDictionary alloc]initWithDictionary:dic];
                    [dicNew setObject:@"2" forKey:@"state"];
                    [arrOrderToDo replaceObjectAtIndex:index withObject:dicNew];
                    [self getOrderToDo];
                    
                }
                else if ([resultDic[@"status"] isEqual:@(3)])
                {
                    [arrOrderToDo removeObjectAtIndex:index];
                    [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    [TotalFunctionView alertContent:ZEString(@"订单已过期", @"The order has expired") onViewController:blockSelf];
                }
                else
                {
                    [TotalFunctionView alertContent:ZEString(@"接单失败，请检查网络连接", @"Opreation failed, please check the network connection") onViewController:blockSelf];
                }
                
                
            }];

        }
        else  if ([strState isEqualToString:@"2"])
        {
            progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/order/songda" parameter:@{@"shopid":USERID,@"token":TOKEN,@"orderid":strOrderID} resultBlock:^(NSDictionary *resultDic) {
                [progress hide:YES];
                if(resultDic == nil)
                {
                    [TotalFunctionView alertContent:ZEString(@"确认送达失败，请检查网络连接", @"Opreation failed, please check the network connection") onViewController:blockSelf];
                }
                else if ([resultDic[@"status"] isEqual:@(9)])
                {
                    ALERTCLEARLOGINBLOCK
                }
                else if ([resultDic[@"status"] isEqual:@(1)])
                {
                    [arrOrderToDo removeObjectAtIndex:index];
                    [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    [self getOrderToDo];
                }
                else
                {
                    [TotalFunctionView alertContent:ZEString(@"确认送达失败，请检查网络连接", @"Opreation failed, please check the network connection") onViewController:blockSelf];
                }
                
                
            }];
            
        }

        
        
        
        
    }
    else
    {
        ALERTNOTLOGIN
    }
    
    
}
-(void)orderDetailCellRefundButtonClick:(NSString *)strState cellTag:(NSInteger)index
{
    if([ObjectForUser checkLogin])
    {
        __weak OrderManagementViewController *blockSelf = self;
        NSDictionary *dic = arrOrderToDo[index];
        NSString *strOrderID = dic[@"orderid"];
        NSString *isRefunding = dic[@"statu"];
        
        if ([isRefunding isEqual:@"1"])
        {
            [TotalFunctionView alertContent:ZEString(@"退单申请已提交，请等待审核结果", @"Application has been submitted, please wait for the result") onViewController:self];
        }
        else
        {
            progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/order/backorder" parameter:@{@"shopid":USERID,@"token":TOKEN,@"orderid":strOrderID} resultBlock:^(NSDictionary *resultDic) {
                [progress hide:YES];
                if(resultDic == nil)
                {
                    [TotalFunctionView alertContent:ZEString(@"退单失败，请检查网络连接", @"Opreation failed, please check the network connection") onViewController:blockSelf];
                }
                else if ([resultDic[@"status"] isEqual:@(9)])
                {
                    ALERTCLEARLOGINBLOCK
                }
                else if ([resultDic[@"status"] isEqual:@(1)])
                {
                    [arrOrderToDo removeObjectAtIndex:index];
                    [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                }
                else if ([resultDic[@"status"] isEqual:@(3)])
                {
                    [arrOrderToDo removeObjectAtIndex:index];
                    [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    [TotalFunctionView alertContent:ZEString(@"订单已过期", @"The order has expired") onViewController:blockSelf];
                }

                else
                {
                    [TotalFunctionView alertContent:ZEString(@"退单失败，请检查网络连接", @"Opreation failed, please check the network connection") onViewController:blockSelf];
                }
                
                
            }];

        }
        
    }
    else
    {
        ALERTNOTLOGIN
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
