//
//  ProductDetailsViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "TopbuttonsViewController.h"

@class Product, CountryArea;
@interface ProductDetailsViewController : TopbuttonsViewController
@property (nonatomic) Product *product;
@property (nonatomic) CountryArea *area;
@end
