//
//  FoodListDetailsCell.h
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/15.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class foodListDetailsModel;

@interface FoodListDetailsCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imaegName;
@property (nonatomic, strong) foodListDetailsModel *detailsModel;
@property (nonatomic, retain) UILabel *titleLab;
@property (nonatomic, retain) UIImageView *imageView;

@end
