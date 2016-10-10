//
//  PlaceOrderFooter.h
//  Minwain
//
//  Created by Amit Kulkarni on 20/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrderFooter : UIView
@property (weak, nonatomic) IBOutlet UILabel *labelSubTotal;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryCharges;
@property (weak, nonatomic) IBOutlet UILabel *labelGrandTotal;

@property (weak, nonatomic) IBOutlet UILabel *labelSubTotalText;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryChargesText;
@property (weak, nonatomic) IBOutlet UILabel *labelGrandTotalText;
@property (weak, nonatomic) IBOutlet UILabel *labelDiscountText;
@property (weak, nonatomic) IBOutlet UILabel *labelDiscount;


@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@end
