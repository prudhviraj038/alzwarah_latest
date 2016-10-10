//
//  OrderTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 26/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : AppTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOrder;
@property (weak, nonatomic) IBOutlet UIButton *buttonRate;

@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UILabel *labelOrderId;
@property (weak, nonatomic) IBOutlet UILabel *labelOderDate;
@property (weak, nonatomic) IBOutlet UILabel *labelTotal;
@property (weak, nonatomic) IBOutlet UILabel *labelPaymentMethod;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UILabel *lableRestaurantTitle;

- (IBAction)rateOrder:(id)sender;

@property (nonatomic, copy) void (^rateOrderTapped)();
@end
