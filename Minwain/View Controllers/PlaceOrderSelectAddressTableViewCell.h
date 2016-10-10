//
//  PlaceOrderSelectAddressTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 25/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrderSelectAddressTableViewCell : AppTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *labelInfo;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIButton *buttonEdit;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;

@property (weak, nonatomic) IBOutlet UILabel *labelArea;
@property (weak, nonatomic) IBOutlet UILabel *labelBlock;
@property (weak, nonatomic) IBOutlet UILabel *labelStreet;
@property (weak, nonatomic) IBOutlet UILabel *labelBuilding;
@property (weak, nonatomic) IBOutlet UILabel *labelFloor;
@property (weak, nonatomic) IBOutlet UILabel *labbelFlat;
@property (weak, nonatomic) IBOutlet UILabel *labelMobile;

@property (weak, nonatomic) IBOutlet UILabel *labelAreaText;
@property (weak, nonatomic) IBOutlet UILabel *labelBlockText;
@property (weak, nonatomic) IBOutlet UILabel *labelStreetText;
@property (weak, nonatomic) IBOutlet UILabel *labelBuildingText;
@property (weak, nonatomic) IBOutlet UILabel *labelFloorText;
@property (weak, nonatomic) IBOutlet UILabel *labbelFlatText;
@property (weak, nonatomic) IBOutlet UILabel *labelMobileText;

@property (nonatomic) void (^selectAddress)();
@property (nonatomic) void (^editAddress)();
@property (nonatomic) void (^addAddress)();

@end
