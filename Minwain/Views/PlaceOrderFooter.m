//
//  PlaceOrderFooter.m
//  Minwain
//
//  Created by Amit Kulkarni on 20/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PlaceOrderFooter.h"

@implementation PlaceOrderFooter

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    
    self.labelSubTotalText.text = Localized(@"sub_total");
    self.labelDeliveryChargesText.text = Localized(@"text_delivery_charges");
    self.labelGrandTotalText.text = Localized(@"grand_total");
    self.labelDiscountText.text = Localized(@"discount");
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
}

@end
