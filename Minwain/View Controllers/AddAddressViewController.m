//
//  AddAddressViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 26/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "AddAddressViewController.h"
#import <JVFloatLabeledTextField.h>
#import "SelectAreaViewController.h"
#import "PopViewControllerDelegate.h"
#import "UIViewController+MJPopupViewController.h"
#import "UserAddressArea.h"
#import "UserAddress.h"

@interface AddAddressViewController () <PopViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *buttonSelectArea;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *editAlias;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *editBlock;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *editStreet;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *editBuilding;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *editFloor;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *editFlat;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *editPhone;
@property (nonatomic) NSString *areaId;
@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = Localized(@"add_address");
    
    self.editAlias.placeholder = Localized(@"text_alias");
    self.editBlock.placeholder = Localized(@"text_block");
    self.editStreet.placeholder = Localized(@"text_street");
    self.editBuilding.placeholder = Localized(@"text_building");
    self.editFloor.placeholder = Localized(@"text_floor");
    self.editFlat.placeholder = Localized(@"text_flat");
    self.editPhone.placeholder = Localized(@"text_mobile");
    
    if (self.address) {
        self.editPhone.text = self.address.phone;
        self.editFlat.text = self.address.appFlat;
        self.editFloor.text = self.address.floor;
        self.editBuilding.text = self.address.building;
        self.editStreet.text = self.address.street;
        self.editBlock.text = self.address.block;
        self.editAlias.text = self.address.alias;
        
        self.areaId = self.address.area.userAddressAreaId;
        [self.buttonSelectArea setTitle:self.address.area.title forState:UIControlStateNormal];
    }

}

- (IBAction)selectArea:(id)sender {
    SelectAreaViewController *vc = [[SelectAreaViewController alloc] initWithNibName:@"SelectAreaViewController" bundle:nil];
    vc.delegate = self;
    vc.restId = self.restId;
    vc.completionBlock = ^(CountryArea *area) {
        self.areaId = area.countryAreaId;
        [self.buttonSelectArea setTitle:area.title forState:UIControlStateNormal];
    };
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
}

- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addAddress:(id)sender {
    if ([self.editAlias.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_alias")];
    } else if ([self.editBlock.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_block")];
    } else if ([self.editStreet.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_street")];
    } else if ([self.editBuilding.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_building")];
    }/*else if ([self.editFloor.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_floor")];
    } else if ([self.editFlat.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_flat")];
    }*/ else if ([self.editPhone.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_mobile")];
    } else if ([self.areaId length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_area")];
    } else {
        
        if (self.address) {
            [self makePostCallForPage:PAGE_EDIT_ADDRESS
                           withParams:@{
                                        
                                        @"alias" : self.editAlias.text,
                                        @"area" : self.areaId,
                                        @"block" : self.editBlock.text,
                                        @"street" : self.editStreet.text,
                                        @"building" : self.editBuilding.text,
                                        @"floor" : self.editFloor.text,
                                        @"app_flat" : self.editFlat.text,
                                        @"phone" : self.editPhone.text,
                                        @"address_id" : self.address.userAddressId,
                                        
                                        } withRequestCode:100];
        } else {
            
            [self makePostCallForPage:PAGE_ADD_ADDRESS
                           withParams:@{
                                        @"alias" : self.editAlias.text,
                                        @"area" : self.areaId,
                                        @"block" : self.editBlock.text,
                                        @"street" : self.editStreet.text,
                                        @"building" : self.editBuilding.text,
                                        @"floor" : self.editFloor.text,
                                        @"app_flat" : self.editFlat.text,
                                        @"phone" : self.editPhone.text,
                                        @"member_id" : [Utils loggedInUserIdStr]
                                        
                                    } withRequestCode:100];
        }
        
    }
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if (self.editedAddress) {
        self.editedAddress([UserAddress instanceFromDictionary:result]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
