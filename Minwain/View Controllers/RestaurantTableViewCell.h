//
//  RestaurantTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantTableViewCell : AppTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelTotle;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewStatus;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelMinOrder;
@property (weak, nonatomic) IBOutlet UILabel *labelCharges;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UIView *viewPayment;
@end
