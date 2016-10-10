//
//  RateOrderViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 28/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "BaseViewController.h"
#import "PopViewControllerDelegate.h"

@interface RateOrderViewController : BaseViewController
@property (nonnull) id<PopViewControllerDelegate> delegate;
@property (nonatomic) NSString *orderId;
@end
