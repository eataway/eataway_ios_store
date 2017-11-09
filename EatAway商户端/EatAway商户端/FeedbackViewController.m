//
//  FeedbackViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/18.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "FeedbackViewController.h"

#import <MBProgressHUD.h>

@interface FeedbackViewController ()<UITextViewDelegate>
{
    UITextView *TV;
    MBProgressHUD *progress;
}
@end

@implementation FeedbackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = ZEString(@"意见反馈", @"Feedback");
    
    UIView *viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTop.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTop];
    
    
    UIView *viewBg = [[UIView alloc]initWithFrame:CGRectMake(12, 64 + 12, WINDOWWIDTH - 24, 200)];
    viewBg.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:viewBg];
    
    TV = [[UITextView alloc]initWithFrame:CGRectMake(15,  64 + 15, WINDOWWIDTH - 30, 194)];
    TV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:TV];
    TV.delegate = self;
    TV.text = ZEString(@"在此输入您的意见或建议……", @"Enter your comments or suggestions here ...");
    TV.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
    
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(22, WINDOWHEIGHT - 45 - 15, WINDOWWIDTH - 44, 45);
    btnDone.backgroundColor = [UIColor orangeColor];
    btnDone.clipsToBounds = YES;
    btnDone.layer.cornerRadius = 7;
    [btnDone setTitle:ZEString(@"确定", @"OK") forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(btnDoneClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDone];
    
}
-(void)btnDoneClick
{
    if(![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else if ([TV.text isEqualToString:@"在此输入您的意见或建议……"] || [TV.text isEqualToString:@"Enter your comments or suggestions here ..."] || [TV.text isEqualToString:@""])
    {
        [TotalFunctionView alertContent:ZEString(@"请输入您的意见或建议", @"Please enter your comments or suggestions") onViewController:self];
    }
    else
    {
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak FeedbackViewController *blockSelf = self;
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/evaluate/shopback" parameter:@{@"shopid":USERID,@"token":TOKEN,@"backmessage":TV.text} resultBlock:^(NSDictionary *resultDic)
        {
            [progress hide:YES];
            if(resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"操作失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                [TotalFunctionView alertAndDoneWithContent:ZEString(@"反馈成功，感谢您的宝贵意见", @"Feedback succeed, thanks for your valuable advice") onViewController:blockSelf];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"操作失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
            }
        }];
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"在此输入您的意见或建议……"] || [textView.text isEqualToString:@"Enter your comments or suggestions here ..."])
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.text = ZEString(@"在此输入您的意见或建议……", @"Enter your comments or suggestions here ...");
        textView.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
        
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
