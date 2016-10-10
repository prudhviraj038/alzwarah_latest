//
//  SelectRestaurantCategoryViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "BaseViewController.h"
#import "PopViewControllerDelegate.h"
#import "ProductRestaurantCategory.h"

@interface SelectRestaurantCategoryViewController : BaseViewController
@property (nonnull) id<PopViewControllerDelegate> delegate;
@property (nonatomic, copy) void (^completionBlock)(ProductRestaurantCategory *category);

@end
