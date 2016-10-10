//
//  PlaceOrderPaymentTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 21/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PlaceOrderPaymentTableViewCell.h"

@implementation PlaceOrderPaymentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;

    self.labelInfo.layer.cornerRadius = 5;
    self.labelInfo.clipsToBounds = YES;

    self.imageViewCash.hidden = NO;
    
    self.labelCash.text = Localized(@"payment_cash");
    self.labelCredit.text = Localized(@"payment_credt_cards");
    self.labelKnet.text = Localized(@"payment_knet");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)selectCash:(id)sender {
    self.paymentMode = TYPE_CASH;
    self.imageViewCash.hidden = NO;
    self.imageViewKnet.hidden = YES;
    self.imageViewCredit.hidden = YES;
    
    if (self.changeOption) {
        self.changeOption(TYPE_CASH);
    }
}

- (IBAction)selectKnet:(id)sender {
    self.paymentMode = TYPE_KENT;
    self.imageViewCash.hidden = YES;
    self.imageViewKnet.hidden = NO;
    self.imageViewCredit.hidden = YES;
    
    if (self.changeOption) {
        self.changeOption(TYPE_KENT);
    }
}

- (IBAction)selectCreditCard:(id)sender {
    self.paymentMode = TYPE_CREDIT_CARDS;
    self.imageViewCash.hidden = YES;
    self.imageViewKnet.hidden = YES;
    self.imageViewCredit.hidden = NO;
    
    if (self.changeOption) {
        self.changeOption(TYPE_CREDIT_CARDS);
    }
}

@end
