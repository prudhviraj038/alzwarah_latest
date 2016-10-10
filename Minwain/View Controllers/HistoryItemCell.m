//
//  HistoryItemCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 07/06/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "HistoryItemCell.h"

@implementation HistoryItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
}

@end
