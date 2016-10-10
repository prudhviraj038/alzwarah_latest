//
//  OrderDetailsViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 27/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "BaseViewController.h"

@class UserOrder;
@interface OrderDetailsViewController : BaseViewController
@property (nonatomic) UserOrder *order;
@end
