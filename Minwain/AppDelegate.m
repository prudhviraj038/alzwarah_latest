//
//  AppDelegate.m
//  Minwain
//
//  Created by Amit Kulkarni on 09/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

#import "HomeViewController.h"
#import <ECSlidingViewController.h>

@implementation UILabel (Helper)
- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
    self.font = [UIFont fontWithName:name size:self.font.pointSize]; }
@end

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)downloadStringsFile {
    NSData *data2 = [NSData dataWithContentsOfURL:[Utils createURLForPage:PAGE_WORDS withParameters:@{}]];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *filePath = [documentsDirectoryURL URLByAppendingPathComponent:@"strings.json"];
    NSLog(@"file: %@", filePath);
    
    [data writeToURL:filePath atomically:YES];
    
    [MCLocalization loadFromURL:filePath defaultLanguage:KEY_LANGUAGE_EN];
    if ([[Utils getLanguage] length] != 0) {
        [[MCLocalization sharedInstance] setLanguage:[Utils getLanguage]];
        [[MCLocalization sharedInstance] reloadStrings];
    }
}

- (void)reloadUI {
    self.window.rootViewController = [Utils getViewControllerWithId:@"ECSlidingViewController"];
    
    ECSlidingViewController *vc = (ECSlidingViewController *) self.window.rootViewController;
    UINavigationController *nav = (UINavigationController *) vc.topViewController;
    self.homeVC = nav.topViewController;
    
    self.termsVC = [Utils getViewControllerWithId:@"TermsAndConditionsViewController"];
    self.couponsVC = [Utils getViewControllerWithId:@"CouponsListViewController"];
    self.promotionsVC = [Utils getViewControllerWithId:@"AllPromotionsListViewController"];
    self.cartVC = [Utils getViewControllerWithId:@"CartViewController"];
    self.aboutUsVC = [Utils getViewControllerWithId:@"AboutUsViewController"];
    self.whatWeDoVC = [Utils getViewControllerWithId:@"WhatWeDoViewController"];
    self.contactUsVC = [Utils getViewControllerWithId:@"ContactUsViewController"];
    self.notificationsVC = [Utils getViewControllerWithId:@"NotificationsViewController"];
    self.myAccountVC = [Utils getViewControllerWithId:@"MyAccountViewController"];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        //[[UILabel appearance] setSubstituteFontName:@"GE Flow"];
        //[[UILabel appearance] setTextAlignment:NSTextAlignmentRight];
        [[UITextField appearance] setTextAlignment:NSTextAlignmentRight];
        [[UITextView appearance] setTextAlignment:NSTextAlignmentRight];
        
        
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        
        //[[UIButton appearance] titleLabel].font = [UIFont fontWithName:@"GE Flow" size:17];
    } else {
        //[[UILabel appearance] setTextAlignment:NSTextAlignmentLeft];
        //[[UILabel appearance] setFont:[UIFont systemFontOfSize:15]];
        [[UITextField appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UITextView appearance] setTextAlignment:NSTextAlignmentLeft];
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
    }
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeNewsstandContentAvailability| UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    
    [self downloadStringsFile];
    [self reloadUI];
    
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (notification) {
        NSDictionary *aps = [notification.userInfo objectForKey:@"aps"];
        if ([[aps valueForKey:@"type"] isEqualToString:@"rest"]) {
            [self reloadUI];
            
            ECSlidingViewController *vc = (ECSlidingViewController *) self.window.rootViewController;
            UINavigationController *navigationController = (UINavigationController *) vc.topViewController;
            self.notificationRestaurantId = [aps valueForKey:@"type_id"];
            navigationController.viewControllers = @[self.homeVC];
        } else if ([[aps valueForKey:@"type"] isEqualToString:@"order"]) {
            if ([Utils loggedInUserId] != -1) {
                ECSlidingViewController *vc = (ECSlidingViewController *) self.window.rootViewController;
                UINavigationController *navigationController = (UINavigationController *) vc.topViewController;
                navigationController.viewControllers = @[[APP_DELEGATE myAccountVC]];
            }
        }
    }
    
    return YES;
}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    NSString* strDeviceToken = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    NSLog(@"Device_Token     -----> %@\n", strDeviceToken);
    [[NSUserDefaults standardUserDefaults] setValue:strDeviceToken forKey:@"TOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"Notification received");
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    if ([[aps valueForKey:@"type"] isEqualToString:@"rest"]) {
        [self reloadUI];
        
        ECSlidingViewController *vc = (ECSlidingViewController *) self.window.rootViewController;
        UINavigationController *navigationController = (UINavigationController *) vc.topViewController;
        self.notificationRestaurantId = [aps valueForKey:@"type_id"];
        navigationController.viewControllers = @[self.homeVC];
    } else if ([[aps valueForKey:@"type"] isEqualToString:@"order"]) {
        if ([Utils loggedInUserId] != -1) {
            ECSlidingViewController *vc = (ECSlidingViewController *) self.window.rootViewController;
            UINavigationController *navigationController = (UINavigationController *) vc.topViewController;
            navigationController.viewControllers = @[[APP_DELEGATE myAccountVC]];
        }
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
    
    NSLog(@"Notification received in handler");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "iMagic-Software.Minwain" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Minwain" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Minwain.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
