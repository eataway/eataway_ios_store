//
//  SetShopOpenTimeViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "SetShopOpenTimeViewController.h"

#import "SelectDelveryTimeViewController.h"

@interface SetShopOpenTimeViewController ()<SelectDelveryTimeViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *strFromTime;
    NSString *strToTime;
    NSInteger selectIndex;
    SelectDelveryTimeViewController *SDTVC;
    
    UIButton *btnFromTime;
    UIButton *btnToTime;
    
//    UIView *viewDown;
//    UIView *viewDown2;
    
    UITableView *_tableView;
}
@end

@implementation SetShopOpenTimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = ZEString(@"配送时间", @"Delivery time");
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTop.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTop];
    
    UIView *viewUpBorder = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, 10)];
    viewUpBorder.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:viewUpBorder];
    
//    
//    NSString *strGotime = GOTIME;
//
//    if (strGotime == nil)
//    {
//        strFromTime =  @"select";
//        strToTime = @"select";
//    }
//    else if (![strGotime containsString:@"-"])
//    {
//        strFromTime =  @"select";
//        strToTime =  @"select";
//    }
//    else
//    {
//        NSArray *arr = [strGotime componentsSeparatedByString:@"-"];
//        strFromTime = [arr firstObject];
//        strToTime = [arr lastObject];
//    }
//
//    btnFromTime = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnFromTime setTitle:strFromTime forState:UIControlStateNormal];
//    [btnFromTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    btnFromTime.titleLabel.font = [UIFont systemFontOfSize:13];
//    btnFromTime.frame = CGRectMake(-1, 64 + 10, WINDOWWIDTH + 2, 45);
//    btnFromTime.tag = 1;
//    [btnFromTime addTarget:self action:@selector(btnTimeClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btnFromTime];
//    
//    UILabel *labelFrom = [[UILabel alloc]initWithFrame:CGRectMake(10, 64 + 10, 100, 45)];
//    labelFrom.text = ZEString(@"起始时间:", @"From:");
//    labelFrom.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:labelFrom];
//    
//    
//    viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + 10 + 44, WINDOWWIDTH, 1)];
//    viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
//    [self.view addSubview:viewDown];
//
//    
//    
//    btnToTime = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnToTime setTitle:strToTime forState:UIControlStateNormal];
//    [btnToTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    btnToTime.titleLabel.font = [UIFont systemFontOfSize:13];
//    btnToTime.frame = CGRectMake(-1, 64 + 10 + 45 , WINDOWWIDTH + 2, 45);
//    btnToTime.tag = 2;
//    [btnToTime addTarget:self action:@selector(btnTimeClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btnToTime];
//    
//    UILabel *labelTo = [[UILabel alloc]initWithFrame:CGRectMake(10, 64 + 10 + 45, 100, 45)];
//    labelTo.text = ZEString(@"截止时间:", @"To:");
//    labelTo.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:labelTo];
//    
//    
//    viewDown2 = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + 10 + 45 + 44, WINDOWWIDTH, 1)];
//    viewDown2.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
//    [self.view addSubview:viewDown2];
//    
//
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(22, 64 + 10 + 90 + 40, WINDOWWIDTH - 44, 45);
    btnDone.backgroundColor = [UIColor orangeColor];
    btnDone.clipsToBounds = YES;
    btnDone.layer.cornerRadius = 7;
    [btnDone setTitle:ZEString(@"确定", @"OK") forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(btnDoneClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDone];

    
    [self tableViewInit];
    
}


-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 10, WINDOWWIDTH, 90) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *strGotime = GOTIME;
    
    if (strGotime == nil)
    {
        strFromTime =  @"select";
        strToTime = @"select";
    }
    else if (![strGotime containsString:@"-"])
    {
        strFromTime =  @"select";
        strToTime =  @"select";
    }
    else
    {
        NSArray *arr = [strGotime componentsSeparatedByString:@"-"];
        strFromTime = [arr firstObject];
        strToTime = [arr lastObject];
    }

    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell00"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell00"];
            cell.textLabel.text = ZEString(@"起始时间:", @"From:");
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 44, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewDown];
        }
        cell.detailTextLabel.text = strFromTime;
        
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            cell.textLabel.text = ZEString(@"截止时间:", @"To:");
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0,44, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewDown];
        }
        cell.detailTextLabel.text = strToTime;

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectIndex = indexPath.row;
    SDTVC = [[SelectDelveryTimeViewController alloc]init];
    SDTVC.delegate = self;
    [self.view addSubview:SDTVC.view];

}

//-(void)btnTimeClick:(UIButton *)btn
//{
//    selectIndex = btn.tag;
//    SDTVC = [[SelectDelveryTimeViewController alloc]init];
//    SDTVC.delegate = self;
//    [self.view addSubview:SDTVC.view];
// 
//}
-(void)SelectDelveryTimeViewControllerResultTime:(NSString *)strResult
{
    if (selectIndex == 0)
    {
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.detailTextLabel.text = strResult;
        strFromTime = strResult;
    }
    else
    {
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.detailTextLabel.text = strResult;
        strToTime = strResult;
    }
    
}
-(void)btnDoneClick
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        if (strFromTime.length == 0)
        {
            [TotalFunctionView alertContent:ZEString(@"请选择起始时间", @"Please select starting time") onViewController:self];
        }
        else if (strToTime.length == 0)
        {
            [TotalFunctionView alertContent:ZEString(@"请选择截止时间", @"Please select end time") onViewController:self];
        }
        else
        {
            NSString *strDeliveryTime = [NSString stringWithFormat:@"%@-%@",strFromTime,strToTime];
            [self.delegate SetShopOpenTIime:strDeliveryTime];
            [self.navigationController popViewControllerAnimated:YES];
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
