//
//  NotificationTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 03/06/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "AppTableViewCell.h"

@interface NotificationTableViewCell : AppTableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewNotification;
@property (weak, nonatomic) IBOutlet UILabel *labeMessage;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@end
