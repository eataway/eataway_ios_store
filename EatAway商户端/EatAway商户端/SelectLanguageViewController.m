//
//  SelectLanguageViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "SelectLanguageViewController.h"


@interface SelectLanguageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation SelectLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"语言/Language";
//    [self tableViewInit];
    
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chooseLanguage.png"]];
    imgView.frame = CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT / 3 * 2);
    [self.view addSubview:imgView];
    
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(20, 30, 13, 20);
    [returnBtn setImage:[UIImage imageNamed:@"Login_back.png"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnToVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    
    
    UIButton *chineseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chineseBtn.frame = CGRectMake(16, WINDOWHEIGHT / 4 * 3, WINDOWWIDTH - 32, 40);
    chineseBtn.layer.borderWidth = 1;
    chineseBtn.layer.borderColor = [UIColor colorWithRed:22.0/255.0 green:138.0 / 255.0 blue:232.0/255.0 alpha:1].CGColor;
    [chineseBtn setTitle:@"中   文" forState:UIControlStateNormal];
    [chineseBtn setTitleColor:[UIColor colorWithRed:22.0/255.0 green:138.0 / 255.0 blue:232.0/255.0 alpha:1] forState:UIControlStateNormal];
    chineseBtn.layer.masksToBounds = YES;
    chineseBtn.layer.cornerRadius = 5;
    [chineseBtn addTarget:self action:@selector(chooseChineseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chineseBtn];
    
    
    UIButton *englishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    englishBtn.frame = CGRectMake(16, WINDOWHEIGHT / 4 * 3 + 16 + 40, WINDOWWIDTH - 32, 40);
    englishBtn.layer.borderWidth = 1;
    englishBtn.layer.borderColor = [UIColor colorWithRed:22.0/255.0 green:138.0 / 255.0 blue:232.0/255.0 alpha:1].CGColor;
    [englishBtn setTitle:@"English" forState:UIControlStateNormal];
    [englishBtn setTitleColor:[UIColor colorWithRed:22.0/255.0 green:138.0 / 255.0 blue:232.0/255.0 alpha:1] forState:UIControlStateNormal];
    englishBtn.layer.masksToBounds = YES;
    englishBtn.layer.cornerRadius = 5;
    [englishBtn addTarget:self action:@selector(chooseEnglishAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:englishBtn];
    
}

-(void)returnToVC{
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}


// 选择中文
-(void)chooseChineseAction{
    [self.delegate SelectLanguageSucceedWithTag:1];
    [self.navigationController popViewControllerAnimated:YES];
}

// 选择英文
-(void)chooseEnglishAction{
    [self.delegate SelectLanguageSucceedWithTag:2];
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        [cell addSubview:viewDown];
    }
    if(indexPath.row == 0)
    {
        cell.textLabel.text = @"简体中文";
    }
    else
    {
        cell.textLabel.text = @"English";
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self.delegate SelectLanguageSucceedWithTag:1];

        
    }
    else
    {
        [self.delegate SelectLanguageSucceedWithTag:2];
        
    }

    
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

