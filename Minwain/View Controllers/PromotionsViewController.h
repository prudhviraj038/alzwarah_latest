//
//  PromotionsViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "TopbuttonsViewController.h"

@class ProductRestaurant;
@interface PromotionsViewController : TopbuttonsViewController
@property (nonatomic) ProductRestaurant *restaurant;
@property (nonatomic) NSArray *items;
@end
