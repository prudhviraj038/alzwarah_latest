//
//  PromotionTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromotionTableViewCell : AppTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewPromotion;
@property (weak, nonatomic) IBOutlet UILabel *labelContents;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;

- (IBAction)facebookTapped:(id)sender;
- (IBAction)twitterTapped:(id)sender;
- (IBAction)instagramTapped:(id)sender;
@end
