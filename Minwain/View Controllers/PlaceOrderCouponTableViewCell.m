//
//  PlaceOrderCouponTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 20/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PlaceOrderCouponTableViewCell.h"

@implementation PlaceOrderCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self sendSubviewToBack:self.viewContainer];
    [self bringSubviewToFront:self.labelInfo];
    
    self.labelInfo.layer.cornerRadius = 5;
    self.labelInfo.clipsToBounds = YES;
    self.labelInfo.text = Localized(@"coupon_code");
    
    self.buttonSubmit.layer.cornerRadius = 10;
    self.buttonSubmit.clipsToBounds = YES;
    [self.buttonSubmit setTitle:Localized(@"submit") forState:UIControlStateNormal];

    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.editCouponCode.placeholder = Localized(@"coupon_code");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addCoupon:(id)sender {
    if (self.applyCoupon) {
        self.applyCoupon(self.editCouponCode.text);
    }
}

@end
