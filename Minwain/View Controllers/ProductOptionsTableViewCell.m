//
//  ProductOptionsTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "ProductOptionsTableViewCell.h"

@implementation ProductOptionsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.container.layer.cornerRadius = 5;
    self.container.clipsToBounds = YES;
    
    self.labelTitle.layer.cornerRadius = 5;
    self.labelTitle.clipsToBounds = YES;
    self.labelTitle.text = Localized(@"product_options");
    
    //self.backgroundColor = [UIColor clearColor];
    //self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
