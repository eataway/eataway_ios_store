//
//  HeadImageNameDescriptionViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "HeadImageNameDescriptionViewController.h"

#import "ChangeValueViewController.h"

#import <UIImageView+WebCache.h>
#import <MBProgressHUD.h>
#import <AVFoundation/AVFoundation.h>

@interface HeadImageNameDescriptionViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ChangeValueViewControllerDelegate>
{
    UITableView *_tableView;
    
    UIImageView *IVHead;
    UITextView *TVContent;
    MBProgressHUD *progress;
    
    BOOL isCameraCanBeUsed;
    UIImagePickerController *imagePicker;
    
}
@property(nonatomic,retain)UIActionSheet *actionSheet;

@end

@implementation HeadImageNameDescriptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTop.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTop];
    
    UIView *viewTopBorder = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, 10)];
    viewTopBorder.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:viewTopBorder];
    
    [self tableViewInit];
}
-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 10, WINDOWWIDTH, WINDOWHEIGHT - 64 - 10 - 45 - 15) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(22, WINDOWHEIGHT - 45 - 15, WINDOWWIDTH - 44, 45);
    btnDone.backgroundColor = [UIColor orangeColor];
    btnDone.clipsToBounds = YES;
    btnDone.layer.cornerRadius = 7;
    [btnDone setTitle:ZEString(@"保存", @"SAVE") forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(btnDoneClick) forControlEvents:UIControlEventTouchUpInside];
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
        return 200;
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
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 60, 10, 30, 30)];
            IVHead.clipsToBounds = YES;
            IVHead.layer.cornerRadius = 15;
            [IVHead sd_setImageWithURL:[NSURL URLWithString:HEADPHOTO] placeholderImage:[UIImage imageNamed:@"5.2.0_pic_head.png"]];
            [cell addSubview:IVHead];
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewDown];
            
        }
        cell.textLabel.text = ZEString(@"商户头像", @"Acatar");
        
    }
    else if (indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewDown];
        }
        cell.textLabel.text = ZEString(@"店铺名称", @"Name");
        cell.detailTextLabel.text = NICKNAME;
    }
    else if (indexPath.row == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            

        }
        cell.textLabel.text = ZEString(@"店铺简介", @"Description");
    }
    else if (indexPath.row == 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
            
            UIView *viewbg = [[UIView alloc]initWithFrame:CGRectMake(12, 0, WINDOWWIDTH - 24, 200)];
            viewbg.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewbg];
            
            TVContent = [[UITextView alloc]initWithFrame:CGRectMake(16, 4, WINDOWWIDTH - 32, 192)];
            TVContent.text = SHOPDESCRIPTION;
            TVContent.font = [UIFont systemFontOfSize:13];
            TVContent.backgroundColor = [UIColor clearColor];
            TVContent.textColor = [UIColor blackColor];
            [cell addSubview:TVContent];
            
            
            
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
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self selectAPicture];
    }
    else if (indexPath.row == 1)
    {
        UITableViewCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        NSString *strName = cell1.detailTextLabel.text;
        
        ChangeValueViewController *CVVC = [[ChangeValueViewController alloc]init];
        CVVC.delegate = self;
        CVVC.strContent = strName;
        CVVC.strTitle = ZEString(@"商户名称", @"Name");
        [self.navigationController pushViewController:CVVC animated:YES];
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
        imagePicker.allowsEditing = YES;

        [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
    else if (isCameraCanBeUsed && buttonIndex == 1)
    {
        imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    

    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    IVHead.image = image;

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)valueChangeToString:(NSString *)toString identifier:(NSInteger)identifier
{
    UITableViewCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell1.detailTextLabel.text = toString;
}
-(void)btnDoneClick
{
    UITableViewCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *strName = cell1.detailTextLabel.text;
    
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else if (strName.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请输入店铺名称", @"Please enter shop name") onViewController:self];
    }
    else
    {
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak HeadImageNameDescriptionViewController *blockSelf = self;
        
        [[ObjectForRequest shareObject] requestUploadImagesWithURL:@"index.php/server/user/addjianjie" arrImages:@[IVHead.image] arrImageNames:@[@"myFile"] parameter:@{@"shopid":USERID,@"token":TOKEN,@"content":TVContent.text,@"shopname":strName} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Save the information failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                [blockSelf.delegate HeadImageNameDescriptionChangeSucceedHeadImage:resultDic[@"msg"] name:strName description:TVContent.text];
                [blockSelf.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Save the information failed, please check the network connection") onViewController:blockSelf];

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
