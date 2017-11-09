//
//  MerchantDetailTableViewCell.m
//  EatAway商户端
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantDetailTableViewCell.h"


@interface MerchantDetailTableViewCell ()
{
    UIImageView *IVHead;
}
@end

@implementation MerchantDetailTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
        [self addSubview:IVHead];
        
        _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, WINDOWWIDTH - 40 - 30, 30)];
        _labelTitle.font = [UIFont systemFontOfSize:13];
        [self addSubview:_labelTitle];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [self addSubview:viewDown];
    }
    return self;
}
-(void)setContentWithImage:(UIImage *)image title:(NSString *)strTitle
{
    IVHead.image = image;
    _labelTitle.text = strTitle;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
