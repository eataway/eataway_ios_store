//
//  MerchantCertificationViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/15.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantCertificationViewController.h"

#import "TextFieldCeritificationTableViewCell.h"
#import "LabelCeritificationTableViewCell.h"

#import "AddressSetViewController.h"

#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
#import <MBProgressHUD.h>

@interface MerchantCertificationViewController ()<UITableViewDelegate,UITableViewDataSource,AddressSetViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UITableView *_tableView;
    
    UIImagePickerController *imagePicker;
    NSString *strShopLocation;
    
    BOOL headImageSelected;
    BOOL shopPictureSelected;
    
    BOOL isCameraCanBeUsed;
    
    NSInteger selectMode;
    MBProgressHUD *progress;
    
}

@property(nonatomic,retain)UITextField *TFName;
@property(nonatomic,retain)UITextField *TFContact;

@property(nonatomic,retain)UILabel *labelAddress;
@property(nonatomic,retain)UIImageView *IVHead;
@property(nonatomic,retain)UIImageView *IVPicture;

@property(nonatomic,retain)UIActionSheet *actionSheet;

@end

@implementation MerchantCertificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = ZEString(@"认证状态", @"Certification");
    headImageSelected = NO;
    shopPictureSelected = NO;
    strShopLocation = @"";
    
    
    [self tableViewInit];
}
-(void)tableViewInit
{
    UIView *viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTop.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTop];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT ) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 15;
    }
    else if (indexPath.row == 1 || indexPath.row == 2 ||indexPath.row == 3 ||indexPath.row == 4 ||indexPath.row == 5 )
    {
        return 50;
    }
    else if (indexPath.row == 6)
    {
        return 85;
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
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell00"];
            cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        }
        
    }
    else if (indexPath.row == 1 || indexPath.row == 2)
    {
        TextFieldCeritificationTableViewCell *cell0;
        cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell12"];
        if (!cell0)
        {
            cell0 = [[TextFieldCeritificationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell12"];
        }
        NSArray *arrTitle = @[ZEString(@"店铺名称", @"Name"),ZEString(@"联系方式", @"Contact")];
        NSArray *arrPlacehoder = @[ZEString(@"请输入店铺名称", @"Enter the name of business"),ZEString(@"请输入联系方式", @"Enter restaurant contact number")];
        [cell0 setContentWithTitle:arrTitle[indexPath.row - 1] textFieldPlacehoder:arrPlacehoder[indexPath.row - 1]];
        if (indexPath.row == 1)
        {
            if (self.TFName == nil)
            {
                self.TFName = cell0.TFContent;
            }
        }
        else if (indexPath.row == 2)
        {
            if (self.TFContact == nil)
            {
                self.TFContact = cell0.TFContent;
            }
        }
        cell = cell0;
    }
    else if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5)
    {
        LabelCeritificationTableViewCell *cell0;
        cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell345"];
        if (!cell0)
        {
            cell0 = [[LabelCeritificationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell345"];
            cell0.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (indexPath.row == 4)
            {
                self.IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 60, 10, 30, 30)];
                self.IVHead.clipsToBounds = YES;
                self.IVHead.layer.cornerRadius = 15;
                [cell0 addSubview:self.IVHead];
            }
            else if(indexPath.row == 5)
            {
                self.IVPicture = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 70, 10, 40, 30)];
                [cell0 addSubview:self.IVPicture];
            }
            
        }
        NSArray *arrTitle = @[ZEString(@"店铺地址", @"Location"),ZEString(@"上传头像", @"Avatar"),ZEString(@"上传主图", @"Picture")];
        NSArray *arrPlacehoder = @[ZEString(@"请输入店铺地址", @"Location of the shop"),@"",@""];
        [cell0 setContentWithTitle:arrTitle[indexPath.row - 3] textFieldPlacehoder:arrPlacehoder[indexPath.row - 3]];
        if (indexPath.row == 3)
        {
            if (self.labelAddress == nil)
            {
                self.labelAddress = cell0.labelContent;
            }
        }
        
        cell = cell0;
    }
    else if (indexPath.row == 6)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell06"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell06"];
            
            UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
            btnDone.frame = CGRectMake(22, 20, WINDOWWIDTH - 44, 45);
            btnDone.backgroundColor = [UIColor orangeColor];
            btnDone.clipsToBounds = YES;
            btnDone.layer.cornerRadius = 7;
            [btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnDone setTitle:ZEString(@"确定", @"OK") forState:UIControlStateNormal];
            [btnDone addTarget:self action:@selector(btnUploadInfoClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnDone];
        }
        
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3)
    {
        AddressSetViewController *ASVC = [[AddressSetViewController alloc]init];
        ASVC.delegate = self;
        [self.navigationController pushViewController:ASVC animated:YES];
    }
    else if (indexPath.row == 4)
    {
        selectMode = 4;
        [self selectAPicture];
    }
    else if (indexPath.row == 5)
    {
        selectMode = 5;
        [self selectAPicture];
    }
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
        if (selectMode == 4)
        {
            imagePicker.allowsEditing = YES;
        }
        else if (selectMode == 5)
        {
            imagePicker.allowsEditing = NO;
        }
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
    else if (isCameraCanBeUsed && buttonIndex == 1)
    {
        imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        if (selectMode == 4)
        {
            imagePicker.allowsEditing = YES;
        }
        else if (selectMode == 5)
        {
            imagePicker.allowsEditing = NO;
        }
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }

    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    
    if (selectMode == 4)
    {
        UIImage *image = info[@"UIImagePickerControllerEditedImage"];
        self.IVHead.image = image;
        headImageSelected = YES;
    }
    else if (selectMode == 5)
    {
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        self.IVPicture.image = image;
        shopPictureSelected = YES;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)SelectAddress:(NSString *)strSelectAddress addAddress:(NSString *)strAddressAdd location:(NSString *)strLocation
{
    if (strAddressAdd.length == 0)
    {
        self.labelAddress.text = strSelectAddress;
    }
    else
    {
        self.labelAddress.text = [NSString stringWithFormat:@"%@, %@",strAddressAdd,strSelectAddress];
    }
    strShopLocation = strLocation;
}
-(void)btnUploadInfoClick
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else if (self.TFName.text.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请输入商户名称", @"Please enter the name") onViewController:self];
    }
    else if (self.TFContact.text.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请输入联系方式", @"Please enter the contact number") onViewController:self];
    }
    else if (strShopLocation.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请选择商铺地址", @"Please enter the shop location") onViewController:self];
    }
    else if (!headImageSelected)
    {
        [TotalFunctionView alertContent:ZEString(@"请选择商铺头像", @"Please select avatar") onViewController:self];
    }
    else if (!headImageSelected)
    {
        [TotalFunctionView alertContent:ZEString(@"请选择商铺主图", @"Please select shop picture") onViewController:self];
    }
    else
    {
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak MerchantCertificationViewController *blockSelf = self;
        [[ObjectForRequest shareObject] requestUploadImagesWithURL:@"index.php/server/user/addshop" arrImages:@[self.IVHead.image,self.IVPicture.image] arrImageNames:@[@"myFile1",@"myFile2"] parameter:@{@"shopid":USERID,@"token":TOKEN,@"shopname":_TFName.text,@"mobile":_TFContact.text,@"detailed_address":self.labelAddress.text,@"coordinate":strShopLocation} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"上传认证信息失败，请检查网络连接", @"Failing to submit authentication information, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                [TotalFunctionView alertAndDoneWithContent:ZEString(@"提交成功", @"Upload successful") onViewController:blockSelf];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"上传认证信息失败，请检查网络连接", @"Failing to submit authentication information, please check the network connection") onViewController:blockSelf];
            }
        }];
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
