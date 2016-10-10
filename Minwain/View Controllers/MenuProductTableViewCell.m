//
//  MenuProductTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "MenuProductTableViewCell.h"
#import <RateView.h>

@implementation MenuProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.imageViewProduct.layer.cornerRadius = 5;
    self.imageViewProduct.clipsToBounds = YES;
    
    self.container.layer.cornerRadius = 5;
    self.container.clipsToBounds = YES;
    self.container.layer.shadowColor = [[UIColor colorWithRed:0.290  green:0.290  blue:0.290 alpha:1] CGColor];
    self.container.layer.shadowRadius = 5;
    //self.container.layer.shadowOffset = CGSizeMake(5, 5);
    self.container.layer.shadowOpacity = 0.3;
    self.container.backgroundColor = [UIColor whiteColor];
}

- (void)setRating:(float)rating {
    RateView *rv = [RateView rateViewWithRating:rating];
    rv.starSize = 15;
    rv.starFillColor = [UIColor whiteColor];
    rv.starBorderColor = [UIColor whiteColor];
    rv.starFillMode = StarFillModeHorizontal;
    [self.ratingView addSubview:rv];
}

- (void)setQuantity:(int)quantity {
    _quantity = quantity;
    self.labelQuantity.text = [NSString stringWithFormat:@"%d", self.quantity];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)addQuantity:(id)sender {
    _quantity++;
    self.labelQuantity.text = [NSString stringWithFormat:@"%d", self.quantity];
}

- (IBAction)deleteQuantity:(id)sender {
    _quantity--;
    if (_quantity < 0) {
        _quantity = 0;
    } else {
        self.labelQuantity.text = [NSString stringWithFormat:@"%d", self.quantity];
    }
}

@end
