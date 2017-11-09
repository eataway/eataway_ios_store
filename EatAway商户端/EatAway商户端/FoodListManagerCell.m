//
//  FoodListManagerCell.m
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "FoodListManagerCell.h"
#import "foodListManagerModel.h"

@interface FoodListManagerCell()
@property (nonatomic, retain) NSIndexPath *index;

@end

@implementation FoodListManagerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self SetUp];
        self.backgroundColor = EWColor(240, 240, 240, 1);
    }
    return self;
}


- (void)SetUp{
    
//    NSArray * titleArr = @[@"Burgers",@"Fryed",@"Shakes",@"Veg",@"Fish burg"];
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(10, 12, WINDOWWIDTH - 20, 50)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.clipsToBounds = YES;
    whiteView.layer.cornerRadius = 5;
    [self addSubview:whiteView];
    
    self.backColorImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.backColorImg.image = [UIImage imageNamed:@"2.1.0_tag_bg_left"];
    [whiteView addSubview:self.backColorImg];
    
    self.numLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 25, 30)];
    self.numLab.textAlignment = NSTextAlignmentCenter;
    self.numLab.text = @"12";
    self.numLab.textColor = [UIColor whiteColor];
    [whiteView addSubview:self.numLab];
    
    self.foodListLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.numLab.frame) + 10, 10, whiteView.frame.size.width - 60, 30)];
    self.foodListLab.text = @"Burgers";
    self.foodListLab.textColor = EWColor(51, 51, 51, 1);
    self.foodListLab.textAlignment = NSTextAlignmentLeft;
//    self.foodListLab.font = [UIFont systemFontOfSize:15];
    [whiteView addSubview:self.foodListLab];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.frame = CGRectMake(whiteView.frame.size.width - 40, 12.5, 25, 25);
    [self.editBtn setImage:[UIImage imageNamed:@"2.2.4_icon_change"] forState:UIControlStateNormal];
    [self.editBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:self.editBtn];
    
    
    
    
}

//编辑按钮的点击事件
- (void)editClick:(UIButton *) sender{
    
    if ([self.managerDelegate respondsToSelector:@selector(changeClick:)]) {
        [self.managerDelegate changeClick:sender];
    }
    
}

- (void)setListManagerModel:(foodListManagerModel *)listManagerModel{
    
    self.foodListLab.text = listManagerModel.cname;
    self.numLab.text = listManagerModel.num;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
