//
//  RestaurantTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "RestaurantTableViewCell.h"

@implementation RestaurantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageViewProduct.layer.cornerRadius = 10;
    self.imageViewProduct.clipsToBounds = YES;
    
   // self.labelStatus.transform = CGAffineTransformMakeRotation(50);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
