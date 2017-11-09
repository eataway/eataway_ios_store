//
//  ServiceTerms2TableViewCell.h
//  EatAway商户端
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ServiceTerms2TableViewCell_Identify @"ServiceTerms2TableViewCell_Identify"
@interface ServiceTerms2TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
