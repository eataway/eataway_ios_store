//
//  MerchantInfoTableViewCell.h
//  EatAway
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantInfoTableViewCell : UITableViewCell
@property(nonatomic,retain) UILabel *labelText;

-(void)setContentWithHeadImage:(UIImage *)image text:(NSString *)strText;

@end
