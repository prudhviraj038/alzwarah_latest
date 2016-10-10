//
//  Utils.m
//  MyShop
//
//  Created by Amit Kulkarni on 11/09/14.
//  Copyright (c) 2014 Amit Kulkarni. All rights reserved.
//

#import "Utils.h"
#import <UIKit/UIKit.h>
#import "Common.h"

@implementation Utils

#define KEY_LOGIN_MEMBER_ID @"KEY_LOGIN_MEMBER_ID"
#define KEY_LOGIN_STATUS @"KEY_LOGIN_STATUS"
#define KEY_LOGIN_PHONE @"KEY_LOGIN_PHONE"
#define KEY_LANGUAGE @"KEY_LANGUAGE"
#define KEY_CURRENT_PACKAGE @"KEY_CURRENT_PACKAGE"
#define KEY_COUNTRY_NAME @"KEY_COUNTRY_NAME"
#define KEY_COUNTRY_ID @"KEY_COUNTRY_ID"

#define KEY_LOGIN_DETAILS @"KEY_LOGIN_DETAILS"
#define KEY_LOGIN_FIRSTNAME @"KEY_LOGIN_FIRSTNAME"
#define KEY_LOGIN_LASTNAME @"KEY_LOGIN_LASTNAME"
#define KEY_QB_ID @"KEY_QB_ID"

+ (NSString *)getHTMLString:(NSString *)string {
    int kFieldFontSize = 16;
    NSString *myDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
                                   "<head> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@;}\n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body>%@</body> \n"
                                   "</html>", @"helvetica", [NSNumber numberWithInt:kFieldFontSize], string];
    
    return myDescriptionHTML;
}

+ (id)getViewControllerWithId:(NSString *)vcId {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:vcId];
}

+ (BOOL)isCountrySelected {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:KEY_COUNTRY_ID] != nil;
}

+ (NSString *)getSelectedCountry {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:KEY_COUNTRY_ID];
}

+ (NSString *)getSelectedCountryName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:KEY_COUNTRY_NAME];
}

+ (void) setCountry:(NSString *)name withId:(NSString *)cId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:name forKey:KEY_COUNTRY_NAME];
    [defaults setValue:cId forKey:KEY_COUNTRY_ID];
    [defaults synchronize];
}

+ (BOOL)isiPad {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
    
    return NO;
}

+ (void)packagePurchased:(NSString *)packageId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:packageId forKey:KEY_CURRENT_PACKAGE];
    [defaults synchronize];
}

+ (NSTextAlignment) getAlignment {
    if ([[[MCLocalization sharedInstance] language] isEqualToString:KEY_LANGUAGE_AR]) {
        return NSTextAlignmentRight;
    }
    
    return NSTextAlignmentLeft;
}

+ (NSString *)getLanguage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:KEY_LANGUAGE];
}

+ (void)setLanguage:(NSString *)language {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:language forKey:KEY_LANGUAGE];
    [defaults setObject:[NSMutableArray arrayWithObjects:language, nil] forKey:@"AppleLanguages"];
    [defaults setObject:[NSArray arrayWithObjects:language, nil] forKey:@"NSLanguages"];
    [defaults setObject:[NSString stringWithFormat:@"%@", language] forKey:@"AppleLocale"];
    [defaults synchronize];
}

+ (NSString *)loggedInUserMobile {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:KEY_LOGIN_PHONE];
}

+ (void)updateQBId:(NSInteger)qbId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:qbId forKey:KEY_QB_ID];
    [defaults synchronize];
}

+ (NSInteger)getQBId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:KEY_QB_ID];
}

+ (NSString *)loggedInUserIdStr {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int memberId = -1;
    if ([defaults boolForKey:KEY_LOGIN_STATUS]) {
        memberId = [[defaults valueForKey:KEY_LOGIN_MEMBER_ID] intValue];
    }
    return [NSString stringWithFormat:@"%d", memberId];
}

+ (int)loggedInUserId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int memberId = -1;
    if ([defaults boolForKey:KEY_LOGIN_STATUS]) {
        memberId = [[defaults valueForKey:KEY_LOGIN_MEMBER_ID] intValue];
    }
    return memberId;
}

//+ (void)loginWithUser:(User *)user {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:user.userId forKey:KEY_LOGIN_MEMBER_ID];
//    [defaults setValue:user.details forKey:KEY_LOGIN_DETAILS];
//    [defaults setValue:user.firstname forKey:KEY_LOGIN_FIRSTNAME];
//    [defaults setValue:user.lastname forKey:KEY_LOGIN_LASTNAME];
//    [defaults setBool:YES forKey:KEY_LOGIN_STATUS];
//    [defaults setValue:@"232434" forKey:KEY_LOGIN_PHONE];
//    [defaults synchronize];
//}

+ (NSString *)getCurrentPackage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [NSString stringWithFormat:@"%@", [defaults valueForKey:KEY_CURRENT_PACKAGE]];
}

+ (void)loginUserWithMemberId:(NSString *)memberId withPhoneNumber:(NSString *)phone {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:memberId forKey:KEY_LOGIN_MEMBER_ID];
    [defaults setValue:phone forKey:KEY_LOGIN_PHONE];
    [defaults setBool:YES forKey:KEY_LOGIN_STATUS];
    [defaults setValue:@"1" forKey:KEY_CURRENT_PACKAGE];
    [defaults synchronize];
}

+ (void)logoutUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:@"" forKey:KEY_LOGIN_MEMBER_ID];
    [defaults setValue:@"" forKey:KEY_LOGIN_PHONE];
    [defaults setBool:NO forKey:KEY_LOGIN_STATUS];
    [defaults synchronize];
}

+ (NSDate *)getDateFromTimestamp:(NSString *)timestamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:timestamp];
}

+ (BOOL)isOnline {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
    } else {
        return YES;
    }
}

+ (void) showAlertWithMessage:(NSString *) message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:Localized(@"ok")
                                          otherButtonTitles:nil];
    [alert show];
}


+ (void) showErrorAlertWithMessage:(NSString *) message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[MCLocalization stringForKey:@"error"]
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:[MCLocalization stringForKey:@"ok"]
                                          otherButtonTitles:nil];
    [alert show];
}

+ (NSString *)createURLForPage:(NSString *) page {
    return [NSString stringWithFormat:@"%@/%@", SERVER_URL, page];
}

+ (NSString *)getParameterListFromDisctionary:(NSDictionary *)params {
    NSMutableString *string = [[NSMutableString alloc] init];
    if ([[params allKeys] count] > 0) {
        for (NSString *key in [params allKeys]) {
            NSString *value = [[params valueForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [string appendFormat:@"%@=%@&", key, value];
        }
    }
    return string;
}

+ (NSURL *) createURLForPage:(NSString *)page withParameters:(NSDictionary *) params {
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendFormat:@"%@/%@", SERVER_URL, page];
    if ([[params allKeys] count] > 0) {
        [url appendString:@"?"];
        for (NSString *key in [params allKeys]) {
            id value = [params valueForKey:key];
            if ([value isKindOfClass:[NSString class]]) {
                NSString *val = (NSString *)value;
                NSString *value2 = [val stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [url appendFormat:@"%@=%@&", key, value2];
            } else if ([value isKindOfClass:[NSNumber class]]) {
                NSNumber *number = [NSNumber numberWithInteger:value];
                [url appendFormat:@"%@=%@&", key, [number stringValue]];
            }
        }
    }
    
    NSLog(@"URL : %@", url);
    return [NSURL URLWithString:url];
}

+ (CGSize)getSizeForText:(NSString *)text maxWidth:(CGFloat)width font:(UIFont *)font {
    CGSize constraintSize;
    constraintSize.height = MAXFLOAT;
    constraintSize.width = width;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];

    CGRect frame = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{ NSFontAttributeName:font }
                                      context:nil];
    return CGSizeMake(frame.size.width, frame.size.height + 1);
    
//    CGRect frame = [text boundingRectWithSize:constraintSize
//                                      options:NSStringDrawingUsesFontLeading
//                                   attributes:attributesDictionary
//                                      context:nil];
//    
//    CGSize stringSize = frame.size;
//    return stringSize;
    
//    return [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
}

@end


