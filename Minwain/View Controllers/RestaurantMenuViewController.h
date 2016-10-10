//
//  RestaurantMenuViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "BaseViewController.h"

@class ProductRestaurantMenu, ProductRestaurant, CountryArea;
@interface RestaurantMenuViewController : BaseViewController
@property (nonatomic) CountryArea *area;
@property (nonatomic) ProductRestaurantMenu *selectedMenu;
@property (nonatomic) ProductRestaurant *selectedRestaurant;
@end
