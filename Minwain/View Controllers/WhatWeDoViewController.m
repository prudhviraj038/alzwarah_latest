//
//  WhatWeDoViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 17/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "WhatWeDoViewController.h"
#import "UIViewController+ECSlidingViewController.h"

@interface WhatWeDoViewController ()
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@end

@implementation WhatWeDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    } else {
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    }
    self.navigationItem.title = Localized(@"menu_what_we_do");
    [self makePostCallForPage:PAGE_SETTINGS withParams:@{} withRequestCode:1];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    NSDictionary *dictionary = (NSDictionary *)result;
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        [self.webView loadHTMLString:[dictionary valueForKey:@"whatwedo"] baseURL:nil];
    } else {
        [self.webView loadHTMLString:[dictionary valueForKey:@"whatwedo_ar"] baseURL:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

