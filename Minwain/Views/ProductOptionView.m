//
//  ProductOption.m
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "ProductOptionView.h"

@implementation ProductOptionView {
    
}



- (void)setOption1:(BOOL)option1 {
    if (option1 == YES) {
        self.imageView1.hidden = NO;
    } else {
        self.imageView1.hidden = YES;
    }
    _option1 = option1;
}

- (void)setOption2:(BOOL)option2 {
    if (option2 == YES) {
        self.imageView2.hidden = NO;
    } else {
        self.imageView2.hidden = YES;
    }
    _option2 = option2;
}

- (IBAction)toggleOption1:(id)sender {
    if (_option1) {
        self.option1 = NO;
    } else {
        self.option1 = YES;
    }
    
    if (self.option1Changes) {
        self.option1Changes(self.option1);
    }
}


@end
