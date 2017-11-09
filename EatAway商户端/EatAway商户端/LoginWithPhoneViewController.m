//
//  LoginWithPhoneViewController.m
//  EatAway
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "LoginWithPhoneViewController.h"

#import "PhoneLoginTextFieldView.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"

#import "SelectLanguageViewController.h"

#import <MBProgressHUD.h>
#import<CommonCrypto/CommonDigest.h>

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


@interface LoginWithPhoneViewController ()<UITextFieldDelegate,RegisterViewControllerDelegate,SelectLanguageViewControllerDelegate>
{
    
    
    PhoneLoginTextFieldView *viewUsername;
    PhoneLoginTextFieldView *viewPassword;
    UIButton *btnZhong;
    UIButton *btnEnglish;
    UIButton *btnForget;
    UIButton *btnRegister;
    UIButton *btnLogin;
    
    
    MBProgressHUD *progress;
}
@end

@implementation LoginWithPhoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (ISCHINESE)
    {
        self.title = @"登录";
    }
    else
    {
        self.title = @"Log in";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    

    UIView *viewtop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewtop.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewtop];
    
    
    
    [self viewInit];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstopen"] == nil)
    {
        SelectLanguageViewController *SLVC = [[SelectLanguageViewController alloc]init];
        SLVC.delegate = self;
        [self.navigationController pushViewController:SLVC animated:YES];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"firstopen"];

    }
    
}
-(void)SelectLanguageSucceedWithTag:(NSInteger)indexTag
{
    if (ISCHINESE && indexTag == 2)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"language"];
        [btnZhong setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
        [btnEnglish setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        
    }
    else if(!ISCHINESE && indexTag == 1)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"language"];
        [btnZhong setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [btnEnglish setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage" object:nil];

}
-(void)changeLanguage
{
    
    if (ISCHINESE)
    {
        self.title = @"登录";
        viewUsername.textField.placeholder = @"请输入手机号";
        viewPassword.textField.placeholder = @"请输入密码";
        [btnForget setTitle:@"忘记密码" forState:UIControlStateNormal];
        [btnRegister setTitle:@"点击注册" forState:UIControlStateNormal];
        [btnLogin setTitle:@"登 录" forState:UIControlStateNormal];
        
    }
    else
    {
        self.title = @"Log in";
        viewUsername.textField.placeholder = @"Phone Number";
        viewPassword.textField.placeholder = @"Password";
        [btnForget setTitle:@"Forget Password" forState:UIControlStateNormal];
        [btnRegister setTitle:@"Sign up" forState:UIControlStateNormal];
        [btnLogin setTitle:@"Log in" forState:UIControlStateNormal];
    }
}
-(void)viewInit
{
    
    UIImageView *IVLogo = [[UIImageView alloc]initWithFrame:CGRectMake((WINDOWWIDTH-90)/2, 100, 90, 90)];
    IVLogo.image = [UIImage imageNamed:@"Login_logo.png"];
    [self.view addSubview:IVLogo];
    
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake((WINDOWWIDTH - 90)/2, 100 + 90 + 10, 90, 20)];
    labelName.font = [UIFont systemFontOfSize:20];
    labelName.text = @"EatAway";
    labelName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelName];
    
    viewUsername = [[PhoneLoginTextFieldView alloc]initWithFrame:CGRectMake(20, WINDOWHEIGHT - 340, WINDOWWIDTH - 40, 45)];
    viewUsername.imageV.image = [UIImage imageNamed:@"Login_icon_user.png"];
    viewUsername.textField.tag = 1;
    viewUsername.textField.delegate = self;
    [self.view addSubview:viewUsername];
    if(ISCHINESE)
    {
        viewUsername.textField.placeholder = @"请输入手机号";
    }
    else
    {
        viewUsername.textField.placeholder = @"Phone Number";
    }
    
    viewPassword = [[PhoneLoginTextFieldView alloc]initWithFrame:CGRectMake(20, WINDOWHEIGHT - 340 + 45 + 15, WINDOWWIDTH - 40, 45)];
    viewPassword.imageV.image = [UIImage imageNamed:@"Login_icon_password.png"];
    viewPassword.textField.secureTextEntry = YES;
    [self.view addSubview:viewPassword];
    if(ISCHINESE)
    {
        viewPassword.textField.placeholder = @"请输入密码";
    }
    else
    {
        viewPassword.textField.placeholder = @"Password";
    }
    
    btnForget = [UIButton buttonWithType:UIButtonTypeCustom];
    btnForget.frame = CGRectMake(20, WINDOWHEIGHT - 340 + 45 + 15 + 45 + 10, 100, 15);
    btnForget.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnForget setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btnForget.titleLabel.font = [UIFont systemFontOfSize:11];
    [btnForget addTarget:self action:@selector(btnForgetPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnForget];
    if(ISCHINESE)
    {
        [btnForget setTitle:@"忘记密码" forState:UIControlStateNormal]; ;
    }
    else
    {
        [btnForget setTitle:@"Forget Password" forState:UIControlStateNormal]; ;
    }
    
    btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRegister.frame = CGRectMake(WINDOWWIDTH- 100 - 20, WINDOWHEIGHT - 340 + 45 + 15 + 45 + 10, 100, 15);
    btnRegister.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btnRegister setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btnRegister.titleLabel.font = [UIFont systemFontOfSize:11];
    [btnRegister addTarget:self action:@selector(btnGoToSignUpClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegister];
    if(ISCHINESE)
    {
        [btnRegister setTitle:@"点击注册" forState:UIControlStateNormal]; ;
    }
    else
    {
        [btnRegister setTitle:@"Sign up" forState:UIControlStateNormal]; ;
    }
    
    btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLogin.frame = CGRectMake(20, WINDOWHEIGHT - 340 + 45 + 15 + 45 + 10 + 15 + 20, WINDOWWIDTH - 40, 45);
    btnLogin.backgroundColor = MAINCOLOR;
    btnLogin.clipsToBounds = YES;
    btnLogin.layer.cornerRadius = 7;
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btnLogin];
    [btnLogin addTarget:self action:@selector(btnLoginCLick) forControlEvents:UIControlEventTouchUpInside];
    if(ISCHINESE)
    {
        [btnLogin setTitle:@"登 录" forState:UIControlStateNormal]; ;
    }
    else
    {
        [btnLogin setTitle:@"Log in" forState:UIControlStateNormal]; ;
    }
    
    
    
    btnZhong = [UIButton buttonWithType:UIButtonTypeCustom];
    btnZhong.frame = CGRectMake(WINDOWWIDTH - 20 - 60,WINDOWHEIGHT - 50, 30, 20);
    [btnZhong setTitle:@"中" forState:UIControlStateNormal];
    btnZhong.titleLabel.font = [UIFont systemFontOfSize:12];
    btnZhong.tag = 1;
    [btnZhong addTarget:self action:@selector(btnChangeLanguageCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZhong];
    if (ISCHINESE)
    {
        [btnZhong setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }
    else
    {
        [btnZhong setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
    }
    
    UIView *viewl = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 20 - 60 + 29,WINDOWHEIGHT - 50, 1, 20)];
    viewl.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
    [self.view addSubview:viewl];
    
    btnEnglish = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEnglish.frame = CGRectMake(WINDOWWIDTH - 20 - 60 + 30, WINDOWHEIGHT - 50, 30, 20);
    [btnEnglish setTitle:@"EN" forState:UIControlStateNormal];
    btnEnglish.titleLabel.font = [UIFont systemFontOfSize:12];
    btnEnglish.tag = 2;
    [btnEnglish addTarget:self action:@selector(btnChangeLanguageCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEnglish];
    if (ISCHINESE)
    {
        [btnEnglish setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
    }
    else
    {
        [btnEnglish setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }
    
    
    
}
-(void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnChangeLanguageCLick:(UIButton *)btn
{
    if (ISCHINESE && btn.tag == 2)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"language"];
        [btnZhong setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
        [btnEnglish setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        
    }
    else if(!ISCHINESE && btn.tag == 1)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"language"];
        [btnZhong setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [btnEnglish setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage" object:nil];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 1)
    {
        //        NSLog(@"range.location = %ld,rang.length = %ld,string = %@",range.location,range.length,string);
        NSArray *arr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        if (range.length == 1 && [string isEqualToString:@""])
        {
            return YES;
        }
        else if(textField.text.length>= 11)
        {
            return NO;
        }
        else if ([arr containsObject:string])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return YES;
    }
}
-(void)btnLoginCLick
{
    if (viewUsername.textField.text.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请输入手机号", @"please enter the phone number") onViewController:self];
    }
    else if(viewPassword.textField.text.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请输入密码", @"please enter the password") onViewController:self];
    }
    else
    {
        __block LoginWithPhoneViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSLog(@"password = %@",[self md5:[NSString stringWithFormat:@"%@EatAway",viewPassword.textField.text]]);
        
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/user/login" parameter:@{@"phone":viewUsername.textField.text,@"password":[self md5:[NSString stringWithFormat:@"%@EatAway",viewPassword.textField.text]]} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"登录失败，请检查网络连接", @"Login failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(0)])
            {
                [TotalFunctionView alertContent:ZEString(@"账号密码错误", @"Wrong phone number or password") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                progress = [MBProgressHUD showHUDAddedTo:blockSelf.view animated:YES];
                [JPUSHService setAlias:resultDic[@"shopid"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    [progress hide:YES];
                    [[NSUserDefaults standardUserDefaults] setObject:resultDic[@"shopid"] forKey:@"userid"];
                    [[NSUserDefaults standardUserDefaults] setObject:resultDic[@"token"] forKey:@"token"];
                    
                    [blockSelf.navigationController popViewControllerAnimated:YES];
                } seq:1];
                

//                    [[NSUserDefaults standardUserDefaults] setObject:resultDic[@"shopid"] forKey:@"userid"];
//                    [[NSUserDefaults standardUserDefaults] setObject:resultDic[@"token"] forKey:@"token"];
//                    
//                    [blockSelf.navigationController popViewControllerAnimated:YES];
                
                
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"登录失败，请检查网络连接", @"Login failed, please check the network connection") onViewController:blockSelf];
            }
            
        }];
    }
    
}
-(void)btnGoToSignUpClick
{
    RegisterViewController *RVC = [[RegisterViewController alloc]init];
    RVC.delegate = self;
    [self.navigationController pushViewController:RVC animated:YES];
}
-(void)btnForgetPasswordClick
{
    ForgetPasswordViewController *FPVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:FPVC animated:YES];
}
-(void)RegisterSucceedWithPhoneNum:(NSString *)strPhoneNum
{
    viewUsername.textField.text = strPhoneNum;
}
- (NSString *)md5:(NSString *) input
{
    
    const char *cStr = [input UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
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
