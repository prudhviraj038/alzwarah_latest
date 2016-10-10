//
//  PlaceOrderHeader.m
//  Minwain
//
//  Created by Amit Kulkarni on 20/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PlaceOrderHeader.h"

@implementation PlaceOrderHeader

- (void)awakeFromNib {
    self.labelInfo.layer.cornerRadius = 5;
    self.labelInfo.clipsToBounds = YES;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    
    self.labelInfo.text = Localized(@"products");
}

@end
