//
//  RestaurantDetailsInfoTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 13/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "RestaurantDetailsInfoTableViewCell.h"

@implementation RestaurantDetailsInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.labelTitle.layer.cornerRadius = 5;
    self.labelTitle.clipsToBounds = YES;
    
    self.labelTitle.text = Localized(@"restaurant_info");
    self.labelAreaText.text = Localized(@"text_area");
    self.labelStatusText.text = Localized(@"text_status");
    self.labelCuisinesText.text = Localized(@"text_cuisines");
    self.labelWorkingHrsText.text = Localized(@"text_working_hours");
    self.labelDeliveryTimeText.text = Localized(@"text_delivery_time");
    self.labelMinOrderText.text = Localized(@"text_min_order");
    self.labelDeliveryChargesText.text = Localized(@"text_delivery_charges");
    self.labelPaymentTypeText.text = Localized(@"text_payment_type");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
