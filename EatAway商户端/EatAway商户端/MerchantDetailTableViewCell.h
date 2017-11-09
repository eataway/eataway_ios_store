//
//  MerchantDetailTableViewCell.h
//  EatAway商户端
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantDetailTableViewCell : UITableViewCell


@property(nonatomic,retain)UILabel *labelTitle;
-(void)setContentWithImage:(UIImage *)image title:(NSString *)strTitle;


@end
