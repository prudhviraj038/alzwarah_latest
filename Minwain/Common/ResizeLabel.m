//
//  ResizeLabel.m
//  StreetWhere
//
//  Created by Amit Kulkarni on 11/04/15.
//  Copyright (c) 2015 Mobentia. All rights reserved.
//

#import "ResizeLabel.h"

@implementation ResizeLabel

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    if (self.numberOfLines == 0 && bounds.size.width != self.preferredMaxLayoutWidth) {
        self.preferredMaxLayoutWidth = self.bounds.size.width;
        [self setNeedsUpdateConstraints];
    }
}

@end
