//
//  CouponsTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 24/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "CouponsTableViewCell.h"

@implementation CouponsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageViewCoupon.layer.cornerRadius = 5;
    self.imageViewCoupon.clipsToBounds = YES;
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.buttonCopy setTitle:Localized(@"copy_coupon_code") forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)cpopyCode:(id)sender {
    if (self.showAlert) {
        self.showAlert();
    }    
}

@end
