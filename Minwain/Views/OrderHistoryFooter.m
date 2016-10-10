//
//  OrderHistoryFooter.m
//  Minwain
//
//  Created by Amit Kulkarni on 07/06/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "OrderHistoryFooter.h"

@implementation OrderHistoryFooter

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];

    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
}
@end
