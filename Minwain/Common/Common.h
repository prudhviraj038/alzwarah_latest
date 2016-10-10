//
//  Common.h
//  Cavaratmall
//
//  Created by Amit Kulkarni on 12/07/15.
//  Copyright (c) 2015 iMagicsoftware. All rights reserved.
//

#ifndef Cavaratmall_Common_h
#define Cavaratmall_Common_h

#import "AppDelegate.h"
#import <MCLocalization.h>

#define KEY_LANGUAGE_EN @"en"
#define KEY_LANGUAGE_AR @"ar"

#define Localized(string) [MCLocalization stringForKey:string]

#define APP_DELEGATE (AppDelegate *) [[UIApplication sharedApplication] delegate]

#define SERVER_URL @"http://alzwarah.com/api/"

#define THEME_COLOR [UIColor colorWithRed:0.52  green:0.71  blue:0.24 alpha:1]

#define PAGE_DELIVERY_DATE_CHECK @"delivery-date-check.php"
#define PAGE_REGISTER_TOKEN @"token-register.php"
#define PAGE_ADD_RATING @"add-rating.php"
#define PAGE_FORGOT_PASSWORD @"forget-password.php"
#define PAGE_USER_DETAILS @"user-details.php"
#define PAGE_EDIT_PROFILE @"edit-profile.php"
#define PAGE_CONTACT_US @"contact-us.php"
#define PAGE_ORDER_LIST @"order-history.php"
#define PAGE_DELETE_ADDRESS @"del-address.php"
#define PAGE_EDIT_ADDRESS @"edit-address.php"
#define PAGE_ADDRESS_LIST @"address-list.php"
#define PAGE_ADD_ADDRESS @"add-address.php"
#define PAGE_COUPON_CHECK @"coupon-check.php"
#define PAGE_GET_CHARGES @"charges.php"
#define PAGE_PLACE_ORDER @"place-order.php"
#define PAGE_GET_FULL_AD @"advertisements.php"
#define PAGE_WORDS @"words-json.php"
#define PAGE_PAYMENT @"Tap.php"
#define PAGE_GET_PRODUCTS @"products.php"
#define PAGE_GET_RESTAURANTS @"restaurants.php"
#define PAGE_GET_RESTAURANT_CATEGORIES @"restaurants_cat.php"
#define PAGE_GET_AREA @"areas.php"
#define PAGE_CHARGES @"charges.php"
#define PAGE_PROMOTIONS @"promotions.php"
#define PAGE_SETTINGS @"settings.php"
#define PAGE_ADD_MEMBER @"member.php"
#define PAGE_LOGIN @"login.php"
#define PAGE_NOTIFICATIONS @"notifications.php"
#define PAGE_CHANGE_PASSWORD @"change-password.php"
#define PAGE_COUPONS @"coupons.php"

#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#endif
