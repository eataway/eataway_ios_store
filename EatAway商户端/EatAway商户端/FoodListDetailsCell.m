//
//  FoodListDetailsCell.m
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/15.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "FoodListDetailsCell.h"
#import "foodListDetailsModel.h"
#import "UIImageView+WebCache.h"

@implementation FoodListDetailsCell
//{
//    
//    UILabel *_titleLab;
//    UIImageView *_imageView;
//}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
//        self.contentView.layer.cornerRadius = 10;
    }
    return self;
}

- (void)createSubViews{
    
     self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = 10;
    [self.contentView addSubview:self.imageView];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentView.frame) - 50, self.contentView.frame.size.width, 50)];
    grayView.backgroundColor = EWColor(1, 1, 1, 0.3);
    grayView.layer.cornerRadius = 10;
    grayView.clipsToBounds = YES;
    [self.contentView addSubview:grayView];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, grayView.frame.size.width, 30)];
    self.titleLab.font = [UIFont systemFontOfSize:15];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.adjustsFontSizeToFitWidth = YES;
    self.titleLab.textColor = [UIColor whiteColor];
    [grayView addSubview:self.titleLab];
    
}

//- (void)setTitle:(NSString *)title{
//    
//    _title = title;
//    _titleLab.text = _title;
//    
//}
//
//- (void)setImaegName:(NSString *)imaegName{
//    
//    _imaegName = imaegName;
//    NSArray *array = [imaegName componentsSeparatedByString:@"."];
//    NSString *path = [[NSBundle mainBundle]pathForResource:array[0] ofType:array[1]];
//    NSData *imageData = [[NSData alloc]initWithContentsOfFile:path];
//    UIImage *image = [[UIImage alloc]initWithData:imageData];
//    _imageView.image = image;
//}

- (void)setDetailsModel:(foodListDetailsModel *)detailsModel{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:detailsModel.goodsphoto] placeholderImage:[UIImage imageNamed:@"3.2.2_pic_bg"]];
    
    self.titleLab.text = [NSString stringWithFormat:@"%@  $%@",detailsModel.goodsname,detailsModel.goodsprice];
    
}
@end
