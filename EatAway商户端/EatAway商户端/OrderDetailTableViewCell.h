//
//  OrderDetailTableViewCell.h
//  EatAway商户端
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableViewCell : UITableViewCell

@property(nonatomic,copy)NSString *strOrderState;
@property(nonatomic,assign)id delegate;

@property(nonatomic,assign)BOOL orderDone;

-(void)setContentWithDictionary:(NSDictionary *)dic;
-(void)changeMainButton;

@end

@protocol OrderDetailTableViewCellDelegate <NSObject>

@required
-(void)orderDetailCellMainButtonClick:(NSString *)strState cellTag:(NSInteger)index;
-(void)orderDetailCellRefundButtonClick:(NSString *)strState cellTag:(NSInteger)index;

@end
