//
//  SearchRestaurantsViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "TopbuttonsViewController.h"
#import <CarbonKit.h>

@class CountryArea, ProductRestaurantCategory;
@interface SearchRestaurantsViewController : TopbuttonsViewController
@property (nonatomic) CountryArea *areaCode;
@property (nonatomic) ProductRestaurantCategory *category;
@end
