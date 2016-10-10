//
//  TrendingCollectionViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "TrendingCollectionViewCell.h"

@implementation TrendingCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageViewProduct.layer.cornerRadius = 10;
    self.imageViewProduct.clipsToBounds = YES;
    
    self.labelTitle.textColor = [UIColor whiteColor];
}

@end
