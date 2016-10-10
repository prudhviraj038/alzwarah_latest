//
//  MenuProductTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuProductTableViewCell : AppTableViewCell

@property (nonatomic) int quantity;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelCategories;
@property (weak, nonatomic) IBOutlet UIView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelQuantity;
@property (weak, nonatomic) IBOutlet UIView *container;

- (IBAction)addQuantity:(id)sender;
- (IBAction)deleteQuantity:(id)sender;
- (void)setRating:(float)rating ;
@end
