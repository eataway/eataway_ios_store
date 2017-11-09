//
//  TextFieldCeritificationTableViewCell.h
//  EatAway商户端
//
//  Created by apple on 2017/7/15.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldCeritificationTableViewCell : UITableViewCell

@property(nonatomic,retain)UITextField *TFContent;

-(void)setContentWithTitle:(NSString *)strTitle textFieldPlacehoder:(NSString *)strPlacehoder;

@end
