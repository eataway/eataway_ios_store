//
//  FoodListDetailsController.m
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "FoodListDetailsController.h"
#import "AddFoodTypeController.h"
#import "FoodListDetailsCell.h"
#import "DishesDetailsController.h"
#import "foodListDetailsModel.h"
#import "LoginWithPhoneViewController.h"
#import <MBProgressHUD.h>

@interface FoodListDetailsController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,dishesDetailsDelegate,addFoodTypeDelegate>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UIButton *deleteBtn;
@property (nonatomic, retain) UIButton *addBtn;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) foodListDetailsModel *listDetailsModel;

@end

@implementation FoodListDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.view.backgroundColor = EWColor(240, 240, 240, 1);
    [self createCollectionView];
    [self createBottomView];
    [self myDatas];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)createCollectionView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 79, WINDOWWIDTH, WINDOWHEIGHT - 129) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = EWColor(240, 240, 240, 1);
    self.collectionView.layer.cornerRadius = 5;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[FoodListDetailsCell class] forCellWithReuseIdentifier:@"FoodListDetailsCell"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"FoodListDetailsCell";
    FoodListDetailsCell *listDetailsCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //设置显示文字
    listDetailsCell.title = [NSString stringWithFormat:@"第%ld个",indexPath.item];
    listDetailsCell.imaegName = _dataArray[indexPath.item];
    listDetailsCell.detailsModel = self.dataArray[indexPath.row];
    return listDetailsCell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(WINDOWWIDTH / 2 - 18.5, WINDOWWIDTH / 2 - 18.5);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 12, 0, 12);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 15;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DishesDetailsController *dishesVC = [[DishesDetailsController alloc]init];
    dishesVC.detailsDelegate = self;
    foodListDetailsModel *model = self.dataArray[indexPath.row];
    dishesVC.deleteIndex = indexPath;
    dishesVC.cid = [model.cid integerValue];
    dishesVC.goodsId = [model.goodsid integerValue];
    dishesVC.judge = [model.flag integerValue];
    dishesVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dishesVC animated:YES];
    
    
}
- (void)createBottomView{
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, WINDOWHEIGHT - 50, WINDOWWIDTH, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(WINDOWWIDTH/2-40, 0, 80, 50);
    [self.addBtn setTitle:ZEString(@"添加菜品", @"New dish") forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor colorWithRed:0.04f green:0.47f blue:0.87f alpha:1.00f] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.addBtn];
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn.frame = CGRectMake(CGRectGetMaxX(self.addBtn.frame) - 80- 20 - 10, 15, 20, 20);
    [imageBtn setImage:[UIImage imageNamed:@"3.2.0_tabbar_add"] forState:UIControlStateNormal];
    [bottomView addSubview:imageBtn];
    
}

- (void)addClick{
    
    AddFoodTypeController *addVC = [[AddFoodTypeController alloc]init];
    addVC.addDelegate = self;
    addVC.cidClass = self.cid;
    addVC.vcClass = 1;
    [self.navigationController pushViewController:addVC animated:YES];
    
}

#pragma mark - 添加菜品刷新的点击事件
- (void)addRefresh{
    
    [self myDatas];
}

#pragma mark - 删除菜品刷新的点击事件
- (void)refresh{
    
    [self myDatas];
}

- (void)listDetailsRefresh{
    
    [self.detailsDelegate respondsToSelector:@selector(listDetailsRefresh)];
    [self.detailsDelegate listDetailsRefresh];
}
- (void)myDatas{
    
    self.dataArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *cidStr = [NSString stringWithFormat:@"%ld",self.cid];
    params[@"cid"] = cidStr;
    params[@"shopid"] = USERID;
    params[@"token"] = TOKEN;
    if (USERID == nil || TOKEN == nil) {
        LoginWithPhoneViewController *loginVC = [[LoginWithPhoneViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else{
        
    [HWHttpTool post:Server_Menugoods params:params success:^(id json) {
        
        if ([json[@"status"] integerValue] == 1) {
            self.dataArray = [foodListDetailsModel arrayOfModelsFromDictionaries:json[@"msg"] error:nil];
            [self listDetailsRefresh];
            
        }else if([json[@"status"] integerValue] == 0){
            
            [SVProgressHUD showInfoWithStatus:ZEString(@"获取商品列表失败", @"Failed to get the list of items")];
        }else if ([json[@"status"] integerValue] == 9){
            
            [SVProgressHUD showInfoWithStatus:ZEString(@"登录信息过期，请重新登录", @"Login information is outdated, please login again")];
            [ObjectForUser clearLogin];
        }else{
            
            [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败,请检查呢网络", @"Network connection failed, please check the network")];
        }
            [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:ZEString(@"网络连接失败,请检查呢网络", @"Network connection failed, please check the network")];
    }];
        
    }
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
