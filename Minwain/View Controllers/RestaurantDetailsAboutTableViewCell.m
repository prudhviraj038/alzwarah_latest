//
//  RestaurantDetailsAboutTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 13/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "RestaurantDetailsAboutTableViewCell.h"

@implementation RestaurantDetailsAboutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.labelAbout.layer.cornerRadius = 5;
    self.labelDescription.layer.cornerRadius = 5;
    
    self.labelAbout.clipsToBounds = YES;
    self.labelDescription.clipsToBounds = YES;
    
    [self.contentView bringSubviewToFront:self.labelAbout];
    
    self.labelDescription.textColor = [UIColor colorWithRed:0.290  green:0.290  blue:0.290 alpha:1];
    self.labelDescription.layer.shadowColor = [[UIColor colorWithRed:0.290  green:0.290  blue:0.290 alpha:1] CGColor];
    self.labelDescription.layer.shadowRadius = 5;
    self.labelDescription.layer.shadowOpacity = 0.55;
    self.labelDescription.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
