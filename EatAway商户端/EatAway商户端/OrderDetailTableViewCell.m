//
//  OrderDetailTableViewCell.m
//  EatAway商户端
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

@interface OrderDetailTableViewCell ()
{
    UIView *viewWhite;
    UILabel *labelTodayNum;
    UIView *viewFoods;
    UIView *viewDown1;
    UILabel *labelOrderNum;
    UILabel *labelName;
    
    UILabel *labelOrderTime;
    UILabel *labelOrderTime2;
    
    UILabel *labelDeliveryTime;
    UILabel *labelDeliveryTime2;
    
    UILabel *labelTips;
    
    UIView *viewDown2;

    UIImageView *IVLocation;
    UILabel *labelDeliveryAddress;
    UILabel *labelDistance;
    
    
    UIImageView *IVPhoneNum;
    UILabel *labelPhoneNum;
    UILabel *labelDeliveryFee;
    
    UIView *viewDown3;
    
    UILabel *labelTotalPrice;
    UIButton *btnRefund;
    UIButton *btnMain;
    
    UILabel *orderStateLab;
    
}
@end

@implementation OrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        
        viewWhite = [[UIView alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 20, 400)];
        viewWhite.backgroundColor = [UIColor whiteColor];
        viewWhite.clipsToBounds = YES;
        viewWhite.layer.cornerRadius = 7;
        [self addSubview:viewWhite];
        
        UIImageView *IVZuoshang = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        IVZuoshang.image = [UIImage imageNamed:@"2.1.0_tag_bg_left.png"];
        [viewWhite addSubview:IVZuoshang];
        
        
        viewFoods = [[UIView alloc]initWithFrame:CGRectMake(0, 50, WINDOWWIDTH - 20, 10)];
        [viewWhite addSubview:viewFoods];
        
        labelTodayNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        labelTodayNum.textAlignment = NSTextAlignmentCenter;
        labelTodayNum.font = [UIFont systemFontOfSize:8];
        labelTodayNum.textColor = [UIColor whiteColor];
        [viewWhite addSubview:labelTodayNum];
        
        viewDown1 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, WINDOWWIDTH - 20, 1)];
        viewDown1.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [viewWhite addSubview:viewDown1];
        
        labelOrderNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 + 10, WINDOWWIDTH - 20 - 10 - 100, 30)];
        labelOrderNum.font = [UIFont systemFontOfSize:13];
        labelOrderNum.textColor = [UIColor colorWithWhite:160/255.0 alpha:1];
        [viewWhite addSubview:labelOrderNum];
        
        labelName = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 20 - 100, 50 + 10, 90, 30)];
        labelName.font = [UIFont systemFontOfSize:13];
        labelName.textColor = [UIColor colorWithWhite:160/255.0 alpha:1];
        labelName.textAlignment = NSTextAlignmentRight;
        [viewWhite addSubview:labelName];
        
        labelOrderTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 + 10, WINDOWWIDTH - 20 - 10 - 100, 30)];
        labelOrderTime.font = [UIFont systemFontOfSize:13];
        labelOrderTime.textColor = [UIColor colorWithWhite:160/255.0 alpha:1];
        labelOrderTime.text = ZEString(@"下单时间", @"Order time");
        [viewWhite addSubview:labelOrderTime];
        
        labelOrderTime2 = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 20 - 100, 50 + 10, 90, 30)];
        labelOrderTime2.font = [UIFont systemFontOfSize:13];
        labelOrderTime2.textColor = [UIColor colorWithWhite:160/255.0 alpha:1];
        labelOrderTime2.textAlignment = NSTextAlignmentRight;
        [viewWhite addSubview:labelOrderTime2];
        
        labelDeliveryTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 + 10, WINDOWWIDTH - 20 - 10 - 100, 30)];
        labelDeliveryTime.font = [UIFont systemFontOfSize:13];
        labelDeliveryTime.textColor = [UIColor colorWithWhite:160/255.0 alpha:1];
        labelDeliveryTime.text = ZEString(@"送达时间", @"Delivery time");
        [viewWhite addSubview:labelDeliveryTime];
        
        labelDeliveryTime2 = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 20 - 100, 50 + 10, 90, 30)];
        labelDeliveryTime2.font = [UIFont systemFontOfSize:13];
        labelDeliveryTime2.textColor = [UIColor colorWithWhite:160/255.0 alpha:1];
        labelDeliveryTime2.textAlignment = NSTextAlignmentRight;
        [viewWhite addSubview:labelDeliveryTime2];
        
        
        labelTips = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 + 10, 90, 30)];
        labelTips.font = [UIFont systemFontOfSize:13];
        labelTips.textColor = [UIColor colorWithWhite:160/255.0 alpha:1];
        labelTips.numberOfLines = MAXFLOAT;
        [viewWhite addSubview:labelTips];
        
        viewDown2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, WINDOWWIDTH - 20, 1)];
        viewDown2.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [viewWhite addSubview:viewDown2];
        
        
        
        IVLocation = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"5.2.0_icon_01.png"]];
        [viewWhite addSubview:IVLocation];
        
        
        labelDeliveryAddress = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 + 10, WINDOWWIDTH - 20 - 10 - 100, 32)];
        labelDeliveryAddress.font = [UIFont systemFontOfSize:13];
        labelDeliveryAddress.textColor = [UIColor blackColor];
        labelDeliveryAddress.numberOfLines = 2;
        [viewWhite addSubview:labelDeliveryAddress];
        
        labelDistance = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 20 - 100, 50 + 10, 90, 30)];
        labelDistance.font = [UIFont systemFontOfSize:13];
        labelDistance.textColor = [UIColor orangeColor];
        labelDistance.textAlignment = NSTextAlignmentRight;
        [viewWhite addSubview:labelDistance];

        
    
        
        IVPhoneNum = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"5.2.0_icon_02.png"]];
        [viewWhite addSubview:IVPhoneNum];
        
        
        labelPhoneNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 50 + 10, WINDOWWIDTH - 20 - 10 - 100, 30)];
        labelPhoneNum.font = [UIFont systemFontOfSize:13];
        labelPhoneNum.textColor = [UIColor blackColor];
        [viewWhite addSubview:labelPhoneNum];
        
        labelDeliveryFee = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 20 - 100, 50 + 10, 90, 30)];
        labelDeliveryFee.font = [UIFont systemFontOfSize:13];
        labelDeliveryFee.textColor = [UIColor blackColor];
        labelDeliveryFee.textAlignment = NSTextAlignmentRight;
        [viewWhite addSubview:labelDeliveryFee];
        
        
        viewDown3 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, WINDOWWIDTH - 20, 1)];
        viewDown3.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        [viewWhite addSubview:viewDown3];
        
        
        labelTotalPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, WINDOWWIDTH - 40, 50)];
        labelTotalPrice.textColor = [UIColor orangeColor];
        labelTotalPrice.font = [UIFont systemFontOfSize:13];
        labelTotalPrice.textAlignment = NSTextAlignmentRight;
        [viewWhite addSubview:labelTotalPrice];
        
        
        btnRefund = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRefund.titleLabel.font = [UIFont systemFontOfSize:13];
        [btnRefund setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        btnRefund.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnRefund addTarget:self action:@selector(btnRefundClick) forControlEvents:UIControlEventTouchUpInside];
        [viewWhite addSubview:btnRefund];
        NSString *textStr = ZEString(@"申请退款", @"Apply to refund");
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:MAINCOLOR};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
        [btnRefund setAttributedTitle:attribtStr forState:UIControlStateNormal];
        
        btnMain = [UIButton buttonWithType:UIButtonTypeCustom];
        btnMain.backgroundColor = [UIColor orangeColor];
        btnMain.clipsToBounds = YES;
        btnMain.titleLabel.font = [UIFont systemFontOfSize:13];
        btnMain.layer.cornerRadius = 5;
        [btnMain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnMain addTarget:self action:@selector(btnMainClick) forControlEvents:UIControlEventTouchUpInside];
        [viewWhite addSubview:btnMain];
        
        
        
    }
    return self;
}
-(void)setContentWithDictionary:(NSDictionary *)dic;
{
    labelTodayNum.text = dic[@"todaynums"];
    
    for (UIView *aView in viewFoods.subviews)
    {
        [aView removeFromSuperview];
    }
    CGFloat labelx = 10;
//    NSArray *arrGoods 
    NSString *strGoods = dic[@"goodsinfo"];
    NSArray *arrGood = [strGoods componentsSeparatedByString:@"|"];
    NSMutableArray *arrGoodsMut = [[NSMutableArray alloc]initWithArray:arrGood];
    if ([arrGoodsMut containsObject:@""])
    {
        [arrGoodsMut removeObject:@""];
    }
    
    
    
    for (int a = 0; a < arrGoodsMut.count ; a ++)
    {
        NSString *strThisGoods = arrGoodsMut[a];
        NSArray *arrThisGoods = [strThisGoods componentsSeparatedByString:@","];
        
        
        UILabel *labelFoodName = [[UILabel alloc]initWithFrame:CGRectMake(20, labelx, WINDOWWIDTH - 10 - 10 - 20 - 100, 29)];
        labelFoodName.font = [UIFont systemFontOfSize:13];
        labelFoodName.text = arrThisGoods[1];
        [viewFoods addSubview:labelFoodName];
        
        UILabel *labelFoodCount = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 10 - 100, labelx, 90, 29)];
        labelFoodCount.text = [NSString stringWithFormat:@"x%@   $%@",arrThisGoods[4],arrThisGoods[2]];
        labelFoodCount.font = [UIFont systemFontOfSize:13];
        labelFoodCount.textColor = [UIColor orangeColor];
        labelFoodCount.textAlignment = NSTextAlignmentRight;
        [viewFoods addSubview:labelFoodCount];
        labelx = labelx + 30;
        
    }
    labelx = labelx + 10;
    viewFoods.frame = CGRectMake(0, 0, WINDOWWIDTH - 20, labelx);
    viewDown1.frame = CGRectMake(0, labelx - 1, WINDOWWIDTH - 20, 1);

    labelx = labelx + 10;
    
    labelOrderNum.frame = CGRectMake(10, labelx, WINDOWWIDTH - 20 - 10 - 100, 30);
    labelOrderNum.text = [NSString stringWithFormat:@"%@:%@",ZEString(@"订单号", @"Order number"),dic[@"orderid"]];
    
    if (ISCHINESE)
    {
        NSString *str = [dic[@"sex"] isEqualToString:@"1"]?@"先生":@"女士";
        labelName.text = [NSString stringWithFormat:@"%@%@",dic[@"name"],str];
    }
    else
    {
        NSString *str = [dic[@"sex"] isEqualToString:@"1"]?@"Mr.":@"Ms.";
        labelName.text = [NSString stringWithFormat:@"%@ %@",str,dic[@"name"]];
    }
    labelName.frame = CGRectMake(WINDOWWIDTH - 20 - 100, labelx, 90, 30);
    labelx = labelx + 30;
    
    
    NSString *strOrderTime = dic[@"addtime"];
    NSArray *arrTimes = [strOrderTime componentsSeparatedByString:@" "];
    labelOrderTime2.text = [arrTimes lastObject];
    labelOrderTime.frame = CGRectMake(10, labelx, WINDOWWIDTH - 20 - 10 - 100, 30);
    labelOrderTime2.frame = CGRectMake(WINDOWWIDTH - 20 - 100,  labelx , 90, 30);
    labelx = labelx + 30;

    
    
    labelDeliveryTime2.text = dic[@"cometime"];
    if ([labelDeliveryTime2.text containsString:@"上午"] && !ISCHINESE)
    {
        NSString *str = [[NSString alloc]initWithString:labelDeliveryTime2.text];
        [str stringByReplacingOccurrencesOfString:@"上午" withString:@"AM"];
        labelDeliveryTime2.text = str;
    }
    else if ([labelDeliveryTime2.text containsString:@"下午"] && !ISCHINESE)
    {
        NSString *str = [[NSString alloc]initWithString:labelDeliveryTime2.text];
        [str stringByReplacingOccurrencesOfString:@"下午" withString:@"PM"];
        labelDeliveryTime2.text = str;
    }    
    labelDeliveryTime.frame = CGRectMake(10, labelx, WINDOWWIDTH - 20 - 10 - 100, 30);
    labelDeliveryTime2.frame = CGRectMake(WINDOWWIDTH - 20 - 100,  labelx , 90, 30);
    labelx = labelx + 30;

    
    
    NSString *strAllTips = [NSString stringWithFormat:@"%@:%@",ZEString(@"口味备注", @"Remarks"),dic[@"beizhu"]];
    NSMutableAttributedString *MAStr = [[NSMutableAttributedString alloc]initWithString:strAllTips];
    NSRange strRange = [strAllTips rangeOfString:dic[@"beizhu"]];
    [MAStr addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:strRange];
    labelTips.attributedText = MAStr;
    CGSize labelTipsSize = [self sizeOfString:strAllTips fontSize:13];
    labelTips.frame = CGRectMake(10, labelx , WINDOWWIDTH - 20 - 20, labelTipsSize.height < 30?30:labelTipsSize.height);
    labelx = labelx + (labelTipsSize.height < 30?30:labelTipsSize.height);

    labelx = labelx + 10;

    viewDown2.frame = CGRectMake(0, labelx - 1, WINDOWWIDTH - 20, 1);
    
    labelx = labelx + 10;
    
    
    IVLocation.frame = CGRectMake(10, labelx + 5, 20, 20);
    labelDeliveryAddress.text = dic[@"address"];
    labelDeliveryAddress.frame = CGRectMake(10 + 20 + 10, labelx,  WINDOWWIDTH - 20 - 10 - 100, 32);
    labelDistance.text = [NSString stringWithFormat:@"%@km",dic[@"juli"]];
    labelDistance.frame = CGRectMake(WINDOWWIDTH - 20 - 100, labelx, 90, 30);
    labelx = labelx + 30;
    
    IVPhoneNum.frame = CGRectMake(10 , labelx + 5, 20 , 20);
    labelPhoneNum.text = dic[@"phone"];
    labelPhoneNum.frame = CGRectMake(10 + 20 + 10, labelx,  WINDOWWIDTH - 20 - 10 - 100, 30);
    NSString *strDeliveryFeeTotal = [NSString stringWithFormat:@"%@:$%@",ZEString(@"配送费", @"Delivery fee"),dic[@"money"]];
    NSMutableAttributedString *MAStr2 = [[NSMutableAttributedString alloc]initWithString:strDeliveryFeeTotal];
    NSRange strRange2 = [strDeliveryFeeTotal rangeOfString:[NSString stringWithFormat:@"$%@",dic[@"money"]]];
    [MAStr2 addAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:strRange2];
    labelDeliveryFee.attributedText = MAStr2;
    labelDeliveryFee.frame = CGRectMake(WINDOWWIDTH - 20 - 200, labelx, 190, 30);
    labelx = labelx + 30;
    
    labelx = labelx + 10;
    
    viewDown3.frame = CGRectMake(0, labelx - 1, WINDOWWIDTH - 20, 1);
    
    labelx = labelx + 10;
    
    labelTotalPrice.text = [NSString stringWithFormat:@"%@:$%@",ZEString(@"总价", @"Total"),dic[@"allprice"]];
    labelTotalPrice.frame = CGRectMake(10, labelx, WINDOWWIDTH - 40, 30);
    labelx = labelx + 30;

    if (self.orderDone)
    {
        btnMain.hidden = YES;
        btnRefund.hidden = YES;
        
        orderStateLab.frame = CGRectMake(10, labelx , WINDOWWIDTH - 40, 30);
        if ([dic[@"statu"] integerValue] == 1) {
            orderStateLab.text = ZEString(@"退单中", @"Refunding");
        }else if ([dic[@"statu"]integerValue] == 2){
            
            orderStateLab.text = ZEString(@"正常", @"Completed");
        }else{
            
            orderStateLab.text = ZEString(@"已退单", @"Refunded");
        }
        labelx = labelx + 30;
    }
    else
    {
        labelx = labelx + 10;
        
        btnRefund.frame = CGRectMake(10, labelx, 150 , 30);
        btnRefund.hidden = NO;
        
        btnMain.frame = CGRectMake(WINDOWWIDTH - 20 - 10 - 80, labelx , 80, 30);
        btnMain.hidden = NO;
        
        self.strOrderState = dic[@"state"];
        [self changeMainButton];
        labelx = labelx + 30;

    }
    
    
    viewWhite.frame = CGRectMake(10, 10, WINDOWWIDTH - 20,labelx + 10 );
    
    self.frame = CGRectMake(0, 0, WINDOWWIDTH, labelx + 20);
    
    
}

-(void)changeMainButton
{
    if ([self.strOrderState isEqualToString:@"1"])
    {
        [btnMain setTitle:ZEString(@"接单", @"Receive") forState:UIControlStateNormal];
        btnMain.hidden = NO;
    }
    else if([self.strOrderState isEqualToString:@"2"])
    {
        [btnMain setTitle:ZEString(@"送达", @"delivered") forState:UIControlStateNormal];
        btnMain.hidden = NO;
    }
    else
    {
        btnMain.hidden = YES;
    }
}
-(void)btnRefundClick
{
    [self.delegate orderDetailCellRefundButtonClick:self.strOrderState cellTag:self.tag];
}
-(void)btnMainClick
{
    [self.delegate orderDetailCellMainButtonClick:self.strOrderState cellTag:self.tag];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(CGSize)sizeOfString:(NSString *)string fontSize:(NSInteger)fontSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(WINDOWWIDTH - 40,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelSize;
}
@end
