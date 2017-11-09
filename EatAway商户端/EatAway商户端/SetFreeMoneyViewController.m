//
//  SetFreeMoneyViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "SetFreeMoneyViewController.h"



@interface SetFreeMoneyViewController ()<UITextFieldDelegate>
{
    UITextField *TFContent;
}
@end

@implementation SetFreeMoneyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    UIButton *btnCancelUp = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancelUp.frame = CGRectMake(0, 64 , WINDOWWIDTH, (WINDOWHEIGHT - 180)/2 - 64);
    [btnCancelUp addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCancelUp];
    
    UIButton *btnCancelDown = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancelDown.frame = CGRectMake(0, (WINDOWHEIGHT - 180)/2 + 180 , WINDOWWIDTH, (WINDOWHEIGHT - 180)/2 );
    [btnCancelDown addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCancelDown];
    
    
    UIView *viewWihteBG = [[UIView alloc]initWithFrame:CGRectMake((WINDOWWIDTH - 300)/2, (WINDOWHEIGHT - 180)/2, 300, 180)];
    viewWihteBG.backgroundColor = [UIColor whiteColor];
    viewWihteBG.clipsToBounds = YES;
    viewWihteBG.layer.cornerRadius = 15;
    [self.view addSubview:viewWihteBG];
    
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 280, 30)];
    labelTitle.text = ZEString(@"请输入修改信息", @"Please enter the number");
    labelTitle.font = [UIFont systemFontOfSize:13];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [viewWihteBG addSubview:labelTitle];
    
    UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, 300, 1)];
    viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewWihteBG addSubview:viewDown];
    
    UIView *viewTFBG = [[UIView alloc]initWithFrame:CGRectMake(70, 50 + 22, 100, 36)];
    viewTFBG.backgroundColor = [UIColor colorWithWhite:230/255.0 alpha:1];
    viewTFBG.clipsToBounds = YES;
    viewTFBG.layer.cornerRadius = 5;
    [viewWihteBG addSubview:viewTFBG];
    
    
    TFContent = [[UITextField alloc]initWithFrame:CGRectMake(75, 50 + 22, 90, 36)];
    TFContent.delegate = self;
    TFContent.tag = 1;
    TFContent.keyboardType =  UIKeyboardTypeDecimalPad;
    [viewWihteBG addSubview:TFContent];
    
    UILabel *labelKM = [[UILabel alloc]initWithFrame:CGRectMake(75 + 90 + 15, 50 + 22, 35, 36)];
    labelKM.text = @"$";
    labelKM.font = [UIFont systemFontOfSize:17];
    labelKM.textColor = [UIColor blackColor];
    [viewWihteBG addSubview:labelKM];
    
    UIView *viewDown2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50 + 79, 300, 1)];
    viewDown2.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewWihteBG addSubview:viewDown2];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.frame = CGRectMake(0, 50 + 80, 149, 50);
    [btnCancel setTitle:ZEString(@"删除", @"Delete") forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnCancel addTarget:self action:@selector(btnDeleteClick) forControlEvents:UIControlEventTouchUpInside];
    [viewWihteBG addSubview:btnCancel];
    
    UIView *viewDown3 = [[UIView alloc]initWithFrame:CGRectMake(149, 50 + 80, 1, 50)];
    viewDown3.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewWihteBG addSubview:viewDown3];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(150, 50 + 80, 149, 50);
    [btnDone setTitle:ZEString(@"确定", @"Done") forState:UIControlStateNormal];
    [btnDone setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btnDone.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnDone addTarget:self action:@selector(btnDoneClick) forControlEvents:UIControlEventTouchUpInside];
    [viewWihteBG addSubview:btnDone];
    
}
-(void)btnCancelClick
{
    [self.view removeFromSuperview];
}
-(void)btnDeleteClick
{
    [self.delegate DeleteFreeMoney];
    [self.view removeFromSuperview];

}
-(void)btnDoneClick
{
    if (TFContent.text.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请输入修改信息", @"Please enter the config information") onViewController:self];
    }
    else
    {
        [self.delegate SetFreeMoney:TFContent.text];
        [self.view removeFromSuperview];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 1)
    {
        NSArray *arr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"."];
        if (range.length == 1 && [string isEqualToString:@""])
        {
            return YES;
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

