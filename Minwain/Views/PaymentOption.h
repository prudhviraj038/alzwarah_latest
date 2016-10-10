//
//  PaymentOption.h
//  Minwain
//
//  Created by Amit Kulkarni on 27/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentOption : UIView
@property (nonatomic) BOOL isSelected;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewMethod;
@property (weak, nonatomic) IBOutlet UIButton *buttonTap;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewWhite;
@property (nonatomic, copy) void (^changeStatus)(BOOL status);
@end
