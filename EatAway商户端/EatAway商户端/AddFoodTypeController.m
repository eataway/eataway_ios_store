//
//  AddFoodTypeController.m
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "AddFoodTypeController.h"
#import "DishesDetailsModel.h"
#import "HYBNetworking.h"
#import <MBProgressHUD.h>
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>
#import "LoginWithPhoneViewController.h"
#import <MBProgressHUD.h>

@interface AddFoodTypeController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) UIButton *closeBtn;
@property (nonatomic, retain) UIImageView *imageVC;
@property (nonatomic, retain) UIButton *imageBtn;
@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) UITextField *priceField;
@property (nonatomic, retain) UITextView *IntroduceTextView;
@property (nonatomic, retain) UIButton *finishBtn;
@property (nonatomic, retain) DishesDetailsModel *detailsModel;
@property(nonatomic,strong) UIActionSheet *actionSheetForPicker;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, assign) NSInteger judgement;
@property (nonatomic, retain) MBProgressHUD *hub;
@end

@implementation AddFoodTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.vcClass == 1) {
        self.title = ZEString(@"添加菜品", @"New dish");
        
    }else{
        self.title = ZEString(@"修改菜品", @"Edit dishes");
        [self editDatas];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    [self createUI];
    self.judgement = 0;
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)createNav{
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(0, 0, 15, 15);
    [self.closeBtn setImage:[UIImage imageNamed:@"3.2.1_icon_close"] forState:UIControlStateNormal];
    self.closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.closeBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)createUI{
    
    self.imageVC = [[UIImageView alloc]initWithFrame:CGRectMake(15, 74, 80, 80)];
    self.imageVC.image = [UIImage imageNamed:@"3.2.1_pic_add"];
    [self.view addSubview:self.imageVC];
    
    self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageBtn.frame = CGRectMake(0, 64, WINDOWWIDTH, 100);
    [self.imageBtn addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.imageBtn];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageBtn.frame), WINDOWWIDTH, 1)];
    lineView1.backgroundColor = EWColor(240, 240, 240, 1);
    [self.view addSubview:lineView1];
    
    UILabel *foodName = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(lineView1.frame) + 10, 65, 30)];
    
    foodName.text = ZEString(@"菜品名称", @"Name");
    foodName.textColor = EWColor(51, 51, 51, 1);
    foodName.font = [UIFont systemFontOfSize:15];
    foodName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:foodName];
    
    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(foodName.frame), CGRectGetMaxY(lineView1.frame) + 10, WINDOWWIDTH - 90, 30)];
    self.nameField.textAlignment = NSTextAlignmentLeft;
    self.nameField.placeholder = ZEString(@"请输入菜品名称", @"Enter the name of the dish");
    self.nameField.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.nameField];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameField.frame) + 10, WINDOWWIDTH, 1)];
    lineView2.backgroundColor = EWColor(240, 240, 240, 1);
    [self.view addSubview:lineView2];
    
    UILabel *foodPrice = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(lineView2.frame) + 10, 65, 30)];
    
    foodPrice.text = ZEString(@"菜品价格", @"Price");
    foodPrice.textColor = EWColor(51, 51, 51, 1);
    foodPrice.font = [UIFont systemFontOfSize:15];
    foodPrice.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:foodPrice];
    
    
    self.priceField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(foodPrice.frame), CGRectGetMaxY(lineView2.frame) + 10, WINDOWWIDTH - 90, 30)];
    self.priceField.textAlignment = NSTextAlignmentLeft;
    self.priceField.placeholder = ZEString(@"请输入菜品价格", @"Enter the price of the dish");
    self.priceField.font = [UIFont systemFontOfSize:15];
    self.priceField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.priceField addTarget:self action:@selector(pressTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.priceField];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.priceField.frame) + 10, WINDOWWIDTH, 1)];
    lineView3.backgroundColor = EWColor(240, 240, 240, 1);
    [self.view addSubview:lineView3];
    
    if (ISCHINESE)
    {
         UILabel *foodIntroduce = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(lineView3.frame) + 10, 65, 30)];
        
        foodIntroduce.text = ZEString(@"菜品介绍", @"Description");
        foodIntroduce.textColor = EWColor(51, 51, 51, 1);
        foodIntroduce.font = [UIFont systemFontOfSize:15];
        foodIntroduce.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:foodIntroduce];
        
        
        UILabel *IntroduceLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(foodIntroduce.frame), CGRectGetMaxY(lineView3.frame) + 10, 50, 30)];
        
        IntroduceLab.textAlignment = NSTextAlignmentLeft;
        IntroduceLab.textColor = EWColor(153, 153, 153, 1);
        IntroduceLab.text = ZEString(@"(选填)", @"(optional fill in)");
        IntroduceLab.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:IntroduceLab];
    }
    else
    {
        
        UILabel *foodIntroduce = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(lineView3.frame) + 10, 80, 30)];
        
        foodIntroduce.text = ZEString(@"菜品介绍", @"Description");
        foodIntroduce.textColor = EWColor(51, 51, 51, 1);
        foodIntroduce.font = [UIFont systemFontOfSize:15];
        foodIntroduce.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:foodIntroduce];
        
        
        UILabel *IntroduceLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(foodIntroduce.frame), CGRectGetMaxY(lineView3.frame) + 10, 150, 30)];
        
        IntroduceLab.textAlignment = NSTextAlignmentLeft;
        IntroduceLab.textColor = EWColor(153, 153, 153, 1);
        IntroduceLab.text = ZEString(@"(选填)", @"(optional fill in)");
        IntroduceLab.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:IntroduceLab];
        
    }
   
    
    self.IntroduceTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(lineView3.frame) + 50, WINDOWWIDTH - 30, 180)];
    self.IntroduceTextView.backgroundColor = EWColor(240, 240, 240, 1);
    self.IntroduceTextView.text = ZEString(@"例: 这是店里的新菜, 欢迎品尝!", @"For example : It's the specialty of our restaurant...");
    self.IntroduceTextView.textColor = EWColor(153, 153, 153, 1);
    self.IntroduceTextView.delegate = self;
    self.IntroduceTextView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.IntroduceTextView];
    
    self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishBtn.frame = CGRectMake(20, WINDOWHEIGHT - 50, WINDOWWIDTH - 40, 40);
    
    self.finishBtn.backgroundColor = [UIColor colorWithRed:0.97f green:0.64f blue:0.16f alpha:1.00f];
    [self.finishBtn setTitle:ZEString(@"完成", @"Done") forState:UIControlStateNormal];
    self.finishBtn.layer.cornerRadius = 5;
    self.finishBtn.clipsToBounds = YES;
    [self.finishBtn addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.finishBtn];
    
}
- (void)pressTextField:(UITextField *)textField{
    
    if (textField.text.length > 8) {
        textField.text = [textField.text substringToIndex:8];
    }
}
#pragma mark - 上传图片的点击事件
- (void)changeImage{
    
    [self selectImgVC];
   
}

- (void)selectImgVC{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.actionSheetForPicker = [[UIActionSheet alloc]initWithTitle:ZEString(@"修改头像", @"Change HeadImage") delegate:self cancelButtonTitle:ZEString(@"取消",@"Cancel") destructiveButtonTitle:nil otherButtonTitles:ZEString(@"拍照",@"Take a photo"),ZEString(@"从相册选择",@"Select for photo library"), nil];
    }
    else
    {
        self.actionSheetForPicker = [[UIActionSheet alloc]initWithTitle:@"修改头像" delegate:self cancelButtonTitle:ZEString(@"取消",@"Cancel") destructiveButtonTitle:nil otherButtonTitles:ZEString(@"从相册选择",@"Select for photo library"),nil];
        
    }
    
    [self.actionSheetForPicker showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [actionSheet removeFromSuperview];
    NSInteger sourceType = 100;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        switch (buttonIndex)
        {
            case 0:
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            default:
                break;
        }
        
    }
    else
    {
        switch (buttonIndex)
        {
            case 0:
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
                
            default:
                break;
        }
    }
    
    
    if (sourceType != 100 )
    {
        UIImagePickerController *IVPicker = [[UIImagePickerController alloc]init];
        IVPicker.delegate = self;
        IVPicker.allowsEditing = YES;
        IVPicker.sourceType = sourceType;
        
        [self presentViewController:IVPicker animated:YES completion:^{
            nil;
        }];
        
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
     self.image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.imageVC.image = self.image;
    
    self.judgement = 1;
}

#pragma mark - 关闭按钮的点击事件
- (void)closeClick{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:ZEString(@"例: 这是店里的新菜, 欢迎品尝!", @"For example : It's the specialty of our restaurant...")]) {
        textView.text = @"";
        textView.textColor = EWColor(102, 102, 102, 1);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        textView.text = ZEString(@"例: 这是店里的新菜, 欢迎品尝!", @"For example : It's the specialty of our restaurant...");
        textView.textColor = EWColor(204, 204, 204, 1);
    }
}

- (void)editDatas{
    
    __weak typeof(self) weakS = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *goodsIdStr = [NSString stringWithFormat:@"%ld",self.goodsId];
    params[@"shopid"] = USERID;
    params[@"token"] = TOKEN;
    params[@"goodsid"] = goodsIdStr;
    
    if (USERID == nil || TOKEN == nil) {
        LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else{
    [HWHttpTool post:Server_Menudetail params:params success:^(id json) {
        if ([json[@"status"] integerValue] == 1) {
            weakS.detailsModel = [[DishesDetailsModel alloc]initWithDictionary:json[@"msg"] error:nil];
            [weakS editFuZhi];
        }else if ([json[@"status"]integerValue] == 9){
            [SVProgressHUD showInfoWithStatus:ZEString(@"登录信息过期，请重新登录", @"Login information is expired, please login again")];
            [ObjectForUser clearLogin];
        }else{
            
            [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败", @"Network connection failed")];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败", @"Network connection failed")];
    }];
     }
}
- (void)editFuZhi{
    
    self.nameField.text = self.detailsModel.goodsname;
    self.priceField.text = self.detailsModel.goodsprice;
    self.IntroduceTextView.text = self.detailsModel.goodscontent;
    [self.imageVC sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.detailsModel.goodsphoto]]placeholderImage:[UIImage imageNamed:@"3.2.2_pic_bg"]];
}

#pragma mark - 完成按钮的点击事件
- (void)finishClick{
    
    NSArray *imageArr = [NSArray arrayWithObjects:self.imageVC.image, nil];
    NSArray *nameArr = @[@"myFile"];
    
    if (self.vcClass == 1) {
        
        if (self.judgement == 0) {
            [SVProgressHUD showInfoWithStatus:ZEString(@"请选择上传图片", @"Please select upload images")];
            return;
        }if ([self.nameField.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:ZEString(@"请输入菜品名称", @"Please enter the name of the dish")];
            return;
        }if ([self.priceField.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:ZEString(@"请输入菜品价格", @"Please enter the price of the dish")];
            return;
        }
        if ([self.IntroduceTextView.text isEqualToString:ZEString(@"例: 这是店里的新菜, 欢迎品尝!", @"For example : It's the specialty of our restaurant...")]) {
            self.IntroduceTextView.text = @"";
        }
        NSString *cidStr = [NSString stringWithFormat:@"%ld",self.cidClass];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        params[@"cid"] = cidStr;
        params[@"shopid"] = USERID;
        params[@"token"] = TOKEN;
        params[@"goodsname"] = self.nameField.text;
        params[@"goodsprice"] = self.priceField.text;
        params[@"goodscontent"] = self.IntroduceTextView.text;

        NSArray *imageArr = [NSArray arrayWithObjects:self.imageVC.image, nil];
//        NSArray *nameAyrr = [[NSArray array]initWithObjects:@"myFile", nil];
        NSArray *nameArr = @[@"myFile"];
        
        if (USERID == nil || TOKEN == nil) {
            LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else{
            self.hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [HWHttpTool postUploadImages:imageArr imageNames:nameArr url:Server_Addgoods params:params success:^(id json) {
            [self.hub hide:YES];
            if ([json[@"status"]integerValue] == 1) {
                [SVProgressHUD showInfoWithStatus:ZEString(@"添加菜品成功", @"Add menu success")];
                [self.navigationController popViewControllerAnimated:YES];
                [self.addDelegate respondsToSelector:@selector(addRefresh)];
                [self.addDelegate addRefresh];
            }else if ([json[@"status"]integerValue] == 9){
                
                [SVProgressHUD showInfoWithStatus:ZEString(@"登录信息过期，请重新登录", @"Login information is expired, please login again")];
                [ObjectForUser clearLogin];
            }else{
                [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败", @"Network connection failed")];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败", @"Network connection failed")];
        }];
    
    }
    }
    else{
        
        NSString *goodsIdStr = [NSString stringWithFormat:@"%ld",self.goodsId];
        NSString *cidStr = [NSString stringWithFormat:@"%ld",self.editCid];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"goodsid"] = goodsIdStr;
        params[@"goodsname"] = self.nameField.text;
        params[@"cid"] = cidStr;
        params[@"goodsprice"] = self.priceField.text;
        params[@"goodscontent"] = self.IntroduceTextView.text;
        params[@"token"] = TOKEN;
        params[@"shopid"] = USERID;
        
        if (USERID == nil || TOKEN == nil) {
            LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else{
            self.hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [HWHttpTool postUploadImages:imageArr imageNames:nameArr url:Server_Editgoods params:params success:^(id json) {
            [self.hub hide:YES];
            
            if ([json[@"status"]integerValue] == 1) {
                [SVProgressHUD showInfoWithStatus:ZEString(@"编辑菜品成功", @"Edit menu success")];
                [self.addDelegate respondsToSelector:@selector(addRefresh)];
                [self.addDelegate addRefresh];
                [self.navigationController popViewControllerAnimated:YES];
                }else if ([json[@"status"]integerValue] == 9){
                    [SVProgressHUD showInfoWithStatus:ZEString(@"登录信息过期，请重新登录", @"Login information is expired, please login again")];
                    [ObjectForUser clearLogin];
                }else{
                                
                    [SVProgressHUD showInfoWithStatus:ZEString(@"编辑菜品失败", @"Failed to edit")];
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败,请检查网络", @"Network connection failed, please check the network")];
        }];
    }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
