//
//  FoodListManagerCell.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class foodListManagerModel;

@protocol foodListManagerDelegate <NSObject>

- (void)changeClick:(UIButton *)sender;

@end
@interface FoodListManagerCell : UITableViewCell

@property (nonatomic, retain) UILabel *foodListLab;
@property (nonatomic, retain) UIImageView *backColorImg;
@property (nonatomic, retain) UILabel *numLab;
@property (nonatomic, retain) UIButton *editBtn;
@property (nonatomic, strong) foodListManagerModel *listManagerModel;
@property (nonatomic, assign) id<foodListManagerDelegate>managerDelegate;

@end
