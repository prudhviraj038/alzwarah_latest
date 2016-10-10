//
//  ForgetPasswordViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 28/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tick;
@property (weak, nonatomic) IBOutlet UITextField *editCode;
@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;

@end

@implementation ForgetPasswordViewController


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
    
    self.editCode.placeholder = Localized(@"email_address");
    [self.buttonSubmit setTitle:Localized(@"submit") forState:UIControlStateNormal];
    self.navigationItem.title = Localized(@"forgot_password");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)submit:(id)sender {
    if ([self.editCode.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_code")];
    } else {
        [self makePostCallForPage:PAGE_FORGOT_PASSWORD withParams:@{@"email":self.editCode.text} withRequestCode:10];
    }
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if ([[result valueForKey:@"status"] isEqualToString:@"Failed"]) {
        [self showErrorAlertWithMessage:[result valueForKey:@"message"]];
    } else {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:Localized(@"forgot_password_sent") preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:Localized(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }]];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

@end
