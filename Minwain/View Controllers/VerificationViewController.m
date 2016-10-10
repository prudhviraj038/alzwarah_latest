//
//  VerificationViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "VerificationViewController.h"

@interface VerificationViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *tick;
@property (weak, nonatomic) IBOutlet UITextField *editCode;
@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;
@end

@implementation VerificationViewController

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text length] > 0) {
        self.tick.hidden = NO;
    } else {
        self.tick.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tick.hidden = YES;
    
    self.editCode.placeholder = Localized(@"enter_verification_code");
    [self.buttonSubmit setTitle:Localized(@"submit") forState:UIControlStateNormal];
    self.navigationItem.title = Localized(@"title_verfication");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if (reqeustCode == 100) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)submit:(id)sender {
    if ([self.editCode.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_code")];
    } else {
        if ([self.editCode.text intValue] == [[self.result objectForKey:@"code"] intValue]) {
            [Utils loginUserWithMemberId:[self.result valueForKey:@"member_id"] withPhoneNumber:@""];
            
           // NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"];
            NSString *deviceToken = @"12345678";
            [self makePostCallForPage:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken, @"member_id":[self.result valueForKey:@"member_id"]} withRequestCode:100];
        } else {
            [self showErrorAlertWithMessage:Localized(@"invalid_code")];
        }
    }
}

@end
