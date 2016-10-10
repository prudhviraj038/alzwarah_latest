//
//  OrderSummaryViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 25/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "BaseViewController.h"

@class UserOrder;
@interface OrderSummaryViewController : BaseViewController
@property (nonatomic) UserOrder *order;
@end
