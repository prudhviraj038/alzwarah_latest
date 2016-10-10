//
//  TermsAndConditionsViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 27/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "TermsAndConditionsViewController.h"
#import "UIViewController+ECSlidingViewController.h"

@interface TermsAndConditionsViewController ()
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@end

@implementation TermsAndConditionsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    } else {
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    }
    
    self.navigationItem.title = Localized(@"menu_terms_and_conditions");
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    [self makePostCallForPage:PAGE_SETTINGS withParams:@{} withRequestCode:1];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    NSDictionary *dictionary = (NSDictionary *)result;
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        [self.webView loadHTMLString:[dictionary valueForKey:@"terms"] baseURL:nil];
    } else {
        [self.webView loadHTMLString:[dictionary valueForKey:@"terms_ar"] baseURL:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
