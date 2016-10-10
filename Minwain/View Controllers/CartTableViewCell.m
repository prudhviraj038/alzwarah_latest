//
//  CartTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 19/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.imageViewProduct.layer.cornerRadius = 10;
    self.add_btn.layer.cornerRadius = 12.5f;
    self.minus_btn.layer.cornerRadius = 12.5f;
    
    
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//        self.labelTitle.textAlignment = NSTextAlignmentRight;
//        self.labelQuantity.textAlignment = NSTextAlignmentRight;
//        self.labelPric.textAlignment = NSTextAlignmentRight;
//        self.labelTotal.textAlignment = NSTextAlignmentRight;
//    } else {
//        self.labelTitle.textAlignment = NSTextAlignmentLeft;
//        self.labelQuantity.textAlignment = NSTextAlignmentLeft;
//        self.labelPric.textAlignment = NSTextAlignmentLeft;
//        self.labelTotal.textAlignment = NSTextAlignmentLeft;
//    }
}

- (IBAction)removeProduct:(id)sender {
    if (self.deleteProduct) {
        self.deleteProduct();
    }
}

//- (IBAction)changeQuantity:(id)sender {
//    UIStepper *stepper = (UIStepper *)sender;
//    self.completionBlock(stepper.value);
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)add_quantity:(id)sender {
    self.completionBlock(1);
}

- (IBAction)remove_quantity:(id)sender {
    self.completionBlock(0);

}
@end
