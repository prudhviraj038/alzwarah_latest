//
//  PromotionUITableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 15/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PromotionUITableViewCell.h"

@implementation PromotionUITableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageViewRest.layer.cornerRadius = 10;
    self.imageViewRest.clipsToBounds = YES;

    self.imageViewOffer.layer.cornerRadius = 10;
    self.imageViewOffer.clipsToBounds = YES;

    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.labelTitle.textAlignment = NSTextAlignmentRight;
        self.labelCategories.textAlignment = NSTextAlignmentRight;
    } else if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        self.labelTitle.textAlignment = NSTextAlignmentLeft;
        self.labelCategories.textAlignment = NSTextAlignmentLeft;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
