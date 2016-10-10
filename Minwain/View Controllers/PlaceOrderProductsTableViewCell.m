//
//  PlaceOrderProductsTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 20/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PlaceOrderProductsTableViewCell.h"

@implementation PlaceOrderProductsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
