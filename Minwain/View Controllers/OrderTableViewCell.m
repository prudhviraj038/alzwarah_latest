//
//  OrderTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 26/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.buttonRate setTitle:Localized(@"rate_order") forState:UIControlStateNormal];
    self.imageViewOrder.layer.cornerRadius = 10;
    self.imageViewOrder.clipsToBounds = YES;
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)rateOrder:(id)sender {
    if (self.rateOrderTapped) {
        self.rateOrderTapped();
    }
}

@end
