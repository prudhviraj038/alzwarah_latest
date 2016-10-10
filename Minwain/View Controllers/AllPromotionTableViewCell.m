//
//  AllPromotionTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 21/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "AllPromotionTableViewCell.h"

@implementation AllPromotionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.layer.borderColor = [[UIColor colorWithRed:0.931  green:0.706  blue:0.108 alpha:1] CGColor];
    self.viewContainer.layer.borderWidth = 1;
    
    self.imageViewRestaurant.layer.cornerRadius = 5;
    self.imageViewRestaurant.clipsToBounds = YES;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.labelTtitle.textAlignment = NSTextAlignmentRight;
        self.labelDescription.textAlignment = NSTextAlignmentRight;
        self.labelPrice.textAlignment = NSTextAlignmentRight;
    } else {
        self.labelTtitle.textAlignment = NSTextAlignmentLeft;
        self.labelDescription.textAlignment = NSTextAlignmentLeft;
        self.labelPrice.textAlignment = NSTextAlignmentLeft;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
