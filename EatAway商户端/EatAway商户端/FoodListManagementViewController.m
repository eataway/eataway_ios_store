//
//  FoodListManagementViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/7/11.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "FoodListManagementViewController.h"
#import "FoodListManagerCell.h"
#import "foodListPopupView.h"
#import "FoodListDetailsController.h"
#import "foodListManagerModel.h"
#import "editPopupView.h"
#import "LoginWithPhoneViewController.h"
#import "MJRefresh.h"

@interface FoodListManagementViewController ()<UITableViewDelegate,UITableViewDataSource,foodListPopupDelegate,foodListManagerDelegate,editPopupViewDelegate,foodListDetailsDelegate>

@property (nonatomic, retain) UITableView *myTable;
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) UIButton *addBtn;
@property (nonatomic, retain) UIView *grayView;
@property (nonatomic, retain) UIButton *cancelBtn;
@property (nonatomic, retain) foodListPopupView *popopView;
@property (nonatomic, retain) NSArray *titleArr;
@property (nonatomic, retain) NSArray *foodListArr;
@property (nonatomic, strong) foodListManagerModel *listModel;
@property (nonatomic, retain) NSMutableArray *apps;
@property (nonatomic, retain) editPopupView *editView;//编辑按钮的弹窗视图
@property (nonatomic, retain) UIView *editGrayView;//编辑按钮的弹窗灰色视图
@property (nonatomic, retain) UIButton *cancelEditBtn;
@property (nonatomic, retain) NSIndexPath *EditIndex;
@property (nonatomic, retain) NSIndexPath *index;
@property (nonatomic, retain) MJRefreshNormalHeader *header;

@end

@implementation FoodListManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (ISCHINESE)
    {
        self.title = @"菜单管理";
    }
    else
    {
        self.title = @"Menu";
    }
    
    [self createNav];
    [self createTable];
    [self myDatas];
    [self popupMethod];
    [self MJRefresh];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self myDatas];
}

-(void)changeLanguage
{
    self.navigationController.tabBarItem.title = ZEString(@"菜单管理", @"Menu");
    if (ISCHINESE)
    {
        self.title = @"菜单管理";
    }
    else
    {
        self.title = @"Menu";
    }
    
    [self.header setTitle:ZEString(@"下拉可以刷新", @"The drop-down can refresh") forState:MJRefreshStateIdle];
    [self.header setTitle:ZEString(@"松开立即刷新", @"Loosen the refresh") forState:MJRefreshStatePulling];
    [self.header setTitle:ZEString(@"正在刷新数据中...", @"The data is being refreshed") forState:MJRefreshStateRefreshing];
//    [self.header setTitle:ZEString(@"", @"sadfsafasdfdsf") forState:MJRefreshStateNoMoreData];
   
    
}

-(void)MJRefresh{
    
    __weak __typeof(self) weakSelf = self;
   self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
       [weakSelf myDatas];
       [self.header endRefreshing];
   }];
    
    [self.header setTitle:ZEString(@"下拉可以刷新", @"The drop-down can refresh") forState:MJRefreshStateIdle];
    [self.header setTitle:ZEString(@"松开立即刷新", @"Loosen the refresh") forState:MJRefreshStatePulling];
    [self.header setTitle:ZEString(@"正在刷新数据中...", @"The data is being refreshed") forState:MJRefreshStateRefreshing];
    self.header.lastUpdatedTimeLabel.hidden = YES;
    weakSelf.myTable.mj_header = self.header;
}



- (void)createNav{
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(0, 0, 15, 15);
    [self.addBtn setImage:[UIImage imageNamed:@"3.1.0_icon_add"] forState:UIControlStateNormal];
    self.addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.clipsToBounds = NO;
    self.addBtn.userInteractionEnabled = YES;
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithCustomView:self.addBtn];
    self.navigationItem.rightBarButtonItem = addItem;
}

- (void)createTable{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64 - 44) style:UITableViewStylePlain];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.myTable.backgroundColor = EWColor(240, 240, 240, 1);
    [self.view addSubview:self.myTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.apps.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 62;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * foodListID = @"foodListCell";
    FoodListManagerCell *foodListCell = [tableView dequeueReusableCellWithIdentifier:foodListID];
    if (!foodListCell) {
        foodListCell = [[FoodListManagerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:foodListID];
        foodListCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (self.apps.count == 0) {
//        [SVProgressHUD showInfoWithStatus:@"暂无更多数据"];
    }else{
        
         foodListCell.listManagerModel = self.apps[indexPath.row];
    }
    foodListCell.managerDelegate = self;
    return foodListCell;
}

- (void)popupMethod{
    
    self.grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT)];
    self.grayView.backgroundColor = EWColor(0, 0, 0, 0.5);
    [self.view addSubview:self.grayView];
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT);
    //        self.cancelBtn.backgroundColor = [UIColor redColor];
    [self.cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.grayView addSubview:self.cancelBtn];
    
    self.popopView = [[foodListPopupView alloc]initWithFrame:CGRectMake(30, WINDOWHEIGHT/ 2 - 91, WINDOWWIDTH - 60, 182)];
    self.popopView.vcClass = 1;
    self.popopView.titleLab.text = ZEString(@"新增菜单", @"Add category");
    self.popopView.titleField.placeholder = ZEString(@"请输入新增加的菜单", @"Enter a new menu category");
    self.popopView.popupDelegate = self;
    self.popopView.backgroundColor = [UIColor whiteColor];
    [self.grayView addSubview:self.popopView];
    self.grayView.hidden = YES;
}

- (void)addClick:(UIButton *)sender{
    
    if (self.grayView.hidden == YES) {
        self.popopView.vcClass = 1;
        self.popopView.titleLab.text = ZEString(@"新增菜单", @"Add category");
        self.popopView.titleField.placeholder = ZEString(@"请输入新增加的菜单", @"Enter a new menu category");
        [self.addBtn setEnabled:YES];
        self.grayView.hidden = NO;
        
    }
    else{
        [self.addBtn setEnabled:NO];
    }

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodListDetailsController *detailVC = [[FoodListDetailsController alloc]init];
    detailVC.detailsDelegate = self;
    self.listModel = self.apps[indexPath.row];
    detailVC.cid = [self.listModel.cid integerValue];
    detailVC.titleStr = [NSString stringWithFormat:@"%@",self.listModel.cname];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


- (void)cancelMethod{
    
    self.grayView.hidden = YES;
    [self.addBtn setEnabled:YES];
}
- (void)cancelClick{
    
    self.grayView.hidden = YES;
    [self.addBtn setEnabled:YES];
}

#pragma mark - 编辑按钮的点击事件
- (void)changeClick:(UIButton *)sender{
    //     NSLog(@"MyRow:%d",[self.myTable indexPathForCell:((TableViewCell*)[[sender   superview]superview])].row);
    //    [self.myTable indexPathForCell:((UITableViewCell*)[[sender superview]superview])].row;
    self.index = [self.myTable indexPathForCell:((UITableViewCell*)[[sender superview]superview])];
//    NSLog(@"%ld",[self.myTable indexPathForCell:((UITableViewCell*)[[sender superview]superview])].row);
    self.editGrayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT)];
    self.editGrayView.backgroundColor = EWColor(0, 0, 0, 0.5);
    [self.view addSubview:self.editGrayView];
    
    self.cancelEditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelEditBtn.frame = CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT);
    //        self.cancelBtn.backgroundColor = [UIColor redColor];
    [self.cancelEditBtn addTarget:self action:@selector(cancelEditClick) forControlEvents:UIControlEventTouchUpInside];
    [self.editGrayView addSubview:self.cancelEditBtn];
    
    self.editView = [[editPopupView alloc]initWithFrame:CGRectMake(30, WINDOWHEIGHT/ 2 - 60.5, WINDOWWIDTH - 60, 121)];
    self.editView.editPopupDelegate = self;
    self.editView.backgroundColor = [UIColor whiteColor];
    [self.editGrayView addSubview:self.editView];
}

- (void)cancelEditClick{
    
    self.editGrayView.hidden = YES;
    
}
//修改菜单的点击事件
- (void)changeMethod{
    self.editGrayView.hidden = YES;
    self.grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT)];
    self.grayView.backgroundColor = EWColor(0, 0, 0, 0.5);
    [self.view addSubview:self.grayView];
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT);
    //        self.cancelBtn.backgroundColor = [UIColor redColor];
    [self.cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.grayView addSubview:self.cancelBtn];
    
    self.popopView = [[foodListPopupView alloc]initWithFrame:CGRectMake(30, WINDOWHEIGHT/ 2 - 91, WINDOWWIDTH - 60, 182)];
    self.popopView.titleLab.text = ZEString(@"修改菜单", @"Change category");
    self.popopView.titleField.placeholder = ZEString(@"请输入修改的菜单名", @"Enter a change menu category");
    self.popopView.vcClass = 2;
    self.popopView.popupDelegate = self;
    self.popopView.backgroundColor = [UIColor whiteColor];
    [self.grayView addSubview:self.popopView];
    
}
//删除菜单的点击事件
- (void)deleteMethod{
    self.editGrayView.hidden = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    foodListManagerModel *model = self.apps[self.index.row];
    params[@"shopid"] = USERID;
    params[@"cid"] = model.cid;
    params[@"token"] = TOKEN;
    if (USERID == nil || TOKEN == nil) {
        LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else{
    [HWHttpTool post:Server_Deletecategory params:params success:^(id json) {
        if ([json[@"status"] integerValue] == 1) {
            [SVProgressHUD showInfoWithStatus:ZEString(@"删除菜单列表成功", @"The delete menu list is successful")];
            [self.apps removeObjectAtIndex:self.index.row];
            [self.myTable reloadData];
        }
        else if ([json[@"status"] integerValue] == 2) {
            [SVProgressHUD showInfoWithStatus:ZEString(@"先删除该类别下所有商品", @"Delete all items in this category")];
        }else if([json[@"status"] integerValue] == 0){
            
            [SVProgressHUD showInfoWithStatus:ZEString(@"删除菜单列表失败", @"Delete menu list failed")];
        }else if ([json[@"status"]integerValue] == 9){
            
            [SVProgressHUD showInfoWithStatus:ZEString(@"登录信息过期，请重新登录", @"Login information is outdated, please login again")];
            [ObjectForUser clearLogin];
        }else{
            [SVProgressHUD showInfoWithStatus:ZEString(@"删除失败,请检查网络", @"Delete failed, please check the network")];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:ZEString(@"删除失败,请检查网络", @"Delete failed, please check the network")];
        
    }];
    }
}

- (void)confirmMethod{
    
    
    if ([self.popopView.titleField.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:ZEString(@"请输入菜单列表", @"Please enter a menu list")];
        return;
    }
    self.grayView.hidden = YES;
    if (self.popopView.vcClass == 1) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"shopid"] = USERID;
        params[@"cname"] = self.popopView.titleField.text;
        params[@"token"] = TOKEN;
        if (USERID == nil || TOKEN == nil) {
            LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else{
        [HWHttpTool post:Server_Addcategory params:params success:^(id json) {
            if ([json[@"status"] integerValue] == 1) {
                [SVProgressHUD showInfoWithStatus:ZEString(@"新增菜单列表成功", @"The new menu list is successful")];
                [self myDatas];
            }
            else if([json[@"status"] integerValue] == 0){
                [SVProgressHUD showInfoWithStatus:ZEString(@"新增菜单列表失败", @"New menu list failed")];
            }else if ([json[@"status"] integerValue] == 9){
                
                [SVProgressHUD showInfoWithStatus:ZEString(@"登录信息过期，请重新登录", @"Login information is outdated, please login again")];
                [ObjectForUser clearLogin];
            }else{
                [SVProgressHUD showInfoWithStatus:ZEString(@"请检查网络连接", @"Please check the Internet connection")];
            }
        
        } failure:^(NSError *error) {
            [SVProgressHUD showInfoWithStatus:ZEString(@"请检查网络连接", @"Please check the Internet connection")];
        }];
        }
        
    }else{
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"shopid"] = USERID;
        foodListManagerModel *model = self.apps[self.index.row];
        params[@"cid"] = model.cid;
        params[@"cname"] = self.popopView.titleField.text;
        params[@"token"] = TOKEN;
        if (USERID == nil || TOKEN == nil) {
            LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        else{
        [HWHttpTool post:Server_Editcategory params:params success:^(id json) {
            [self myDatas];
            if ([json[@"status"] integerValue] == 1) {
                [SVProgressHUD showInfoWithStatus:ZEString(@"修改菜单列表成功", @"Modify menu list success")];
            }else if([json[@"status"] integerValue] == 0){
                
                [SVProgressHUD showInfoWithStatus:ZEString(@"修改菜单列表失败", @"Failed to modify menu list")];
            }else if ([json[@"status"] integerValue] == 9){
                
                [SVProgressHUD showInfoWithStatus:ZEString(@"登录信息过期，请重新登录", @"Login information is outdated, please login again")];
                [ObjectForUser clearLogin];
            }else{
                
                [SVProgressHUD showInfoWithStatus:ZEString(@"请检查网络连接", @"Please check the Internet connection")];
            }
           
        } failure:^(NSError *error) {
            [SVProgressHUD showInfoWithStatus:ZEString(@"请检查网络连接", @"Please check the Internet connection")];
        }];
    }
    }
    [self.addBtn setEnabled:YES];
}



- (void)myDatas{
    self.apps = [[NSMutableArray alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"shopid"] = USERID;
    params[@"token"] = TOKEN;
    
    if (USERID == nil || TOKEN == nil) {
        LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else{
    [HWHttpTool post:Server_Categorylist params:params success:^(id json) {
       
        if ([json[@"status"] integerValue] == 1) {
            if ([json[@"msg"]count] == 0 ) {
                [SVProgressHUD showInfoWithStatus:ZEString(@"没有菜单列表", @"No menu list")];
            }else{
                
                self.apps = [foodListManagerModel arrayOfModelsFromDictionaries:json[@"msg"] error:nil];
                [self.myTable reloadData];
                
            }
        }
        
        
       else if ([json[@"status"] integerValue] == 2) {
            [SVProgressHUD showInfoWithStatus:ZEString(@"暂无商品分类信息", @"No commodity classification information")];
            
       }else if ([json[@"status"] integerValue] == 9){
           
           [SVProgressHUD showInfoWithStatus:ZEString(@"登录信息过期，请重新登录", @"Login information is outdated, please login again")];
           [ObjectForUser clearLogin];
       }else{
           
           [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败", @"Network connection failed")];
       }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败", @"Network connection failed")];
    }];
        
    }
}


#pragma mark - 增加菜品刷新的方法
- (void)listDetailsRefresh{
    
    [self myDatas];
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
