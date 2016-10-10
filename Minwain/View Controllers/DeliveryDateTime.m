//
//  DeliveryDateTime.m
//  Minwain
//
//  Created by Amit Kulkarni on 31/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "DeliveryDateTime.h"

@implementation DeliveryDateTime

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.labelInfo.layer.cornerRadius = 5;
    self.labelInfo.clipsToBounds = YES;
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.labelInfo.text = Localized(@"selecte_delivery_date");
    self.labelDateText.text = Localized(@"selecte_delivery_date");
    self.labelTimeText.text = Localized(@"selecte_delivery_time");
}

- (IBAction)deliver_later_btn:(id)sender {
    self.check_box_later.alpha = 1;
    self.check_box_now.alpha = 0;
    if(self.delSelectlater){
        self.delSelectlater();
    }

}

- (IBAction)selectDate:(id)sender {
    if (self.dateSelect) {
        self.dateSelect();
        self.check_box_now.alpha=0;
        self.check_box_later.alpha=1;
    }
}

- (IBAction)selectTime:(id)sender {
    if (self.timeSelect) {
        self.timeSelect();
        self.check_box_now.alpha=0;
        self.check_box_later.alpha=1;

    }
}

- (IBAction)deliver_now_btn:(id)sender {
    self.check_box_later.alpha = 0;
    self.check_box_now.alpha = 1;
    if(self.delSelectnow){
        self.delSelectnow();
    }

}
@end
