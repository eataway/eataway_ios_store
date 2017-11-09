//
//  LabelCeritificationTableViewCell.h
//  EatAway商户端
//
//  Created by apple on 2017/7/15.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelCeritificationTableViewCell : UITableViewCell

@property(nonatomic,retain)UILabel *labelContent;

-(void)setContentWithTitle:(NSString *)strTitle textFieldPlacehoder:(NSString *)strPlacehoder;

@end
