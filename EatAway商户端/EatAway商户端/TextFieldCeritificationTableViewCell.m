//
//  TextFieldCeritificationTableViewCell.m
//  EatAway商户端
//
//  Created by apple on 2017/7/15.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "TextFieldCeritificationTableViewCell.h"

@interface TextFieldCeritificationTableViewCell ()
{
    UILabel *labelTitle;
}
@end

@implementation TextFieldCeritificationTableViewCell

- (void)awakeFromNib {
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
        
        _TFContent = [[UITextField alloc]initWithFrame:CGRectMake(10 + labelWidth + 10, 10, WINDOWWIDTH - (labelWidth + 20 + 50), 30)];
        _TFContent.font = [UIFont systemFontOfSize:13];
        [self addSubview:_TFContent];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
        viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [self addSubview:viewDown];
        
    }
    return self;
}
-(void)setContentWithTitle:(NSString *)strTitle textFieldPlacehoder:(NSString *)strPlacehoder
{
    labelTitle.text = strTitle;
    _TFContent.placeholder = strPlacehoder;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
