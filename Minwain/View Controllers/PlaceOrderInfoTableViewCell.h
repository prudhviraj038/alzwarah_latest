//
//  PlaceOrderInfoTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 24/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrderInfoTableViewCell : AppTableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelInfo;

@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property (weak, nonatomic) IBOutlet UILabel *labelFirstNAme;
@property (weak, nonatomic) IBOutlet UILabel *labelLastNAme;
@property (weak, nonatomic) IBOutlet UILabel *labelWorkPhone;
@property (weak, nonatomic) IBOutlet UILabel *labelHomePhone;
@property (weak, nonatomic) IBOutlet UILabel *labelMobile;

@property (weak, nonatomic) IBOutlet UITextField *editFirstName;
@property (weak, nonatomic) IBOutlet UITextField *editLastName;
@property (weak, nonatomic) IBOutlet UITextField *editWorkPhone;
@property (weak, nonatomic) IBOutlet UITextField *editHomePhone;
@property (weak, nonatomic) IBOutlet UITextField *editMobile;

@end
