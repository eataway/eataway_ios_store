//
//  OrderCommentTableViewCell.h
//  EatAway
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantCommentTableViewCell : UITableViewCell

@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)id delegate;

-(void)setContentWithTitle:(NSString *)strName headImage:(NSString *)strImageURL time:(NSString *)strTime level:(NSString *)strLevel content:(NSString *)strContent images:(NSArray *)arrImages reply:(NSString *)strReply;
-(void)changeBtnLanguage;

@end

@protocol MerchantCommentTableViewCellDelegate <NSObject>

@required
-(void)MerchantReplyIndex:(NSInteger)cellIndex;

@end
