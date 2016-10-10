//
//  PaymentOption.m
//  Minwain
//
//  Created by Amit Kulkarni on 27/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PaymentOption.h"

@implementation PaymentOption

- (IBAction)selectOption:(id)sender {
    if (self.isSelected) {
        self.isSelected = NO;
        self.imageViewWhite.hidden = YES;
    } else {
        self.isSelected = YES;
        self.imageViewWhite.hidden = NO;
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    if (isSelected) {
        self.imageViewWhite.hidden = NO;
    } else {
        self.imageViewWhite.hidden = YES;
    }
    
    if (self.changeStatus) {
        self.changeStatus(isSelected);
    }
}

@end
