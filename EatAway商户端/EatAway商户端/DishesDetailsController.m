//
//  DishesDetailsController.m
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "DishesDetailsController.h"
#import "AddFoodTypeController.h"
#import "DishesDetailsModel.h"
#import "soldOutModel.h"
#import "UIImageView+WebCache.h"
#import "LoginWithPhoneViewController.h"
#import <MBProgressHUD.h>

@interface DishesDetailsController ()<addFoodTypeDelegate>
@property (nonatomic, retain) UIImageView *backgroundImg;
@property (nonatomic, retain) UILabel *numLab;
@property (nonatomic, retain) UIButton *editBtn;
@property (nonatomic, retain) UILabel *foodNameLab;
@property (nonatomic, retain) UILabel *foodNameLab1;
@property (nonatomic, retain) UILabel *foodPrice;
@property (nonatomic, retain) UITextView *explainTextView;
@property (nonatomic, retain) UIButton *outOfPrintBtn;
@property (nonatomic, retain) UIButton *deleteBtn;
@property (nonatomic, retain) DishesDetailsModel *dishesDetailsModel;
@property (nonatomic, retain) soldOutModel *soldOutModel;
@property (nonatomic, retain) MBProgressHUD *hub;

@end

@implementation DishesDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self myDatas];
    [self createHeaderView];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)createHeaderView{
    
    self.backgroundImg = [[UIImageView alloc]init];
    self.backgroundImg.frame = CGRectMake(0, -22, WINDOWWIDTH, 230);
    self.backgroundImg.image = [UIImage imageNamed:@"3.2.2_pic_bg"];
    self.backgroundImg.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImg.clipsToBounds = YES;
    [self.view addSubview:self.backgroundImg];
    
    self.numLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, WINDOWWIDTH, 50)];
    self.numLab.text = @"已售101份";
    self.numLab.textColor = [UIColor whiteColor];
    self.numLab.font = [UIFont systemFontOfSize:18];
    self.numLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.numLab];
    
    UIView *btnBackView = [[UIView alloc]initWithFrame:CGRectMake(4, 30, 25, 25)];
    btnBackView.backgroundColor = EWColor(0, 0, 0, 0.2);
    btnBackView.layer.cornerRadius = 12.5;
    [self.view addSubview:btnBackView];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(8, 30, 25, 25);
    [backBtn setImage:[UIImage imageNamed:@"menuBack"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.frame = CGRectMake(WINDOWWIDTH - 28, 30, 20, 20);
    [self.editBtn setImage:[UIImage imageNamed:@"3.2.2_icon_modify"] forState:UIControlStateNormal];
    self.editBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.editBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editBtn];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 230 - 46 - 22, WINDOWWIDTH, 46)];
    grayView.backgroundColor = EWColor(0, 0, 0, 0.1);
    [self.view addSubview:grayView];
    
    self.foodNameLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, WINDOWWIDTH / 2 -30, 36)];
    self.foodNameLab.textColor = [UIColor whiteColor];
    self.foodNameLab.text = @"特色牛排";
    self.foodNameLab.font = [UIFont systemFontOfSize:15];
    self.foodNameLab.textAlignment = NSTextAlignmentLeft;
    [grayView addSubview:self.foodNameLab];
    
    self.foodPrice = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH/2 + 10, 5, WINDOWWIDTH/2 - 30, 36)];
    self.foodPrice.textColor = [UIColor whiteColor];
    self.foodPrice.text = @"$ 60";
    self.foodPrice.font = [UIFont systemFontOfSize:15];
    self.foodPrice.textAlignment = NSTextAlignmentRight;
    [grayView addSubview:self.foodPrice];
    
}

- (void)createUI{
    
    UILabel *menuLab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.backgroundImg.frame) + 10, 65, 30)];
    menuLab.textAlignment = NSTextAlignmentLeft;
    menuLab.text = ZEString(@"菜单", @"Menu");
    menuLab.textColor = EWColor(51, 51, 51, 1);
    menuLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:menuLab];
    
    self.foodNameLab1 = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 200, CGRectGetMaxY(self.backgroundImg.frame) + 10, 180, 30)];
    self.foodNameLab1.textAlignment = NSTextAlignmentRight;
    self.foodNameLab1.textColor = EWColor(51, 51, 51, 1);
    self.foodNameLab1.font = [UIFont systemFontOfSize:15];
    self.foodNameLab1.text = @"牛排";
    [self.view addSubview:self.foodNameLab1];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(menuLab.frame) + 10, WINDOWWIDTH, 1)];
    lineView.backgroundColor = EWColor(240, 240, 240, 1);
    [self.view addSubview:lineView];
    
    UILabel *explainLab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lineView.frame) + 10, WINDOWWIDTH - 30, 30)];
    explainLab.textAlignment = NSTextAlignmentLeft;
    explainLab.text = ZEString(@"菜单介绍", @"Description");
    explainLab.textColor = EWColor(51, 51, 51, 1);
    explainLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:explainLab];
    
    self.explainTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(explainLab.frame) + 10, WINDOWWIDTH - 30, 140)];
//    self.explainTextView.delegate = self;
    self.explainTextView.backgroundColor = EWColor(240, 240, 240, 1);
    self.explainTextView.font = [UIFont systemFontOfSize:14];
    self.explainTextView.text = @"这是店里的招牌菜, 欢迎品尝";
    [self.explainTextView setEditable:NO];
    self.explainTextView.textColor = EWColor(204, 204, 204, 1);
    [self.view addSubview:self.explainTextView];
    
    self.outOfPrintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.outOfPrintBtn.frame = CGRectMake(20, WINDOWHEIGHT - 100, WINDOWWIDTH - 40, 40);
    
    if (self.judge == 1) {
        self.outOfPrintBtn.backgroundColor = [UIColor colorWithRed:0.97f green:0.64f blue:0.16f alpha:1.00f];
        [self.outOfPrintBtn setTitle:ZEString(@"已售完", @"Sold out") forState:UIControlStateNormal];
    }else{
        self.outOfPrintBtn.backgroundColor = [UIColor blueColor];
        [self.outOfPrintBtn setTitle:ZEString(@"重新上架", @"Back on") forState:UIControlStateNormal];
    }
    NSLog(@"测试测试测试测试测试测试测试测试测试%ld",self.judge);
    
    self.outOfPrintBtn.layer.cornerRadius = 5;
    self.outOfPrintBtn.clipsToBounds = YES;
    [self.outOfPrintBtn addTarget:self action:@selector(outOfPrintClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.outOfPrintBtn];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(20, CGRectGetMaxY(self.outOfPrintBtn.frame) + 10, WINDOWWIDTH - 40, 40);
    self.deleteBtn.backgroundColor = [UIColor colorWithRed:0.95f green:0.24f blue:0.25f alpha:1.00f];
    [self.deleteBtn setTitle:ZEString(@"删除", @"Delete") forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deleteBtn.layer.cornerRadius = 5;
    self.deleteBtn.clipsToBounds = YES;
    [self.deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteBtn];
    
}

- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];if ([self.detailsDelegate respondsToSelector:@selector(refresh)]) {
        [self.detailsDelegate refresh];
    }
}
#pragma mark - 删除按钮的点击事件
- (void)deleteClick{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:ZEString(@"提示", @"reminder") message:ZEString(@"确定要删除吗?", @"Confirmed to delete？") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alertOK = [UIAlertAction actionWithTitle:ZEString(@"确定", @"determine") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    NSString *goodsidStr = [NSString stringWithFormat:@"%ld",self.goodsId];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"shopid"] = USERID;
    params[@"token"] = TOKEN;
    params[@"goodsid"] = goodsidStr;
    if (USERID == nil || TOKEN == nil) {
        LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else{
    [HWHttpTool post:Server_Deletegoods params:params success:^(id json) {
        if ([json[@"status"] integerValue] == 1) {
            [SVProgressHUD showInfoWithStatus:ZEString(@"删除成功", @"Delete the success")];
            [self.navigationController popViewControllerAnimated:YES];
            if ([self.detailsDelegate respondsToSelector:@selector(refresh)]) {
                [self.detailsDelegate refresh];
            }
        }else if ([json[@"status"]integerValue] == 9){
            [SVProgressHUD showInfoWithStatus:ZEString(@"登录信息过期，请重新登录", @"Login information is expired, please login again")];
            [ObjectForUser clearLogin];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败", @"Network connection failed")];
    }];
    }
        
    }];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:ZEString(@"取消", @"cancel") style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:alertOK];
    [alertC addAction:alert];
    [alertOK setValue:[UIColor colorWithRed:0.13 green:0.13 blue:0.10 alpha:1] forKey:@"_titleTextColor"];
    [alert setValue:[UIColor colorWithRed:0.13 green:0.13 blue:0.10 alpha:1] forKey:@"_titleTextColor"];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark - 已售完按钮的点击事件
- (void)outOfPrintClick:(UIButton *)sender{
    
    
    if (self.judge == 1) {
        NSString *goodsIdStr = [NSString stringWithFormat:@"%ld",self.goodsId];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"shopid"] = USERID;
        params[@"token"] = TOKEN;
        params[@"goodsid"] = goodsIdStr;
        sender.backgroundColor = [UIColor blueColor];
        __weak typeof(self) weakS = self;
        if (USERID == nil || TOKEN == nil) {
            LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else{
            self.hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [HWHttpTool post:Server_Editflagb params:params success:^(id json) {
            [self.hub hide:YES];
            if ([json[@"status"] integerValue] == 1){
                
                weakS.soldOutModel = [[soldOutModel alloc]initWithDictionary:json[@"msg"] error:nil];
                [weakS soldOutFuZhib];
                self.outOfPrintBtn.backgroundColor = [UIColor blueColor];
                [self.outOfPrintBtn setTitle:@"重新上架" forState:UIControlStateNormal];
                self.judge = 2;
            }
            else if ([json[@"status"] integerValue] == 9){
                
                [SVProgressHUD showInfoWithStatus:ZEString(@"登录信息过期，请重新登录", @"Login information is expired, please login again")];

                [ObjectForUser clearLogin];
            }else{
                
                [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败", @"Network connection failed")];
            }
        } failure:^(NSError *error) {
            
            [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败",  @"Network connection failed")];
        }];
        }
    }else{
        
        NSString *goodsIdStr = [NSString stringWithFormat:@"%ld",self.goodsId];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        params[@"shopid"] = USERID;
        params[@"goodsid"] = goodsIdStr;
        params[@"token"] = TOKEN;
        
        __weak typeof(self) weakS = self;
        if (USERID == nil || TOKEN == nil) {
            LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else{
            self.hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [HWHttpTool post:Server_Editflaga params:params success:^(id json) {
            [self.hub hide:YES];
            if ([json[@"status"]integerValue] == 1) {
                weakS.soldOutModel = [[soldOutModel alloc]initWithDictionary:json[@"msg"] error:nil];
                self.outOfPrintBtn.backgroundColor = [UIColor colorWithRed:0.97f green:0.64f blue:0.16f alpha:1.00f];
                [self.outOfPrintBtn setTitle:ZEString(@"已售完", @"Sold out") forState:UIControlStateNormal];
                self.judge = 1;
                [weakS putawayFuZhi];
            }else if ([json[@"status"] integerValue] == 9){
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
}

- (void)soldOutFuZhib{
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",self.dishesDetailsModel.num,ZEString(@"已售完(下架中)", @"Sold out")]];
    NSRange redRangeTwo = NSMakeRange([[noteStr string]rangeOfString:self.dishesDetailsModel.num].location, [[noteStr string] rangeOfString:self.dishesDetailsModel.num].length);
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:40] range:redRangeTwo];
    [self.numLab setAttributedText:noteStr];
    [self.numLab adjustsFontSizeToFitWidth];
}

- (void)putawayFuZhi{
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",self.dishesDetailsModel.num,ZEString(@"份已售", @"Sold")]];
    NSRange redRangeTwo = NSMakeRange([[noteStr string]rangeOfString:self.dishesDetailsModel.num].location, [[noteStr string] rangeOfString:self.dishesDetailsModel.num].length);
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:40] range:redRangeTwo];
    
    [self.numLab setAttributedText:noteStr];
    [self.numLab adjustsFontSizeToFitWidth];
}
#pragma mark - 编辑按钮的点击事件
- (void)editClick{
    
    AddFoodTypeController *editVC = [[AddFoodTypeController alloc]init];
    editVC.addDelegate = self;
    editVC.goodsId = self.goodsId;
    editVC.editCid = self.cid;
    editVC.vcClass = 2;
    [self.navigationController pushViewController:editVC animated:YES];
    
}

- (void)addRefresh{
    
    [self myDatas];
}

- (void)myDatas{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *goodsIdStr = [NSString stringWithFormat:@"%ld",self.goodsId];
    params[@"shopid"] = USERID;
    params[@"goodsid"] = goodsIdStr;
    params[@"token"] = TOKEN;
    
    __weak typeof(self) weakS = self;
    if (USERID == nil || TOKEN == nil) {
        LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else{
    [HWHttpTool post:Server_Menudetail params:params success:^(id json) {
        if ([json[@"status"] integerValue] == 1) {
            weakS.dishesDetailsModel = [[DishesDetailsModel alloc]initWithDictionary:json[@"msg"] error:nil];
            self.judge = [self.dishesDetailsModel.flag integerValue];
            [weakS FuZhi];
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

- (void)FuZhi{
    
    [self.backgroundImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dishesDetailsModel.goodsphoto]]placeholderImage:[UIImage imageNamed:@"3.2.2_pic_bg"]];
    
    if ([self.dishesDetailsModel.flag integerValue] == 1) {
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",self.dishesDetailsModel.num,ZEString(@"份已售", @"Sold")]];
        NSRange redRangeTwo = NSMakeRange([[noteStr string]rangeOfString:self.dishesDetailsModel.num].location, [[noteStr string] rangeOfString:self.dishesDetailsModel.num].length);
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:40] range:redRangeTwo];
        
         [self.numLab setAttributedText:noteStr];
        [self.numLab adjustsFontSizeToFitWidth];
    }else{
        
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",self.dishesDetailsModel.num,ZEString(@"已售完(下架中)", @"Sold out")]];
        NSRange redRangeTwo = NSMakeRange([[noteStr string]rangeOfString:self.dishesDetailsModel.num].location, [[noteStr string] rangeOfString:self.dishesDetailsModel.num].length);
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:40] range:redRangeTwo];
        [self.numLab setAttributedText:noteStr];
        [self.numLab adjustsFontSizeToFitWidth];
    }
    
    self.foodNameLab.text = self.dishesDetailsModel.goodsname;
    self.foodPrice.text = [NSString stringWithFormat:@"$  %@",self.dishesDetailsModel.goodsprice];
    self.foodNameLab1.text = self.dishesDetailsModel.fenlei;
    self.explainTextView.text = self.dishesDetailsModel.goodscontent;
    
    
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
