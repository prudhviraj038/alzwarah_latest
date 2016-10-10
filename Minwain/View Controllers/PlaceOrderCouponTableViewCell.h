//
//  PlaceOrderCouponTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 20/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrderCouponTableViewCell : AppTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelInfo;
@property (weak, nonatomic) IBOutlet UITextField *editCouponCode;
@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property (nonatomic, copy) void (^applyCoupon)(NSString *code);

- (IBAction)addCoupon:(id)sender;
@end
