//
//  AddressSetViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/17.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "AddressSetViewController.h"
#import "AddressPickLocationViewController.h"

#import <CoreLocation/CoreLocation.h>


@interface AddressSetViewController ()<UITableViewDelegate,UITableViewDataSource,AddressPickLocationViewControllerDelegate,CLLocationManagerDelegate>
{
    UITableView *_tableView;
    UILabel *labelAddress;
    UITextView *TVAdd;
    
    NSString *strShopLocation;
}
@property(nonatomic,retain)CLLocationManager *locationManager;

@end

@implementation AddressSetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    strShopLocation = @"";
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self tableViewInit];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.locationManager requestWhenInUseAuthorization];
    
}
-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(22, WINDOWHEIGHT - 65, WINDOWWIDTH - 44, 45);
    btnDone.backgroundColor = [UIColor orangeColor];
    btnDone.clipsToBounds = YES;
    btnDone.layer.cornerRadius = 7;
    [btnDone setTitle:ZEString(@"确定", @"OK") forState:UIControlStateNormal];
    [btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(btnDoneClck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDone];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3)
    {
        return 125;
    }
    else
    {
        return 45;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0 || indexPath.row == 2 )
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell02"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell02"];
        }
        NSArray *arrTitle = @[ZEString(@"请选择您的地址", @"Chose your address"),ZEString(@"请输入您的详细地址(可选)", @"enter your exact location(optional)")];
        cell.textLabel.text = arrTitle[indexPath.row/2];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    else if (indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            
            UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(16, 0, WINDOWWIDTH - 32, 45)];
            viewBG.backgroundColor = [UIColor colorWithWhite:242/255.0 alpha:1];
            viewBG.clipsToBounds = YES;
            viewBG.layer.cornerRadius = 7;
            [cell addSubview:viewBG];
            
            labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, WINDOWWIDTH - 44, 45)];
            labelAddress.font = [UIFont systemFontOfSize:13];
            labelAddress.textColor = [UIColor blackColor];
            [cell addSubview:labelAddress];
            
        }
        
    }
    else if (indexPath.row == 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
            
            UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(16, 0, WINDOWWIDTH - 32, 125)];
            viewBG.backgroundColor = [UIColor colorWithWhite:242/255.0 alpha:1];
            viewBG.clipsToBounds = YES;
            viewBG.layer.cornerRadius = 7;
            [cell addSubview:viewBG];
            
            TVAdd = [[UITextView alloc]initWithFrame:CGRectMake(22, 5, WINDOWWIDTH - 44, 115)];
            TVAdd.backgroundColor = [UIColor clearColor];
            TVAdd.font = [UIFont systemFontOfSize:13];
            [cell addSubview:TVAdd];
            
            
        }
        
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
    if (indexPath.row == 1)
    {
        
        if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized))
        {
            
            
            AddressPickLocationViewController *APLVC = [[AddressPickLocationViewController alloc]init];
            APLVC.delegate = self;
            [self.navigationController pushViewController:APLVC animated:YES];
            
        }
        else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
        {
            
            //定位不能用
            [TotalFunctionView alertContent:ZEString(@"请开启应用的定位功能", @"Do not have location permissions") onViewController:self];
            
        }
        

    }
}
-(void)AddressPickLocationViewControllerSelectResult:(NSString *)strResult location:(NSString *)strLocation
{
    
    labelAddress.text = strResult;
    strShopLocation = strLocation;
    
}
-(void)btnDoneClck
{
    if (strShopLocation.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请选择您的地址", @"Chose your address") onViewController:self];
    }
    else
    {
        [self.delegate SelectAddress:labelAddress.text addAddress:TVAdd.text location:strShopLocation];
        [self.navigationController popViewControllerAnimated:YES];
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
