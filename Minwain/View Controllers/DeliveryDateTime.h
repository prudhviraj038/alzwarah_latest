//
//  DeliveryDateTime.h
//  Minwain
//
//  Created by Amit Kulkarni on 31/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "AppTableViewCell.h"

@interface DeliveryDateTime : AppTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelInfo;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UILabel *labelDateText;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeText;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labeltimenow;

- (IBAction)deliver_now_btn:(id)sender;

@property (nonatomic, copy) void (^dateSelect)();
@property (nonatomic, copy) void (^timeSelect)();

@property (nonatomic, copy) void (^delSelectnow)();

@property (nonatomic, copy) void (^delSelectlater)();




@property (weak, nonatomic) IBOutlet UIImageView *check_box_now;
@property (weak, nonatomic) IBOutlet UIImageView *check_box_later;
- (IBAction)deliver_later_btn:(id)sender;

- (IBAction)selectDate:(id)sender;
- (IBAction)selectTime:(id)sender;

@end
