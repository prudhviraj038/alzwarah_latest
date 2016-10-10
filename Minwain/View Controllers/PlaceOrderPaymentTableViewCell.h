//
//  PlaceOrderPaymentTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 21/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TYPE_CASH,
    TYPE_KENT,
    TYPE_CREDIT_CARDS
} PaymentMode;

@interface PlaceOrderPaymentTableViewCell : AppTableViewCell

@property (nonatomic) PaymentMode paymentMode;
@property (weak, nonatomic) IBOutlet UILabel *labelInfo;

@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property (weak, nonatomic) IBOutlet UILabel *labelCash;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCash;

@property (weak, nonatomic) IBOutlet UILabel *labelKnet;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewKnet;

@property (weak, nonatomic) IBOutlet UILabel *labelCredit;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCredit;

@property (nonatomic, copy) void (^changeOption)(PaymentMode mode);
@end
