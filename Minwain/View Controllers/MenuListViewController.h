//
//  MenuListViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "TopbuttonsViewController.h"

@class ProductRestaurant, CountryArea;
@interface MenuListViewController : TopbuttonsViewController
@property (nonatomic) NSArray *menus;
@property (nonatomic) CountryArea *area;
@property (nonatomic) ProductRestaurant *selectedRestaurant;
@end
