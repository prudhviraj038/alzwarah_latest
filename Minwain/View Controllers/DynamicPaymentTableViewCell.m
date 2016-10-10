//
//  DynamicPaymentTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 27/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "DynamicPaymentTableViewCell.h"

@implementation DynamicPaymentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.labelInfo.layer.cornerRadius = 5;
    self.labelInfo.clipsToBounds = YES;
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
   
    self.labelInfo.text = Localized(@"payment_options");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
