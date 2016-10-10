//
//  RestaurantListViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "TopbuttonsViewController.h"
#import "ProductRestaurantCategory.h"

@class CountryArea;
@interface RestaurantListViewController : TopbuttonsViewController
@property (nonatomic) ProductRestaurantCategory *category;
@property (nonatomic) CountryArea *selectedArea;
@end
