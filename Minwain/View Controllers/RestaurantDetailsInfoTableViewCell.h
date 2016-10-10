//
//  RestaurantDetailsInfoTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 13/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantDetailsInfoTableViewCell : AppTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelArea;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UILabel *labelCuisines;
@property (weak, nonatomic) IBOutlet UILabel *labelWorkingHrs;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryTime;
@property (weak, nonatomic) IBOutlet UILabel *labelMinOrder;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryCharges;
@property (weak, nonatomic) IBOutlet UILabel *labelPaymentType;
@property (weak, nonatomic) IBOutlet UIView *viewPayment;

@property (weak, nonatomic) IBOutlet UILabel *labelAreaText;
@property (weak, nonatomic) IBOutlet UILabel *labelStatusText;
@property (weak, nonatomic) IBOutlet UILabel *labelCuisinesText;
@property (weak, nonatomic) IBOutlet UILabel *labelWorkingHrsText;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryTimeText;
@property (weak, nonatomic) IBOutlet UILabel *labelMinOrderText;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryChargesText;
@property (weak, nonatomic) IBOutlet UILabel *labelPaymentTypeText;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@end
