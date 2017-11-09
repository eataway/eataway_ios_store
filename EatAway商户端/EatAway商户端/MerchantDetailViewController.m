//
//  MerchantDetailViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/17.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantDetailViewController.h"

#import "MerchantInfoFirstTableViewCell.h"
#import "MerchantInfoTableViewCell.h"

#import "HeadImageNameDescriptionViewController.h"
#import "AddressSetViewController.h"

#import "SetDelivertDistanceViewController.h"
#import "ChangeNumberViewController.h"
#import "SetShopOpenTimeViewController.h"
#import "DeliveryFeeDetailViewController.h"
#import "SetMinPassPriceViewController.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
#import <MBProgressHUD.h>

@interface MerchantDetailViewController ()<UITableViewDelegate,UITableViewDataSource,HeadImageNameDescriptionViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AddressSetViewControllerDelegate,changeNumberDelegate,SetDelivertDistanceViewControllerDelegate,SetShopOpenTimeViewControllerDelegate,SetMinPassPriceViewControllerDelegate>
{
    UITableView *_tableView;
    
    UIImageView *IVShop;
    
    BOOL isCameraCanBeUsed;
    UIImagePickerController *imagePicker;
    
    SetDelivertDistanceViewController *SDDVC;
    
    SetMinPassPriceViewController *SMPP;
    
    
    MBProgressHUD *progress;
    
    BOOL needRefresh;
}
@property(nonatomic,retain)UIActionSheet *actionSheet;
@end

@implementation MerchantDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    needRefresh = NO;
    
    
    [self tableViewInit];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (needRefresh)
    {
        [_tableView reloadData];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, - 20 , WINDOWWIDTH, WINDOWHEIGHT + 20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return WINDOWWIDTH * 360/750;
    }
    else if (indexPath.row == 1 || indexPath.row == 3)
    {
        return 10;
    }
    else if (indexPath.row == 2)
    {
        UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    else
    {
        return 50;
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
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell00"];
            IVShop = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWWIDTH * 360/750)];
            IVShop.contentMode = UIViewContentModeScaleAspectFill;
            IVShop.clipsToBounds = YES;
            [IVShop sd_setImageWithURL:[NSURL URLWithString:SHOPPICTURE] placeholderImage:[UIImage imageNamed:@"placehoder2.png"]];
            [cell addSubview:IVShop];
            
            UIView *viewChangePicBG = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 200, WINDOWWIDTH * 360/750 - 20, 200, 20)];
            viewChangePicBG.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            [cell addSubview:viewChangePicBG];
            
            UILabel *labelChangePic = [[UILabel alloc]init];
            labelChangePic.text = ZEString(@"修改商户图片", @"Change picture");
            labelChangePic.font = [UIFont systemFontOfSize:13];
            CGSize labelSize = [self sizeOfString:labelChangePic.text fontSize:13];
            labelChangePic.frame = CGRectMake(WINDOWWIDTH - labelSize.width - 15, WINDOWWIDTH * 360/750 - 20, labelSize.width , 20);
            labelChangePic.textColor = [UIColor whiteColor];
            [cell addSubview:labelChangePic];
            
            viewChangePicBG.frame = CGRectMake(WINDOWWIDTH - labelSize.width - 15 - 20, WINDOWWIDTH * 360/750 - 20, 200, 20);
            
            UIImageView *IVWrite = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - labelSize.width - 15 - 18, WINDOWWIDTH * 360/750 - 18, 16, 16)];
            IVWrite.image = [UIImage imageNamed:@"5.1.0_icon_03.png"];
            [cell addSubview:IVWrite];
            
            UIButton *btnChangePic = [UIButton buttonWithType:UIButtonTypeCustom];
            btnChangePic.frame = CGRectMake(WINDOWWIDTH - labelSize.width - 15 - 20, WINDOWWIDTH * 360/750 - 20, 200, 20);
            [btnChangePic addTarget:self action:@selector(btnChangePicClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnChangePic];
            
            UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
            btnBack.frame = CGRectMake(12, 20 + 12 , 12, 20);
            [btnBack setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
            [btnBack addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnBack];
            
            
        }
        
    }
    else if (indexPath.row == 1 || indexPath.row == 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellblank"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellblank"];
            cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        }

    }
    else if (indexPath.row == 2)
    {
        MerchantInfoFirstTableViewCell *cell0;
        cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell0)
        {
            cell0 = [[MerchantInfoFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell0.selectionStyle = UITableViewCellSelectionStyleNone;
            cell0.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        [cell0 setContentWithHeadImage:HEADPHOTO title:NICKNAME text:SHOPDESCRIPTION];
        cell = cell0;
    }
    else
    {
        MerchantInfoTableViewCell *cell0;
        cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell45678"];
        if (!cell0)
        {
            cell0 = [[MerchantInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell45678"];
            cell0.selectionStyle = UITableViewCellSelectionStyleNone;
            cell0.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell0.detailTextLabel.font = [UIFont systemFontOfSize:13];
        }
        NSArray *arrImageName = @[@"5.2.0_icon_01.png",@"5.2.0_icon_02.png",@"5.2.0_icon_03.png",@"5.2.0_icon_04.png",@"5.2.0_icon_05.png",@"5.2.0_icon_04.png"];
        NSString *strMaxDis;
        if (MAXDISTANCE == nil || [MAXDISTANCE isEqualToString:@""] || [MAXDISTANCE isEqualToString:@" "])
        {
            strMaxDis = @"";
        }
        else
        {
            strMaxDis = [NSString stringWithFormat:@"%@ km",MAXDISTANCE];
        }
        
        NSString *strGoTime;
        if (GOTIME == nil || ![GOTIME containsString:@"-"])
        {
            strGoTime = ZEString(@"请选择送餐时间", @"Please set delivery time");
        }
        else
        {
            strGoTime = GOTIME;
        }
        
        NSString *minPassPrice;
        
        if (MINPASSPRICE == nil || [MINPASSPRICE isEqualToString:@""]) {
            minPassPrice = @"";
        }else{
            minPassPrice = [NSString stringWithFormat:@"%@ $",MINPASSPRICE];
        }
        
        
        
        NSArray *arrTitle = @[SHOPADDRESS,SHOPPHONE,strGoTime,ZEString(@"配送距离", @"Delivery distance"),ZEString(@"配送费", @"Delivery fee"),ZEString(@"最低配送金额", @"Min delivery fee")];
        [cell0 setContentWithHeadImage:[UIImage imageNamed:arrImageName[indexPath.row - 4]] text:arrTitle[indexPath.row - 4]];
        if (indexPath.row == 7)
        {
            cell0.detailTextLabel.text = strMaxDis;
        }
        
        if (indexPath.row == 9)
        {
            cell0.detailTextLabel.text = minPassPrice;
        }

        cell = cell0;

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        HeadImageNameDescriptionViewController *HINDVC = [[HeadImageNameDescriptionViewController alloc]init];
        HINDVC.delegate = self;
        [self.navigationController pushViewController:HINDVC animated:YES];
    }
    else if (indexPath.row == 4)
    {
        AddressSetViewController *ASVC = [[AddressSetViewController alloc]init];
        ASVC.delegate = self;
        [self.navigationController pushViewController:ASVC animated:YES];
    }
    else if (indexPath.row == 5)
    {
//        ChangeNumberViewController *CNVC = [[ChangeNumberViewController alloc]init];
//        CNVC.strTitle = ZEString(@"商铺电话", @"Phone");
//        CNVC.strContent = SHOPPHONE;
//        CNVC.delegate = self;
//        [self.navigationController pushViewController:CNVC animated:YES];
        
        ChangeNumberViewController *CNNC = [[ChangeNumberViewController alloc]init];
        CNNC.changeNumberDelegate = self;
        [self.navigationController pushViewController:CNNC animated:YES];
        
    }
    else if (indexPath.row == 6)
    {
        SetShopOpenTimeViewController *SSOTVC = [[SetShopOpenTimeViewController alloc]init];
        SSOTVC.delegate = self;
        [self.navigationController pushViewController:SSOTVC animated:YES];
    }
    else if (indexPath.row == 7)
    {
        SDDVC = [[SetDelivertDistanceViewController alloc]init];
        SDDVC.delegate = self;
        [self.view addSubview:SDDVC.view];
    }
    else if (indexPath.row == 8)
    {
        DeliveryFeeDetailViewController *DFDVC = [[DeliveryFeeDetailViewController alloc]init];
        [self.navigationController pushViewController:DFDVC animated:YES];
    }
    else if (indexPath.row == 9)
    {
        SMPP = [[SetMinPassPriceViewController alloc]init];
        SMPP.delegate = self;
        [self.view addSubview:SMPP.view];
    }

    

}
-(void)HeadImageNameDescriptionChangeSucceedHeadImage:(NSString *)headImage name:(NSString *)strName description:(NSString *)strDescription
{
    [[NSUserDefaults standardUserDefaults] setObject:strName forKey:@"nickname"];
    [[NSUserDefaults standardUserDefaults] setObject:headImage forKey:@"headphoto"];
    [[NSUserDefaults standardUserDefaults] setObject:strDescription forKey:@"shopdescription"];
    needRefresh  = YES ;
}
-(void)SelectAddress:(NSString *)strSelectAddress addAddress:(NSString *)strAddressAdd location:(NSString *)strLocation
{
    NSString *strAddressTotal;
    if (strAddressAdd.length == 0)
    {
        strAddressTotal = strSelectAddress;
    }
    else
    {
        strAddressTotal = [NSString stringWithFormat:@"%@, %@",strAddressAdd,strSelectAddress];
    }
    MerchantInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    __weak MerchantDetailViewController *blockSelf = self;
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/shop/editaddress" parameter:@{@"shopid":USERID,@"token":TOKEN,@"detailed_address":strAddressTotal,@"coordinate":strLocation} resultBlock:^(NSDictionary *resultDic)
    {
        [progress hide:YES];
        if (resultDic == nil)
        {
            [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Change address failed, please check the network connection") onViewController:blockSelf];
        }
        else if ([resultDic[@"status"] isEqual:@(9)])
        {
            ALERTCLEARLOGINBLOCK
        }
        else if ([resultDic[@"status"] isEqual:@(1)])
        {
            [[NSUserDefaults standardUserDefaults] setObject:strAddressTotal forKey:@"shopaddress"];
            [[NSUserDefaults standardUserDefaults] setObject:strLocation forKey:@"shoplocation"];
            cell.labelText.text = strAddressAdd;
        }
        else
        {
            [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Change address failed, please check the network connection") onViewController:blockSelf];
        }
        
    }];
}
- (void)changeNumber:(NSString *)numberStr
{
    MerchantInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    cell.labelText.text = numberStr;

}
-(void)SetShopOpenTIime:(NSString *)strOpenTime
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        MerchantInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
        
        __weak MerchantDetailViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/user/edittime" parameter:@{@"shopid":USERID,@"token":TOKEN,@"gotime":strOpenTime} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if(resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Change Delivery time failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                [[NSUserDefaults standardUserDefaults] setObject:strOpenTime forKey:@"gotime"];
                cell.labelText.text = strOpenTime;
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Change Delivery time failed, please check the network connection") onViewController:blockSelf];
            }
            
            
        }];
    }
    
   
}
-(void)SetDeliveryDistance:(NSString *)strDistance
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        MerchantInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];

        __weak MerchantDetailViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/user/editlong" parameter:@{@"shopid":USERID,@"token":TOKEN,@"long":strDistance} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Change delivery distance failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ km",strDistance];
                [[NSUserDefaults standardUserDefaults] setObject:strDistance forKey:@"maxdistance"];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Change delivery distance failed, please check the network connection") onViewController:blockSelf];
            }
        }];

    }
}

//最低配送金额

-(void)SetMinPassPrice:(NSString *)strResult{
    
    
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        MerchantInfoTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0]];
        
        __weak MerchantDetailViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/shop/editlmoney" parameter:@{@"shopid":USERID,@"token":TOKEN,@"lmoney":strResult} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Change delivery distance failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ $",strResult];
                
                //MINPASSPRICE
                [[NSUserDefaults standardUserDefaults] setObject:strResult forKey:@"minpassprices"];
                
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Change delivery distance failed, please check the network connection") onViewController:blockSelf];
            }
        }];
        
    }

    
    
    
    
    
}





-(void)btnChangePicClick
{
    [self selectAPicture];
}
-(void)selectAPicture
{
    /// 先判断摄像头硬件是否好用
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        /// 用户是否允许摄像头使用
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        /// 不允许弹出提示框
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied)
        {
            isCameraCanBeUsed = NO;
        }
        else
        {
            ////这里是摄像头可以使用的处理逻辑
            isCameraCanBeUsed = YES;
            
        }
    }
    else
    {
        isCameraCanBeUsed = NO;
        
    }
    
    if (isCameraCanBeUsed)
    {
        self.actionSheet = [[UIActionSheet alloc]initWithTitle:ZEString(@"选择图片",@"Select picture") delegate:self cancelButtonTitle:ZEString(@"取消",@"Cancel") destructiveButtonTitle:nil otherButtonTitles:ZEString(@"图库",@"select a picture"),ZEString(@"拍照",@"Take a photo"), nil];
        [self.actionSheet showInView:self.view];
    }
    else
    {
        self.actionSheet = [[UIActionSheet alloc]initWithTitle:ZEString(@"选择图片",@"Select picture") delegate:self cancelButtonTitle:ZEString(@"取消",@"Cancel") destructiveButtonTitle:nil otherButtonTitles:ZEString(@"图库",@"select a picture"), nil];
        [self.actionSheet showInView:self.view];
    }
    
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
    else if (isCameraCanBeUsed && buttonIndex == 1)
    {
        imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    __weak MerchantDetailViewController *blockSelf = self;
    progress = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    [[ObjectForRequest shareObject]requestUploadImagesWithURL:@"index.php/server/user/editzhutu" arrImages:@[image] arrImageNames:@[@"myFile"] parameter:@{@"shopid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic)
    {
        [progress hide:YES];
        if (resultDic == nil)
        {
            [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Change picture failed, please check the network connection") onViewController:blockSelf];
        }
        else if([resultDic[@"status"] isEqual:@(9)])
        {
            ALERTCLEARLOGINBLOCK
        }
        else if ([resultDic[@"status"] isEqual:@(1)])
        {
            IVShop.image = image;
            [[NSUserDefaults standardUserDefaults] setObject:resultDic[@"msg"] forKey:@"shoppicture"];
        }
        else
        {
            [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Change picture failed, please check the network connection") onViewController:blockSelf];

        }
    }];
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGSize)sizeOfString:(NSString *)string fontSize:(NSInteger)fontSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(999,20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelSize;
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
