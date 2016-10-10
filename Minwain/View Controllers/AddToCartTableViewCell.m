//
//  AddToCartTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "AddToCartTableViewCell.h"

@implementation AddToCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)addQuantity:(id)sender {
    _quantity++;
    self.labelQuantity.text = [NSString stringWithFormat:@"%d", self.quantity];
}

- (IBAction)removeQuantity:(id)sender {
    _quantity--;
    if (_quantity < 0) {
        _quantity = 0;
    } else {
        self.labelQuantity.text = [NSString stringWithFormat:@"%d", self.quantity];
    }
}

- (IBAction)addToCart:(id)sender {
    if (self.addToCart) {
        self.addToCart([self.labelQuantity.text intValue]);
    }
}

@end
