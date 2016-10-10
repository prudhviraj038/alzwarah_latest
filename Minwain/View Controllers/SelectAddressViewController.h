//
//  SelectAddressViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 26/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "BaseViewController.h"
#import "PopViewControllerDelegate.h"
#import "UserAddress.h"

@interface SelectAddressViewController : BaseViewController
@property (nonnull) id<PopViewControllerDelegate> delegate;
@property (nonatomic, copy) void (^completionBlock)(UserAddress *address);
@end
