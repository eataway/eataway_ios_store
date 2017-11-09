//
//  MerchantReplyViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/21.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantReplyViewController.h"

@interface MerchantReplyViewController ()<UITextViewDelegate>
{
    UITextView *TV;
}
@end

@implementation MerchantReplyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = ZEString(@"回复", @"Reply");
    
    UIView *viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTop.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTop];
    
    
    UIView *viewBg = [[UIView alloc]initWithFrame:CGRectMake(12, 64 + 12, WINDOWWIDTH - 24, 200)];
    viewBg.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:viewBg];
    
    TV = [[UITextView alloc]initWithFrame:CGRectMake(15,  64 + 15, WINDOWWIDTH - 30, 194)];
    TV.backgroundColor = [UIColor clearColor];
    TV.delegate = self;
    [self.view addSubview:TV];
    TV.text = ZEString(@"输入回复……", @"Enter your reply here ...");
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
    if ([TV.text isEqualToString:@""] || [TV.text isEqualToString:@"输入回复……"] || [TV.text isEqualToString:@"Enter your reply here ..."])
    {
        [TotalFunctionView alertContent:ZEString(@"请输入回复内容", @"Please enter your reply here") onViewController:self];
    }
    else
    {
        [self.delegate MerchantReplayContent:TV.text index:self.cellIndex];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"输入回复……"] || [textView.text isEqualToString:@"Enter your reply here ..."])
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.text = ZEString(@"输入回复……", @"Enter your reply here ...");
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
