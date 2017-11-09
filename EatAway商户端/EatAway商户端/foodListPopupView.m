//
//  foodListPopupView.m
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "foodListPopupView.h"

@interface foodListPopupView()<UITextFieldDelegate>

@end

@implementation foodListPopupView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        [self setUp];
        self.layer.cornerRadius = 20;
    }
    return self;
}

- (void)setUp{
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 40)];
    
//        self.titleLab.text = @"新增菜单";
    self.titleLab.textColor = EWColor(51, 51, 51, 1);
//    self.titleLab.font = [UIFont systemFontOfSize:15];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLab];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 60, self.frame.size.width, 1)];
    lineView1.backgroundColor = EWColor(240, 240, 240, 1);
    [self addSubview:lineView1];
    
    self.titleField = [[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(lineView1.frame), self.frame.size.width - 40, 60)];
//    self.titleField.placeholder = @"请输入新增加的菜单";
    self.titleField.delegate = self;
    self.titleField.textAlignment = NSTextAlignmentLeft;
    self.titleField.textColor = EWColor(102, 102, 102, 1);
    [self addSubview:self.titleField];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleField.frame), self.frame.size.width, 1)];
    lineView2.backgroundColor = EWColor(240, 240, 240, 1);
    [self addSubview:lineView2];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(lineView2.frame), self.frame.size.width / 2- 0.5, 60);
    [self.cancelBtn setTitle:ZEString(@"取消", @"Cancel") forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:EWColor(102, 102, 102, 1) forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cancelBtn.frame), CGRectGetMaxY(lineView2.frame), 1, 60)];
    lineView3.backgroundColor = EWColor(240, 240, 240, 1);
    [self addSubview:lineView3];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.frame = CGRectMake(CGRectGetMaxX(lineView3.frame), CGRectGetMaxY(lineView2.frame), self.frame.size.width / 2- 0.5, 60);
    [self.confirmBtn setTitle:ZEString(@"确定", @"OK") forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor colorWithRed:0.08f green:0.51f blue:0.89f alpha:1.00f] forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.confirmBtn];
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
}

- (void)cancelClick{
    
    if ([self.popupDelegate respondsToSelector:@selector(cancelMethod)]) {
        [self.popupDelegate cancelMethod];
    }
}

- (void)confirmClick{
    
    if ([self.popupDelegate respondsToSelector:@selector(confirmMethod)]) {
        [self.popupDelegate confirmMethod];
    }
    
}
@end
