//
//  MerchantIncomeViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantIncomeViewController.h"

#import "MerchantIncomeTableViewCell.h"

#import <MBProgressHUD.h>
#import <MJRefresh.h>

@interface MerchantIncomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *arrList;
    NSNumber *page;
    MBProgressHUD *progress;
    MJRefreshNormalHeader *header;
    MJRefreshAutoNormalFooter *footer;
    UILabel *labelNoResult;
}
@end

@implementation MerchantIncomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    arrList = [[NSMutableArray alloc]init];
    self.title = ZEString(@"收入明细", @"Income");
    page = @(1);
    
    
    
    
    
    [self tableViewInit];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getIncomeList];

}
-(void)getIncomeList
{
    if ([ObjectForUser checkLogin])
    {
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak MerchantIncomeViewController *blockSelf = self;
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/order/mingxi" parameter:@{@"shopid":USERID,@"token":TOKEN,@"page":page} resultBlock:^(NSDictionary *resultDic)
         {
             [progress hide:YES];
             if ([header isRefreshing])
             {
                 [header endRefreshing];
             }
             if ([footer isRefreshing])
             {
                 [footer endRefreshing];
             }
             if(resultDic == nil)
             {
                 [TotalFunctionView alertContent:ZEString(@"获取信息失败，请检查网络连接", @"Get information failed, please check the network connection") onViewController:blockSelf];
             }
             else if ([resultDic[@"status"] isEqual:@(9)])
             {
                 ALERTCLEARLOGINBLOCK
             }
             else if ([resultDic[@"status"] isEqual:@(1)])
             {
                 NSArray *arr = resultDic[@"msg"];
                 if (arr.count > 0)
                 {
                     page = @([page integerValue] + 1);
                     [arrList addObjectsFromArray:arr];
                     
                     [_tableView reloadData];
                 }
                 if (arrList.count == 0)
                 {
                     labelNoResult.hidden = NO;
                 }
                 else
                 {
                     labelNoResult.hidden = YES;
                 }
             }
             else
             {
                 [TotalFunctionView alertContent:ZEString(@"获取信息失败，请检查网络连接", @"Get information failed, please check the network connection") onViewController:blockSelf];
             }
         }];
    }
    else
    {
        ALERTNOTLOGIN
    }

    
}
-(void)tableViewInit
{
    UIView *viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTop.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTop];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 10, WINDOWWIDTH, WINDOWHEIGHT - 64 - 10) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    __weak MerchantIncomeViewController *blockSelf = self;
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [arrList removeAllObjects];
        labelNoResult.hidden = YES;
        [_tableView reloadData];
        page = @(1);
        [blockSelf getIncomeList];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    header.stateLabel.hidden = YES;
    
    footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [blockSelf getIncomeList];
    }];
    _tableView.mj_footer = footer;
    footer.refreshingTitleHidden = YES;
    [footer setTitle:ZEString(@"上拉加载更多", @"Get More information") forState:MJRefreshStateIdle];
    [footer setTitle:ZEString(@"松开进行加载", @"Release the load")  forState:MJRefreshStatePulling];
    [footer setTitle:ZEString(@"加载中", @"Loading") forState:MJRefreshStateRefreshing];
    [footer setTitle:ZEString(@"暂无更多数据", @"No more data") forState:MJRefreshStateNoMoreData];

    labelNoResult = [[UILabel alloc]initWithFrame:CGRectMake(0, 64 + 10, WINDOWWIDTH, 40)];
    labelNoResult.text = ZEString(@"无明细信息", @"No Income information");
    labelNoResult.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
    labelNoResult.textAlignment = NSTextAlignmentCenter;
    labelNoResult.backgroundColor = [UIColor whiteColor];
    labelNoResult.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:labelNoResult];
    labelNoResult.hidden = YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrList.count * 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2 == 0)
    {
        return 35;
    }
    else
    {
        return 35;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row % 2 == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell00"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell00"];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.textColor = MAINCOLOR;
        }
        NSInteger index = indexPath.row/2;
        NSDictionary *dic = arrList[index];
        cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",ZEString(@"订单号", @"Number"),dic[@"orderid"]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"+$%@",dic[@"money"]];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell01"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell01"];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            cell.detailTextLabel.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
            cell.textLabel.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 34, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewDown];
        }
        NSInteger index = (indexPath.row - 1)/2;
        NSDictionary *dic = arrList[index];
        
        cell.textLabel.text = dic[@"addtime"];
        cell.detailTextLabel.text = ZEString(@"已结算", @"Already billed");
        
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
