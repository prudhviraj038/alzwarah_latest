//
//  PlaceOrderAddressTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 20/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrderAddressTableViewCell : AppTableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelInfo;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property (weak, nonatomic) IBOutlet UILabel *labelAreaText;
@property (weak, nonatomic) IBOutlet UILabel *labelArea;
@property (weak, nonatomic) IBOutlet UILabel *labelBlock;
@property (weak, nonatomic) IBOutlet UILabel *labelStreet;
@property (weak, nonatomic) IBOutlet UILabel *labelBuilding;
@property (weak, nonatomic) IBOutlet UILabel *labelFloor;
@property (weak, nonatomic) IBOutlet UILabel *labbelFlat;
@property (weak, nonatomic) IBOutlet UILabel *labelMobile;
@property (weak, nonatomic) IBOutlet UILabel *labelUserArea;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;

@property (weak, nonatomic) IBOutlet UITextField *editBlock;
@property (weak, nonatomic) IBOutlet UITextField *editStreet;
@property (weak, nonatomic) IBOutlet UITextField *editBuilding;
@property (weak, nonatomic) IBOutlet UITextField *editFloot;
@property (weak, nonatomic) IBOutlet UITextField *editFlat;
@property (weak, nonatomic) IBOutlet UITextField *editMobile;
@property (weak, nonatomic) IBOutlet UITextField *editEmail;
@end
