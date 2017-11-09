//
//  ServiceTermsViewController.m
//  EatAway商户端
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "ServiceTermsViewController.h"
#import "ServiceTerms1TableViewCell.h"
#import "ServiceTerms2TableViewCell.h"

@interface ServiceTermsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *detailStr;
}

@property(strong,nonatomic) UITableView *tableView;

@property(strong,nonatomic) NSMutableArray *titleArray;
@property(strong,nonatomic) NSMutableArray *contentArray;

@end

@implementation ServiceTermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"服务协议";
    
    self.titleArray = @[@"1.INFORMATION ABOUT US",@" 2.APPLICATION ACCESS AND TERMS",@" 3.YOUR STATUS",@"4.ORDERS",@"5.MEALS",@"6.PRICE AND PAYMENT",@"7.CUSTOMER CONCERNS",@"8.INTELLECTUAL PROPERTY",@"9.Our Liability",@"10.TERMINATION",@"11.Additional terms"].mutableCopy;
    
    self.contentArray = @[@"EatAway Pty. Ltd. (ACN 619 553 356) is a company registered in South Australia at 35 Grant Avenue, Rose Park, SA 5067. EatAway is a business where the food is prepared by independent restaurants. Eatway provides a way for you to communicate your orders (“Orders”) for products (“Products”) to Partner Restaurants (“Restaurants”, “Partner Restaurants”) displayed on the mobile App (the “Service”).",@"You may access areas of the Application without registering your details or making an order. If you choose to register your details we will provide you with a user name and you will select a password. It is your responsibility to keep your username and password secure and you are responsible for all activity carried out under this username. It is not permitted to register more than one account per user. If you are concerned that your login details may have been compromised or misused you should contact us at contact@eataway.com.au   We can close your account at any time.\n\nAccess to our EatAway Mobile Applications is allowed on a non-permanent basis, we reserve the right to withdraw or change the access to our Mobile applications without notice. We will not be held liable now or in the future if our Service is unavailable for any period of time.",@"By placing an order through our Service, you agree that you are legally capable of entering into binding contracts. Persons wishing to order alcohol or tobacco products from any of our Partner Restaurants must be aged 18 or older. By placing an order for Alcohol or Tobacco products with our Partner Restaurants you are thereby confirming that you are 18 or older. If you make an order for Alcohol or Tobacco products, the restaurant has the right to require you to show ID on delivery. EatAway and/or the Restaurant reserve the right to cancel orders containing Alcohol and/or Tobacco products if the customer is unable to prove they are 18 or older. For clarity, all orders are prepared and delivered by the restaurant, therefore if your order contains Alcohol or Tobacco EatAway is not selling these products to you. EatAway supports the Responsible Service of Alcohol.",@"Making and order: To make an order through our service select the products you would like to order from the menu of your selected Restaurant and provide all required information, you will then be given the option to make your order by clicking “checkout” on the English version and the equivalent translation on the Chinese version. When the order is accepted by the restaurant you will receive a notification that your order is “has been accepted”. The contract for the supply of the meal(s) ordered through our service between you and the Partner Restaurant will be formed once you have received the notification that your order has been accepted. Once the restaurant has accepted your order, the restaurant has sole responsibility for your order. You (the Customer) must resolve any dispute regarding your Order directly with the Restaurant. In some cases EatAway may intervene to resolve the dispute as a gesture of goodwill. We work closely with Partner Restaurants and it is extremely important that they adhere to our standards and help us maintain our reputation. Please contact us via email or telephone if you have any comments relating our Partner Restaurants.\n\nChanging an Order: Once your order has been submitted and accepted by the restaurant you will not be able to change or cancel your order on our mobile Application. If you wish to change or cancel your order it is your responsibility to directly contact the Restaurant or phone our customer support team who will attempt contact the restaurant on your behalf. However there is no guarantee that the Restaurant will agree to change or cancel the order as they may have already started to prepare your order.\n\nRestaurant failure to accept order: Once your order has been received we will process your order and send it to the Restaurant. When your selected restaurant has accepted the order you will receive a notification alerting you that the order “has been received”. You can view how your order is processing at any time through the application. Restaurants have the option to decline orders at any time due to weather conditions, because they are too busy or any other reasons. We strongly encourage all Partner Restaurants to accept all Orders and to communicate directly with the Customer prior to declining any order. In the case that the restaurant does reject your order we will notify you (generally via the APP) as soon as possible.\n\nDelivery of order: Estimations for delivery times are provided by the restaurants and can be viewed on our Application. These delivery times are only estimates and unfortunately sometimes things do not go to plan because factors such as weather, traffic conditions and other unforeseen circumstances may prevent restaurants from achieving their targeted delivery time. Therefore neither EatAway nor the Restaurants can guarantee that the food will be delivered within the estimated time. EatAway is not responsible for any complaints about Restaurants or the products they provide. All orders placed via our service are prepared and delivered by the Restaurant; all food preparation deliveries are the sole responsibility of the restaurant accepting the order. To the full extent permitted by Australian law, EatAway accepts no liability in the food preparation and delivery undertaken by the Restaurant accepting the order.",@"Restaurants can update available meals in real time. Sometimes the meal you selected may not be currently available, in this case your Partner Restaurant may offer to provide you with an alternative meal. If you have an allergy please call the Restaurant prior to ordering. EatAway cannot guarantee that the meals sold by Partner Restaurants are free of nuts and other allergens.",@"Price: The price of all Meals will be listed on our Service. Prices may change at any time. EatAway may offer discounts from time to time on certain menu items in collaboration with selected restaurants. Furthermore, restaurants may update prices at any time. All prices shown on our Service are the latest prices, and any changes to these prices will not affect orders that you have already made.\n\nPayment: Payments for all Meals can be through Alipay, Wechat Pay, Apple Pay and all major credit and debit cards. Once you have confirmed your order your selected payment method will have been authorised and the amount will be marked for payment. All payments are made directly to EatAway and are later transferred by EatAway to the Partner Restaurant. EatAway is authorised by our Partner Restaurant to receive payments for meals on their behalf, therefore payment for the price of any meal to us will remove any obligations you have to make a payment directly to the Restaurant.\n\nDeclined Orders and Refunds: Once you have confirmed an order that you are paying for via one of our Payment methods (listed above under Payment) you will be charged the full amount for your Order. If the Restaurant cannot accept your order for any reason you will be refunded the full amount to your chosen Payment Method (Alipay account, WeChat Account, or the bank of your selected card issuer). Refunds will usually take 2-5 business days, however may take longer depending on your bank or card issuer. Neither the restaurant nor we are responsible for any delays in refunds caused by your bank or card issuer.",@"Our customers are extremely important to us and we will make every effort to assist you where possible. You can contact our Customer Support at any time by emailing us at contact@eataway.com.au or alternatively calling us on the Phone Number found under the “About Us” on both the Mobile Application and on our Website.\n\nQueries about your order: Is your order taking longer than expected? Or do you have any other problems with your order? Please firstly contact the restaurant directly, if you are unable to contact the restaurant and/or are unable to resolve the problem please don’t hesitate to contact our Customer Support (details above).\n\nRestaurant Feedback or Complaints: On receiving your order we encourage you to leave feedback in the form of a rating, a comment and/or a photo on your mobile application. Once the order has been completed (payed for and delivered) you will be given the option to leave feedback for that restaurant. All feedback made by EatAway customers is publically available on our Application for each Restaurant under “Reviews”. We highly value customer feedback and monitor Partner Restaurant reviews carefully in order to maintain our standards.",@"All user interfaces, photographs, trademarks, graphics, artwork and menu translations including the layout, design and expression of the content contained on the EatAway Mobile Applications and Website are owned, controlled or licensed to EatAway, and are protected by trademark, copyright and patent laws. No material from our Service may be reproduced in any way, including but not limited too republishing, translating, publically displaying or distributed to any other commercial enterprise without our (EatAway) prior written consent. By sending and/or posting material to EatAway, including comments, ratings and photos, you grant EatAway ownership of this intellectual property and the right to use it in anyway EatAway considers reasonable, to the full extent permitted by Australian law.",@"Under the Australian Consumer Law, under no circumstances will EatAway be liable to you for any losses or damage, whether in contract, tort, breach of statutory duty or otherwise, even foreseeable damages arising from the use of the service including any loss of damage (including any indirect or consequential loss of revenue or profits, loss of business opportunity, loss or corruption of data) arising from or in connection to our Service. EatAway is an authorised re-seller of Partner Restaurants, all first-level customer services will be handled by the Partner Restaurant (including delivery), EatAway may choose to offer additional customer support and dispute resolution on a case to case basis.\n\nFor Services involving Partner Restaurants you may be bound by additional terms and conditions imposed by the Restaurant. EatAway will consistently do its best to update and communicate additional terms with you, but will not be liable for any complaints about the Restaurants or products provided by the Restaurants, nor disputes between you and the Partner Restaurant.\n\nYou agree to indemnify EatAway and all applicable affiliates, employees and directors against liability against any demands, proceedings, losses and damages of every kind of nature, known and unknown, including legal fees on the indemnity basis, made by any third party or resulting from your breach of these Terms and Conditions and policies it incorporates by reference, or your violation of any law or the rights of a third party.",@"We may revoke or suspend your right to use the Service immediately by notifying you via written mail or email if we believe that you have breached our terms and conditions.",@"No waiver: no failure or delay by you or us to exercise any provision of these terms shall constitute a waiver of your or our rights or remedies.\n\nSeverability: If any Terms become illegal, unlawful or unenforceable it shall be modified to the minimum extent necessary to make it valid, legal and enforceable. Any modification and or deletion of a provision or part-provision will not affect the remaining terms, conditions and provisions that will continue to be valid to the fullest extend permitted by law.\n\nThese Terms and Conditions shall be governed in accordance with the laws of the State of South Australia and the Commonwealth of Australia. If you access our Website or Mobile Applications from outside Australia, you do so knowing that you are responsible for ensuring compliance with all laws in the place that you are located."].mutableCopy;
    
    
    detailStr = @"Welcome to EatAway.com.au and our applications (our “Service”). This page informs you of the terms and conditions on which we, EatAway Pty Ltd (ACN 619 553 356) (“we”, “our” or “EatAway”) provide our services on any EatAway mobile application through which you access our services. Please take care to read these terms and conditions thoroughly before ordering any meals from any EatAway mobile application (“App”). By ordering products via our service you agree to be bound by these Terms and Conditions. We may change these terms at any time, therefore you should check the website regularly to review updated terms and conditions.";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = 0;
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceTerms1TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ServiceTerms1TableViewCell_Identify];
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceTerms2TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ServiceTerms2TableViewCell_Identify];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        CGSize height = [self sizeOfString:detailStr];
        
        return 91+height.height;
    }
    else{
        CGSize title = [self sizeOfTitleString:self.titleArray[indexPath.section - 1]];
        CGSize detail = [self sizeOfString:self.contentArray[indexPath.section - 1]];
        return title.height + detail.height + 16;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titleArray.count + 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        ServiceTerms1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ServiceTerms1TableViewCell_Identify];
        cell.selectionStyle = 0;
        
        cell.detailLabel.text = detailStr;
        
        return cell;
    }
    else{
        
        ServiceTerms2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ServiceTerms2TableViewCell_Identify];
        
        cell.titleLabel.text = self.titleArray[indexPath.section - 1];
        cell.detailLabel.text = self.contentArray[indexPath.section - 1];
        
        cell.selectionStyle = 0;
        
        return cell;
    }
}

-(CGSize)sizeOfString:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(WINDOWWIDTH - 16, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return labelSize;
}

-(CGSize)sizeOfTitleString:(NSString *)str{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:21], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(WINDOWWIDTH - 16, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return labelSize;
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
