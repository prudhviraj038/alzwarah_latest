//
//  TopbuttonsViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 18/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "TopbuttonsViewController.h"
#import "LoginViewController.h"

@interface TopbuttonsViewController ()

@end

@implementation TopbuttonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    UIView *titleView = [[UIView alloc] init];
    [titleView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *buttonSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSearch.frame = CGRectMake(0, 5, 30, 30);
    [buttonSearch setImage:[UIImage imageNamed:@"search_icon.png"] forState:UIControlStateNormal];
    [buttonSearch setBackgroundImage:[UIImage imageNamed:@"button_background_icon.png"] forState:UIControlStateNormal];
    [buttonSearch addTarget:self action:@selector(searchRestaurant) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:buttonSearch];
    
    //    UIButton *buttonFilter = [UIButton buttonWithType:UIButtonTypeCustom];
    //    buttonFilter.frame = CGRectMake(40, 5, 30, 30);
    //    [buttonFilter setImage:[UIImage imageNamed:@"filter_icon.png"] forState:UIControlStateNormal];
    //    [buttonFilter setBackgroundImage:[UIImage imageNamed:@"button_background_icon.png"] forState:UIControlStateNormal];
    //    [buttonFilter addTarget:self action:@selector(filterRestaurant) forControlEvents:UIControlEventTouchUpInside];
    //    [titleView addSubview:buttonFilter];
    
    UIButton *buttonCart = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonCart setImage:[UIImage imageNamed:@"cart_icon.png"] forState:UIControlStateNormal];
    [buttonCart setBackgroundImage:[UIImage imageNamed:@"button_background_icon.png"] forState:UIControlStateNormal];
    [buttonCart addTarget:self action:@selector(showCart) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:buttonCart];
    
    UIButton *buttonLanguage = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [buttonLanguage setTitle:@"EN" forState:UIControlStateNormal];
    } else {
        [buttonLanguage setTitle:@"AR" forState:UIControlStateNormal];
    }
    [buttonLanguage setBackgroundImage:[UIImage imageNamed:@"button_background_icon.png"] forState:UIControlStateNormal];
    [buttonLanguage addTarget:self action:@selector(switchLanguage) forControlEvents:UIControlEventTouchUpInside];
   // [titleView addSubview:buttonLanguage];
    
    UIButton *buttonUser = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonUser setImage:[UIImage imageNamed:@"user.png"] forState:UIControlStateNormal];
    [buttonUser setBackgroundImage:[UIImage imageNamed:@"button_background_icon.png"] forState:UIControlStateNormal];
    [buttonUser addTarget:self action:@selector(showMyAccount) forControlEvents:UIControlEventTouchUpInside];
   // [titleView addSubview:buttonUser];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"products"];
    NSArray *temp = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if ([temp count] > 0) {
        buttonCart.frame = CGRectMake(40, 5, 60, 30);
       // buttonLanguage.frame = CGRectMake(120, 5, 30, 30);
        //buttonUser.frame = CGRectMake(160, 5, 30, 30);
        [buttonCart setTitle:[NSString stringWithFormat:@" %ld", [temp count]] forState:UIControlStateNormal];
        
        titleView.frame = CGRectMake(0, 0, 100, 40);
    } else {
        buttonCart.frame = CGRectMake(40, 5, 30, 30);
      //  buttonLanguage.frame = CGRectMake(80, 5, 30, 30);
        //buttonUser.frame = CGRectMake(120, 5, 30, 30);
        [buttonCart setTitle:@"" forState:UIControlStateNormal];
        
        titleView.frame = CGRectMake(0, 0, 70, 40);
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:titleView];
    
    //self.navigationItem.titleView = titleView;

}

- (void)searchRestaurant {
    [self.navigationController pushViewController:[Utils getViewControllerWithId:@"SearchRestaurantViewController"] animated:YES];
}

- (void)filterRestaurant {
    [self.navigationController pushViewController:[Utils getViewControllerWithId:@"SearchRestaurantViewController"] animated:YES];
}

- (void)showCart {
//    if ([Utils loggedInUserId] == -1) {
//        LoginViewController *vc = [Utils getViewControllerWithId:@"LoginViewController"];
//        [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
//    } else {
        [self.navigationController pushViewController:[APP_DELEGATE cartVC] animated:YES];
//    }
    
}

- (void)switchLanguage {
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [Utils setLanguage:KEY_LANGUAGE_EN];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_EN];
        //[self showErrorAlertWithMessage:Localized(@"restart_app")];
    } else {
        [Utils setLanguage:KEY_LANGUAGE_AR];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_AR];
        //[self showErrorAlertWithMessage:Localized(@"restart_app")];
    }
    
    [APP_DELEGATE reloadUI];
}

- (void)showMyAccount {
    if ([Utils loggedInUserId] == -1) {
        LoginViewController *vc = [Utils getViewControllerWithId:@"LoginViewController"];
        [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    } else {
        [self.navigationController pushViewController:[APP_DELEGATE myAccountVC] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
