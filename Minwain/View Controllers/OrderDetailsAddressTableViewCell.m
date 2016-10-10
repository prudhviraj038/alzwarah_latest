//
//  OrderDetailsAddressTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 27/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "OrderDetailsAddressTableViewCell.h"

@implementation OrderDetailsAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.labelInfo.layer.cornerRadius = 5;
    self.labelInfo.clipsToBounds = YES;
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.labelOrderIdText.text = Localized(@"order_id");
    self.labelOrderDateText.text = Localized(@"order_date");
    self.labelAreaText.text = Localized(@"text_area");
    self.labelBlockText.text = Localized(@"text_block");
    self.labelStreetText.text = Localized(@"text_street");
    self.labelBuildingText.text = Localized(@"text_building");
    self.labelFloorText.text = Localized(@"text_floor");
    self.labbelFlatText.text = Localized(@"text_flat");
    self.labelMobileText.text = Localized(@"text_mobile");
    
    [self.labelInfo setTitle:Localized(@"order_details") forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
