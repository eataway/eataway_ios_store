//
//  LabelCeritificationTableViewCell.m
//  EatAway商户端
//
//  Created by apple on 2017/7/15.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "LabelCeritificationTableViewCell.h"


@interface LabelCeritificationTableViewCell ()
{
    UILabel *labelTitle;
}
@end

@implementation LabelCeritificationTableViewCell

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
        
        CGFloat labelWidth = 70;
        
        labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, labelWidth, 30)];
        labelTitle.font = [UIFont systemFontOfSize:13];
        [self addSubview:labelTitle];
        
        _labelContent = [[UILabel alloc]initWithFrame:CGRectMake(10 + labelWidth + 10, 10, WINDOWWIDTH - (labelWidth + 20 + 50), 30)];
        _labelContent.font = [UIFont systemFontOfSize:13];
        _labelContent.textColor = [UIColor colorWithWhite:200/255.0 alpha:1];
        [self addSubview:_labelContent];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [self addSubview:viewDown];
        
    }
    return self;
}
-(void)setContentWithTitle:(NSString *)strTitle textFieldPlacehoder:(NSString *)strPlacehoder
{
    labelTitle.text = strTitle;
    _labelContent.text = strPlacehoder;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
