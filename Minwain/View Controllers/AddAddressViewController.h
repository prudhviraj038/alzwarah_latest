//
//  AddAddressViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 26/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "BaseViewController.h"

@class UserAddress;
@interface AddAddressViewController : BaseViewController
@property (nonatomic) NSString *restId;
@property (nonatomic) UserAddress *address;
@property (nonatomic, copy) void (^editedAddress)(UserAddress *address);
@end
