//
//  LoginViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *tickName;
@property (weak, nonatomic) IBOutlet UIImageView *tickPassword;

@property (weak, nonatomic) IBOutlet UITextField *editPassword;
@property (weak, nonatomic) IBOutlet UITextField *editEmail;
@property (weak, nonatomic) IBOutlet UIButton *buttonForgotPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignup;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@end

@implementation LoginViewController

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.editEmail) {
        if ([textField.text length] > 0) {
            self.tickName.hidden = NO;
        } else {
            self.tickName.hidden = YES;
        }
    } else if (textField == self.editPassword) {
        if ([textField.text length] > 0) {
            self.tickPassword.hidden = NO;
        } else {
            self.tickPassword.hidden = YES;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = Localized(@"title_login");
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    [self.buttonSignup setTitle:Localized(@"new_here") forState:UIControlStateNormal];
    [self.buttonForgotPassword setTitle:Localized(@"forgot_password") forState:UIControlStateNormal];
    [self.buttonLogin setTitle:Localized(@"title_login") forState:UIControlStateNormal];
    
    self.editEmail.placeholder = Localized(@"email_address");
    self.editPassword.placeholder = Localized(@"password");
}

- (void)viewWillAppear:(BOOL)animated {
    if ([Utils loggedInUserId] != -1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)cancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)forgotPassword:(id)sender {
    ForgetPasswordViewController *vc = [Utils getViewControllerWithId:@"ForgetPasswordViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)signup:(id)sender {
    RegisterViewController *vc = [Utils getViewControllerWithId:@"RegisterViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)biometricLogin:(id)sender {
}

- (IBAction)login:(id)sender {
    if ([self.editEmail.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_email")];
    } else if ([self.editPassword.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_password")];
    } else {
        [self makePostCallForPage:PAGE_LOGIN withParams:@{@"email":self.editEmail.text, @"password":self.editPassword.text} withRequestCode:1];
    }
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if (reqeustCode == 1) {
        if ([[result valueForKey:@"status"] isEqualToString:@"Failure"]) {
            [self showErrorAlertWithMessage:Localized(@"invalid_user_name")];
        } else {
            [Utils loginUserWithMemberId:[result valueForKey:@"member_id"] withPhoneNumber:@""];
            NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"];
            [self makePostCallForPage:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken, @"member_id":[result valueForKey:@"member_id"]} withRequestCode:100];
        }
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
