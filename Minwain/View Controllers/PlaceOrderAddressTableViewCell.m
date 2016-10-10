//
//  PlaceOrderAddressTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 20/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PlaceOrderAddressTableViewCell.h"

@implementation PlaceOrderAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [self sendSubviewToBack:self.viewContainer];
//    [self bringSubviewToFront:self.labelInfo];
    
    self.labelInfo.layer.cornerRadius = 5;
    self.labelInfo.clipsToBounds = YES;
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.labelAreaText.text = Localized(@"text_area");
    self.labelBlock.text = Localized(@"text_block");
    self.labelStreet.text = Localized(@"text_street");
    self.labelBuilding.text = Localized(@"text_building");
    self.labelFloor.text = Localized(@"text_floor");
    self.labbelFlat.text = Localized(@"text_flat");
    //self.labelMobile.text = Localized(@"text_mobile");
    self.labelEmail.text = Localized(@"email_address");
    
    self.editBlock.delegate = self;
    self.editStreet.delegate = self;
    self.editBuilding.delegate = self;
    self.editFloot.delegate = self;
    self.editFlat.delegate = self;
    //self.editMobile.delegate = self;
    self.editEmail.delegate = self;
    
    self.editBlock.placeholder = Localized(@"text_block");
    self.editStreet.placeholder = Localized(@"text_street");
    self.editBuilding.placeholder = Localized(@"text_building");
    self.editFloot.placeholder = Localized(@"text_floor");
    self.editFlat.placeholder = Localized(@"text_flat");
    self.editMobile.placeholder = Localized(@"text_mobile");
    self.editEmail.placeholder = Localized(@"email_address");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (textField == self.editBlock) {
        [defaults setValue:self.editBlock.text forKey:@"block"];
    } else if (textField == self.editStreet) {
        [defaults setValue:self.editStreet.text forKey:@"street"];
    } else if (textField == self.editBuilding) {
        [defaults setValue:self.editBuilding.text forKey:@"building"];
    } else if (textField == self.editFloot) {
        [defaults setValue:self.editFloot.text forKey:@"floor"];
    } else if (textField == self.editFlat) {
        [defaults setValue:self.editFlat.text forKey:@"flat"];
    }/* else if (textField == self.editMobile) {
        [defaults setValue:self.editMobile.text forKey:@"mobile"];
    }*/ else if (textField == self.editEmail) {
        [defaults setValue:self.editEmail.text forKey:@"email"];
    }
    [defaults synchronize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
