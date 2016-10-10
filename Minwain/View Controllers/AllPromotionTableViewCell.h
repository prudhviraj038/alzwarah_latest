//
//  AllPromotionTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 21/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllPromotionTableViewCell : AppTableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UILabel *labelTtitle;

@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRestaurant;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@end
