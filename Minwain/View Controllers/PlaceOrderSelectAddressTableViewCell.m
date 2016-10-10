//
//  PlaceOrderSelectAddressTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 25/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PlaceOrderSelectAddressTableViewCell.h"

@implementation PlaceOrderSelectAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.labelInfo.layer.cornerRadius = 5;
    self.labelInfo.clipsToBounds = YES;
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];

    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];

    
    
    self.labelAreaText.text = Localized(@"text_area");
    self.labelBlockText.text = Localized(@"text_block");
    self.labelStreetText.text = Localized(@"text_street");
    self.labelBuildingText.text = Localized(@"text_building");
    self.labelFloorText.text = Localized(@"text_floor");
    self.labbelFlatText.text = Localized(@"text_flat");
    self.labelMobileText.text = Localized(@"text_mobile");
    
    [self.labelInfo setTitle:Localized(@"select_address") forState:UIControlStateNormal];
    
    [self.buttonAdd setTitle:Localized(@"edit_address") forState:UIControlStateNormal];
    [self.buttonEdit setTitle:Localized(@"add_address") forState:UIControlStateNormal];
}

- (IBAction)selectAddress:(id)sender {
    if (self.selectAddress) {
        self.selectAddress();
    }
}

- (IBAction)addAddress:(id)sender {
    if (self.addAddress) {
        self.addAddress();
    }
}

- (IBAction)editAddress:(id)sender {
    if (self.editAddress) {
        self.editAddress();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
