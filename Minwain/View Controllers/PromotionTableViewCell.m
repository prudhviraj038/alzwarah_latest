//
//  PromotionTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PromotionTableViewCell.h"

@implementation PromotionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.imageViewPromotion.layer.cornerRadius = 0;
//    self.imageViewPromotion.clipsToBounds = YES;
//    
//    self.backgroundColor = [UIColor clearColor];
//    self.contentView.backgroundColor = [UIColor clearColor];
//    
//    self.viewBackground.backgroundColor = [UIColor whiteColor];
//    self.viewBackground.layer.cornerRadius = 5;
//    self.viewBackground.clipsToBounds = YES;
//    self.viewBackground.layer.shadowColor = [[UIColor colorWithRed:0.290  green:0.290  blue:0.290 alpha:1] CGColor];
//    self.viewBackground.layer.shadowRadius = 5;
//    self.viewBackground.layer.shadowOpacity = 0.55;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)facebookTapped:(id)sender {
}

- (IBAction)twitterTapped:(id)sender {
}

- (IBAction)instagramTapped:(id)sender {
}
@end
