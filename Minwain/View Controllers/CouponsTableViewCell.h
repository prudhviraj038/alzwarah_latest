//
//  CouponsTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 24/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponsTableViewCell : AppTableViewCell

@property (nonatomic) NSString *code;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCoupon;
@property (weak, nonatomic) IBOutlet UIButton *buttonCopy;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property (nonatomic) void (^showAlert)();

@end
