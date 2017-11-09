//
//  ChangeValueViewController.m
//  UniTrader
//
//  Created by 木丶阿伦 on 17/1/14.
//  Copyright © 2017年 youfeng. All rights reserved.
//

#import "ChangeValueViewController.h"

@interface ChangeValueViewController ()
{
    UITextField *TFContent;
}

@end

@implementation ChangeValueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.strTitle;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:ZEString(@"确定", @"OK") style:UIBarButtonItemStylePlain target:self action:@selector(btnEndClick)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    
    UIView *viewTFBG = [[UIView alloc]initWithFrame:CGRectMake(0,64 + 10, WINDOWWIDTH, 40)];
    viewTFBG.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewTFBG];
    
    
    TFContent = [[UITextField alloc]initWithFrame:CGRectMake(5,64 +  10, WINDOWWIDTH - 10, 40)];
    TFContent.placeholder = self.strPlacehoder;
//    TFContent.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
//    TFContent.layer.borderWidth = 1;
    TFContent.text = self.strContent;
    TFContent.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:TFContent];
    
    
}
-(void)btnEndClick
{
    [self.delegate valueChangeToString:TFContent.text identifier:self.identifier];
    [self.navigationController popViewControllerAnimated:YES];
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
