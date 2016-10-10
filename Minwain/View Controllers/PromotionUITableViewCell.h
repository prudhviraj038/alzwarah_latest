//
//  PromotionUITableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 15/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromotionUITableViewCell : AppTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRest;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOffer;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelCategories;

@end
