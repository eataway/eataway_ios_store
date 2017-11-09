//
//  editPopupView.m
//  EatAway商户端
//
//  Created by DaLiu on 2017/7/17.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "editPopupView.h"

@implementation editPopupView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        [self setUp];
        self.layer.cornerRadius = 20;
    }
    return self;
}

- (void)setUp{
    
    self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeBtn.frame = CGRectMake(0, 0, self.frame.size.width, 60);
    [self.changeBtn setTitle:ZEString(@"修改名称", @"change name") forState:UIControlStateNormal];
    [self.changeBtn setTitleColor:EWColor(51, 51, 51, 1) forState:UIControlStateNormal];
    [self.changeBtn addTarget:self action:@selector(changeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.changeBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.changeBtn.frame), self.frame.size.width, 1)];
    lineView.backgroundColor = EWColor(240, 240, 240, 1);
    [self addSubview:lineView];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(0, CGRectGetMaxY(lineView.frame), self.frame.size.width, 60);
    [self.deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.deleteBtn setTitle:ZEString(@"删除菜单", @"delete Menu") forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
    
}

- (void)changeClick{
    
    if ([self.editPopupDelegate respondsToSelector:@selector(changeMethod)]) {
        [self.editPopupDelegate changeMethod];
    }
}

- (void)deleteClick{
    
    if ([self.editPopupDelegate respondsToSelector:@selector(deleteMethod)]) {
        [self.editPopupDelegate deleteMethod];
    }
    
}

@end
