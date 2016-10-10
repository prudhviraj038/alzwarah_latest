//
//  RestaurantDetailsViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 13/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "TopbuttonsViewController.h"
#import "ProductRestaurant.h"

typedef enum {
    OK,
    AREA_MISSING,
    PROMOTIONS_AVAILABLE
} DetailsMode;

@class CountryArea;
@interface RestaurantDetailsViewController : TopbuttonsViewController
@property (nonatomic) NSString *restaurantId;
@property (nonatomic) int tabindex;

@property (nonnull) CountryArea *selectedArea;
@property (nonatomic) ProductRestaurant *restaurant;
@property (weak, nonatomic) IBOutlet UIView *ratingView;
@property (weak, nonatomic) IBOutlet UIButton *res_info_btn;
@property (weak, nonatomic) IBOutlet UIButton *res_offers_btn;
@property (weak, nonatomic) IBOutlet UIButton *res_reviews_btn;
- (IBAction)res_offers_action:(id)sender;
- (IBAction)res_reviews_action:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *res_reviews_line;
- (IBAction)res_info_action:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *res_info_line;
@property (weak, nonatomic) IBOutlet UIView *res_offers_line;

@end
