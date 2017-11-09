//
//  ReviewsViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/11.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "ReviewsViewController.h"

#import "MerchantCommentTableViewCell.h"
#import "MerchantReplyViewController.h"

#import "LoginWithPhoneViewController.h"


#import <MJRefresh.h>
#import <MBProgressHUD.h>

@interface ReviewsViewController ()<UITableViewDelegate,UITableViewDataSource,MerchantCommentTableViewCellDelegate,MerchantReplyViewControllerDelegate>
{
    UITableView *_tableView;
    
    MJRefreshAutoStateFooter *footer;
    MJRefreshStateHeader *header;
    
    UILabel *labelNoResult;
    
    NSMutableArray *arrComments;
    NSNumber *page;
    BOOL isFirstTime;
    
    MBProgressHUD *progress;
}
@end

@implementation ReviewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = ZEString(@"评论", @"Reviews");
    arrComments = [[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    page = @(1);
    isFirstTime = YES;

    [self tableViewInit];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([ObjectForUser checkLogin])
    {
        if (isFirstTime)
        {
            [self reloadCommentTV];
            isFirstTime = NO;
        }
    }
    else
    {
        LoginWithPhoneViewController *LWPVC = [[LoginWithPhoneViewController alloc]init];
        LWPVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:LWPVC animated:YES];
    }
    
    
}
-(void)changeLanguage
{
    self.navigationController.tabBarItem.title = ZEString(@"评论", @"Reviews");
    self.title = ZEString(@"评论", @"Reviews");
    
    [footer setTitle:ZEString(@"上拉加载更多", @"Get More information") forState:MJRefreshStateIdle];
    [footer setTitle:ZEString(@"松开进行加载", @"Release the load")  forState:MJRefreshStatePulling];
    [footer setTitle:ZEString(@"加载中", @"Loading") forState:MJRefreshStateRefreshing];
    [footer setTitle:ZEString(@"暂无更多数据", @"No more data") forState:MJRefreshStateNoMoreData];
    
    for (int a = 0; a < arrComments.count; a ++)
    {
        MerchantCommentTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:a inSection:0]];
        [cell changeBtnLanguage];
    }
    
    
}

-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64 - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    
    __weak ReviewsViewController *blockSelf = self;
    footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [blockSelf reloadCommentTV];
    }];
    footer.refreshingTitleHidden = YES;
    [footer setTitle:ZEString(@"上拉加载更多", @"Get More information") forState:MJRefreshStateIdle];
    [footer setTitle:ZEString(@"松开进行加载", @"Release the load")  forState:MJRefreshStatePulling];
    [footer setTitle:ZEString(@"加载中", @"Loading") forState:MJRefreshStateRefreshing];
    [footer setTitle:ZEString(@"暂无更多数据", @"No more data") forState:MJRefreshStateNoMoreData];
    
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [arrComments removeAllObjects];
        labelNoResult.hidden = YES;
        [_tableView reloadData];
        page = @(1);
        [blockSelf reloadCommentTV];
        
        
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    header.stateLabel.hidden = YES;
    _tableView.mj_header = header;
    _tableView.mj_footer = footer;
    
    labelNoResult = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, 40)];
    labelNoResult.text = ZEString(@"当前无评论", @"No review now");
    labelNoResult.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
    labelNoResult.textAlignment = NSTextAlignmentCenter;
    labelNoResult.backgroundColor = [UIColor whiteColor];
    labelNoResult.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:labelNoResult];
    labelNoResult.hidden = YES;

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrComments.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantCommentTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"celltag3"];
    if (!cell0)
    {
        cell0 = [[MerchantCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celltag3"];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        cell0.delegate = self;
    }
    cell0.tag = indexPath.row;
    NSDictionary *dic = arrComments[indexPath.row];
    
    NSString *strName = @"";
    NSString *strImageURL = @"";
    if([dic[@"state"] isEqual:@"1"])
    {
        strName = ZEString(@"匿名", @"Anonymous");
        strImageURL = @"";
    }
    else
    {
        strName = dic[@"username"];
        strImageURL = dic[@"head_photo"];
    }
    
    
    
    
    NSArray *arrTime = [dic[@"addtime"] componentsSeparatedByString:@" "];
    NSMutableArray *arrImages = [[NSMutableArray alloc]init];
    if (dic[@"photo1"] != nil && ![dic[@"photo1"] isEqualToString: @""])
    {
        [arrImages addObject:dic[@"photo1"]];
    }
    if (dic[@"photo2"] != nil && ![dic[@"photo2"] isEqualToString: @""])
    {
        [arrImages addObject:dic[@"photo2"]];
    }
    NSString *strPingjiaBack ;
    strPingjiaBack = dic[@"backpingjia"];
    if (strPingjiaBack == nil)
    {
        strPingjiaBack = @"";
    }
    [cell0 setContentWithTitle:strName headImage:strImageURL time:[arrTime firstObject] level:dic[@"pingjia"] content:dic[@"content"] images:arrImages reply:strPingjiaBack];
    [cell0 setFrame:CGRectMake(0, 0, WINDOWWIDTH, cell0.cellHeight)];
    
    return cell0;
}
-(void)reloadCommentTV
{
    __weak ReviewsViewController *blockSelf = self;
    if([ObjectForUser checkLogin])
    {
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/evaluate/pingjialist" parameter:@{@"page":page,@"shopid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
            if (footer.isRefreshing)
            {
                [footer endRefreshing];
            }
            if (header.isRefreshing)
            {
                [header endRefreshing];
            }
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"获取评论失败，请检查网络连接", @"Get comment list failed, please check the network connection") onViewController:blockSelf];
            }
            else if([resultDic[@"status"] isEqual:@(1)])
            {
                NSArray *arr = resultDic[@"msg"];
                if (arr.count > 0)
                {
                    page = @([page integerValue] + 1);
                    
                    [arrComments addObjectsFromArray:arr];
                }
                if (arrComments.count == 0)
                {
                    labelNoResult.hidden = NO;
                }
                else
                {
                    labelNoResult.hidden = YES;
                }
                [_tableView reloadData];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"获取评论失败，请检查网络连接", @"Get comment list failed, please check the network connection") onViewController:blockSelf];
            }
        }];
    }
    else
    {
        ALERTNOTLOGIN
    }
   
}

-(void)MerchantReplyIndex:(NSInteger)cellIndex
{
    if ([ObjectForUser checkLogin])
    {
        
        MerchantReplyViewController *MRVC = [[MerchantReplyViewController alloc]init];
        MRVC.delegate = self;
        MRVC.cellIndex = cellIndex;
        MRVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:MRVC animated:YES];
        
    }
    else
    {
        ALERTNOTLOGIN
    }
    
}
-(void)MerchantReplayContent:(NSString *)strContent index:(NSInteger)cellIndex
{
    NSDictionary *dic = arrComments[cellIndex];
    
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak ReviewsViewController *blockSelf = self;
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/evaluate/backpingjia" parameter:@{@"eid":dic[@"eid"],@"shopid":USERID,@"token":TOKEN,@"userid":dic[@"uid"],@"backpingjia":strContent} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"回复失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                NSMutableDictionary *dicNew = [[NSMutableDictionary alloc]initWithDictionary:dic];
                [dicNew setObject:strContent forKey:@"backpingjia"];
                
                [arrComments replaceObjectAtIndex:cellIndex withObject:dicNew];
                
                [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cellIndex inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"回复失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
            }
        }];

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
