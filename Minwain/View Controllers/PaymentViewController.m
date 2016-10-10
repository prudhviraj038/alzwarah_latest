//
//  PaymentViewController.m
//  Cavaratmall
//
//  Created by Amit Kulkarni on 30/09/15.
//  Copyright © 2015 iMagicsoftware. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = Localized(@"online_payment");
    NSString *url = [NSString stringWithFormat:@"http://alzwarah.com/%@", PAGE_PAYMENT];
    NSString *finalUrl = [NSString stringWithFormat:@"%@?member_id=%@&amount=%@",
                          url, [Utils loggedInUserIdStr], self.amount];
    NSLog(@"final url: %@", finalUrl);
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:finalUrl]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - webview delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL result = YES;
    
    NSURL *url = [request URL];
    //if ([[url host] containsString:@"cavaratmall.com"]) {
        if ([[url query] containsString:@"result=failed"]) {
            if (self.completionBlock) {
                self.completionBlock(@"failed");
            }
            [self.navigationController popViewControllerAnimated:YES];
            return YES;
        } else if ([[url query] containsString:@"result=SUCCESS"]) {
            if (self.completionBlock) {
                self.completionBlock(@"success");
            }
            [self.navigationController popViewControllerAnimated:YES];
            return YES;
        }
    //}
    
    return result;
}

@end
