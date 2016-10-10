//
//  RegisterViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "RegisterViewController.h"
#import "VerificationViewController.h"
#import "PopViewControllerDelegate.h"
#import "UIViewController+MJPopupViewController.h"
#import "SelectAreaViewController.h"
#import "CountryArea.h"

@interface RegisterViewController () <UITextFieldDelegate, PopViewControllerDelegate>
@property (nonatomic) CountryArea *area;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *editFirstName;
@property (weak, nonatomic) IBOutlet UITextField *editLastName;
@property (weak, nonatomic) IBOutlet UITextField *editMobile;
@property (weak, nonatomic) IBOutlet UITextField *editEmail;
@property (weak, nonatomic) IBOutlet UITextField *editArea;
@property (weak, nonatomic) IBOutlet UITextField *editBlock;
@property (weak, nonatomic) IBOutlet UITextField *editStreet;
@property (weak, nonatomic) IBOutlet UITextField *editHouse;
@property (weak, nonatomic) IBOutlet UITextField *editFloorNo;
@property (weak, nonatomic) IBOutlet UITextField *editFlatNo;
@property (weak, nonatomic) IBOutlet UITextField *editPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonRegister;

@property (weak, nonatomic) IBOutlet UIImageView *tickFirstName;
@property (weak, nonatomic) IBOutlet UIImageView *tickLastName;
@property (weak, nonatomic) IBOutlet UIImageView *tickPassword;
@property (weak, nonatomic) IBOutlet UIImageView *tickMobile;
@property (weak, nonatomic) IBOutlet UIImageView *tickEmail;
@property (weak, nonatomic) IBOutlet UIImageView *tickArea;
@property (weak, nonatomic) IBOutlet UIImageView *tickBlock;
@property (weak, nonatomic) IBOutlet UIImageView *tickStreet;
@property (weak, nonatomic) IBOutlet UIImageView *tickHouse;
@property (weak, nonatomic) IBOutlet UIImageView *tickFloor;
@property (weak, nonatomic) IBOutlet UIImageView *tickFlat;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = Localized(@"title_account_info");
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 365);
    
    self.editFirstName.placeholder = Localized(@"first_name");
    self.editLastName.placeholder = Localized(@"last_name");
    self.editPassword.placeholder = Localized(@"password");
    self.editMobile.placeholder = Localized(@"text_mobile");
    self.editEmail.placeholder = Localized(@"email_address");
    self.editArea.placeholder = Localized(@"text_area");
    self.editBlock.placeholder = Localized(@"text_block");
    self.editStreet.placeholder = Localized(@"text_street");
    self.editHouse.placeholder = Localized(@"house");
    self.editFloorNo.placeholder = Localized(@"floor");
    self.editFlatNo.placeholder = Localized(@"flat_number");
    
    self.editArea.enabled = NO;
    
    self.editFirstName.delegate = self;
    self.editLastName.delegate = self;
    self.editPassword.delegate = self;
    self.editMobile.delegate = self;
    self.editEmail.delegate = self;
    self.editArea.delegate = self;
    self.editBlock.delegate = self;
    self.editStreet.delegate = self;
    self.editHouse.delegate = self;
    self.editFloorNo.delegate = self;
    self.editFlatNo.delegate = self;
    
    [self.buttonRegister setTitle:Localized(@"register") forState:UIControlStateNormal];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.editFirstName) {
        if ([textField.text length] > 0) {
            self.tickFirstName.hidden = NO;
        } else {
            self.tickFirstName.hidden = YES;
        }
    } else if (textField == self.editLastName) {
        if ([textField.text length] > 0) {
            self.tickLastName.hidden = NO;
        } else {
            self.tickLastName.hidden = YES;
        }
    } else if (textField == self.editPassword) {
        if ([textField.text length] > 0) {
            self.tickPassword.hidden = NO;
        } else {
            self.tickPassword.hidden = YES;
        }
    } else if (textField == self.editMobile) {
        if ([textField.text length] > 0) {
            self.tickMobile.hidden = NO;
        } else {
            self.tickMobile.hidden = YES;
        }
    } else if (textField == self.editEmail) {
        if ([textField.text length] > 0) {
            self.tickEmail.hidden = NO;
        } else {
            self.tickEmail.hidden = YES;
        }
    } else if (textField == self.editArea) {
        if ([textField.text length] > 0) {
            self.tickArea.hidden = NO;
        } else {
            self.tickArea.hidden = YES;
        }
    } else if (textField == self.editBlock) {
        if ([textField.text length] > 0) {
            self.tickBlock.hidden = NO;
        } else {
            self.tickBlock.hidden = YES;
        }
    } else if (textField == self.editStreet) {
        if ([textField.text length] > 0) {
            self.tickStreet.hidden = NO;
        } else {
            self.tickStreet.hidden = YES;
        }
    } else if (textField == self.editHouse) {
        if ([textField.text length] > 0) {
            self.tickHouse.hidden = NO;
        } else {
            self.tickHouse.hidden = YES;
        }
    } else if (textField == self.editFloorNo) {
        if ([textField.text length] > 0) {
            self.tickFloor.hidden = NO;
        } else {
            self.tickFloor.hidden = YES;
        }
    } else if (textField == self.editFlatNo) {
        if ([textField.text length] > 0) {
            self.tickFlat.hidden = NO;
        } else {
            self.tickFlat.hidden = YES;
        }
    }
}

- (IBAction)selectArea:(id)sender {
    SelectAreaViewController *vc = [[SelectAreaViewController alloc] initWithNibName:@"SelectAreaViewController" bundle:nil];
    vc.delegate = self;
    vc.completionBlock = ^(CountryArea *area) {
        self.area = area;
        self.editArea.text = self.area.title;
        self.tickArea.hidden = NO;
    };
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}

- (IBAction)registerUser:(id)sender {
    if ([self.editFirstName.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_first_name")];
    } else if ([self.editLastName.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_last_name")];
    } else if ([self.editPassword.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_password")];
    } else if ([self.editMobile.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_mobile")];
    } else if ([self.editEmail.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_email")];
    } else if ([self.editArea.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_area")];
    } else if ([self.editBlock.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_block")];
    } else if ([self.editStreet.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_street")];
    } else if ([self.editHouse.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_house")];
    } else {
        [self makePostCallForPage:PAGE_ADD_MEMBER
                       withParams:@{
                                        @"fname":self.editFirstName.text,
                                        @"lname":self.editLastName.text,
                                        @"password":self.editPassword.text,
                                        @"phone":self.editMobile.text,
                                        @"email":self.editEmail.text,
                                        @"area":self.area.countryAreaId,
                                        @"block":self.editBlock.text,
                                        @"street":self.editStreet.text,
                                        @"house":self.editHouse.text,
                                        @"floor":self.editFloorNo.text,
                                        @"flat":self.editFlatNo.text
                                   }
                  withRequestCode:1];
    }
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if ([[result objectForKey:@"status"] isEqualToString:@"Failed"]) {
        NSLog(@"%@",result);
        [self showErrorAlertWithMessage:[result objectForKey:@"message"]];
    } else {
        VerificationViewController *vc = [Utils getViewControllerWithId:@"VerificationViewController"];
        vc.result = result;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
