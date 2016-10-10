//
//  NotificationTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 03/06/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "NotificationTableViewCell.h"

@implementation NotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.imageViewNotification.layer.cornerRadius = 5;
    self.imageViewNotification.clipsToBounds = YES;
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

@end
