//
//  LanguageViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "LanguageViewController.h"

@interface LanguageViewController ()

@end

@implementation LanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)selectEnglish:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [Utils setLanguage:KEY_LANGUAGE_EN];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_EN];
        [APP_DELEGATE reloadUI];
    }];
}

- (IBAction)selectArabic:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [Utils setLanguage:KEY_LANGUAGE_AR];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_AR];
        [APP_DELEGATE reloadUI];
    }];
}

@end
