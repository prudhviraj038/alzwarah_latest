//
//  ContactUsViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 17/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "ContactUsViewController.h"
#import <SZTextView.h>
#import "UIViewController+ECSlidingViewController.h"

@interface ContactUsViewController () <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *editName;
@property (weak, nonatomic) IBOutlet UITextField *editEmail;
@property (weak, nonatomic) IBOutlet UITextField *editNumber;
@property (weak, nonatomic) IBOutlet SZTextView *editMessage;
@property (weak, nonatomic) IBOutlet UIButton *buttonSend;

@property (weak, nonatomic) IBOutlet UIImageView *tickName;
@property (weak, nonatomic) IBOutlet UIImageView *tickEmail;
@property (weak, nonatomic) IBOutlet UIImageView *tickNo;

@end



@implementation ContactUsViewController

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.editName) {
        if ([textField.text length] > 0) {
            self.tickName.hidden = NO;
        } else {
            self.tickName.hidden = YES;
        }
    } else if (textField == self.editEmail) {
        if ([textField.text length] > 0) {
            self.tickEmail.hidden = NO;
        } else {
            self.tickEmail.hidden = YES;
        }
    } else if (textField == self.editNumber) {
        if ([textField.text length] > 0) {
            self.tickNo.hidden = NO;
        } else {
            self.tickNo.hidden = YES;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.webView.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    } else {
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    }
    
    self.navigationItem.title = Localized(@"menu_contact_us");
    [self makePostCallForPage:PAGE_SETTINGS withParams:@{} withRequestCode:1];
    
    self.editName.placeholder = Localized(@"contact_us_name");
    self.editEmail.placeholder = Localized(@"contact_us_email");
    self.editNumber.placeholder = Localized(@"contact_us_phone");
    self.editMessage.placeholder = Localized(@"contact_us_message");
    [self.buttonSend setTitle:Localized(@"contact_us_send") forState:UIControlStateNormal];
}

- (IBAction)sendMessage:(id)sender {
    if ([self.editName.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_contact_us_name")];
    } else if ([self.editEmail.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_contact_us_email")];
    } else if ([self.editNumber.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_contact_us_number")];
    } else if ([self.editMessage.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_contact_us_message")];
    } else {
        
        [self.editName resignFirstResponder];
        [self.editEmail resignFirstResponder];
        [self.editNumber resignFirstResponder];
        [self.editMessage resignFirstResponder];
        
        [self makePostCallForPage:PAGE_CONTACT_US
                       withParams:@{
                                        @"name":self.editName.text,
                                        @"email":self.editEmail.text,
                                        @"phone":self.editNumber.text,
                                        @"message":self.editMessage.text
                                   }
                  withRequestCode:200];
        
    }
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if (requestCode == 200) {
        [self showSuccessMessage:Localized(@"contact_us_message_sent")];
        self.editMessage.text = @"";
        self.editName.text = @"";
        self.editNumber.text = @"";
        self.editEmail.text = @"";
    } else {
        NSDictionary *dictionary = (NSDictionary *)result;
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
            [self.webView loadHTMLString:[dictionary valueForKey:@"contact"] baseURL:nil];
        } else {
            [self.webView loadHTMLString:[dictionary valueForKey:@"contact_ar"] baseURL:nil];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end