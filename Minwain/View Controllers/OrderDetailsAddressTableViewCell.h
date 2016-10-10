//
//  OrderDetailsAddressTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 27/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailsAddressTableViewCell : AppTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *labelInfo;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property (weak, nonatomic) IBOutlet UILabel *labelOrderId;
@property (weak, nonatomic) IBOutlet UILabel *labelOrderDate;
@property (weak, nonatomic) IBOutlet UILabel *labelArea;
@property (weak, nonatomic) IBOutlet UILabel *labelBlock;
@property (weak, nonatomic) IBOutlet UILabel *labelStreet;
@property (weak, nonatomic) IBOutlet UILabel *labelBuilding;
@property (weak, nonatomic) IBOutlet UILabel *labelFloor;
@property (weak, nonatomic) IBOutlet UILabel *labbelFlat;
@property (weak, nonatomic) IBOutlet UILabel *labelMobile;

@property (weak, nonatomic) IBOutlet UILabel *labelOrderIdText;
@property (weak, nonatomic) IBOutlet UILabel *labelOrderDateText;
@property (weak, nonatomic) IBOutlet UILabel *labelAreaText;
@property (weak, nonatomic) IBOutlet UILabel *labelBlockText;
@property (weak, nonatomic) IBOutlet UILabel *labelStreetText;
@property (weak, nonatomic) IBOutlet UILabel *labelBuildingText;
@property (weak, nonatomic) IBOutlet UILabel *labelFloorText;
@property (weak, nonatomic) IBOutlet UILabel *labbelFlatText;
@property (weak, nonatomic) IBOutlet UILabel *labelMobileText;

@end
