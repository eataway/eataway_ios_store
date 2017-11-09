//
//  CertificationInfoViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "CertificationInfoViewController.h"
#import <MBProgressHUD.h>

@interface CertificationInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIButton *btnQuit;
    MBProgressHUD *progress;
    
}
@end

@implementation CertificationInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = ZEString(@"认证信息", @"Certification");
    
    UIView *viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTop.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTop];
    
    
    [self tableViewInit];
    
}
-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 10, WINDOWWIDTH, 310) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4)
    {
        return 130;
    }
    else
    {
        return 45;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 44, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewDown];
        }
        
        NSArray *arrTitle = @[ZEString(@"店铺名称", @"Name"),ZEString(@"认证阶段", @"Status"),ZEString(@"联系方式", @"Contact"),ZEString(@"店铺位置", @"Location")];
        
        NSString *strState = @"";
        if ([MERCHANTSTATE isEqualToString:@"1"] || [MERCHANTSTATE isEqualToString:@"2"])
        {
            strState = ZEString(@"已认证", @"Certified");
        }
        else if ([MERCHANTSTATE isEqualToString:@"3"])
        {
            strState = ZEString(@"认证中", @"Authenticating");
        }
        else if ([MERCHANTSTATE isEqualToString:@"4"])
        {
            strState = ZEString(@"申请退出中", @"Apply for exit");
        }
        
        NSArray *arrDetail = @[NICKNAME,strState,SHOPPHONE,SHOPADDRESS];
        
        cell.textLabel.text = arrTitle[indexPath.row];
        cell.detailTextLabel.text = arrDetail[indexPath.row];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
            cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            
            btnQuit = [UIButton buttonWithType:UIButtonTypeCustom];
            btnQuit.frame = CGRectMake(22, 50, WINDOWWIDTH - 44, 45);
            btnQuit.backgroundColor = [UIColor redColor];
            btnQuit.layer.cornerRadius = 7;
            btnQuit.clipsToBounds = YES;
            [btnQuit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnQuit.titleLabel.font = [UIFont systemFontOfSize:13];
            [btnQuit setTitle:ZEString(@"退出加盟", @"Sign out") forState:UIControlStateNormal];
            [btnQuit addTarget:self action:@selector(btnQuitClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnQuit];
            if (self.hideQuitBtn)
            {
                btnQuit.hidden = YES;
            }
            
            UIButton *btnContaceUs = [UIButton buttonWithType:UIButtonTypeCustom];
            btnContaceUs.titleLabel.font = [UIFont systemFontOfSize:11];
            CGSize sizebtn = [self sizeOfString:ZEString(@"联系我们", @"Contact us") fontSize:11];
            btnContaceUs.frame = CGRectMake(WINDOWWIDTH - 22 - sizebtn.width - 2,50 + 50 , sizebtn.width + 2, 20);
            NSString *textStr = ZEString(@"联系我们", @"Contact us");
            // 下划线
            NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:MAINCOLOR};
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
            [btnContaceUs setAttributedTitle:attribtStr forState:UIControlStateNormal];
            [btnContaceUs addTarget:self action:@selector(contaceUsClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnContaceUs];
            
            UILabel *labelContact = [[UILabel alloc]initWithFrame:CGRectMake(22, 50 + 50, WINDOWWIDTH - 44 - sizebtn.width - 2, 20)];
            labelContact.text = ZEString(@"还没等到工作人员？", @"Not waiting for staff?");
            labelContact.font = [UIFont systemFontOfSize:11];
            labelContact.textAlignment = NSTextAlignmentRight;
            [cell addSubview:labelContact];
            
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)btnQuitClick
{
    
    __weak CertificationInfoViewController *blockSelf = self;
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ObjectForRequest shareObject] requestWithURL:@"index.php/server/user/out" parameter:@{@"shopid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
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
            [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"isopen"];
            [[NSUserDefaults standardUserDefaults] setObject:@"4" forKey:@"merchantstate"];
            [TotalFunctionView alertAndDoneWithContent:ZEString(@"申请成功，我们会尽快与您联系", @"Successful application, we will contact you as soon as possible") onViewController:blockSelf];
        }
        else
        {
            [TotalFunctionView alertContent:ZEString(@"操作失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
        }
        
        
    }];

    
    
}

- (void)contaceUsClick{
    if (ISCHINESE)
    {
        [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:@"tel://0452451156"]];
    }
    else
    {
        [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:@"tel://0403537867"]];
    }
    
}

- (void)didReceiveMemoryWarning {
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
