//
//  AppDelegate.h
//  Minwain
//
//  Created by Amit Kulkarni on 09/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) NSString *notificationRestaurantId;

@property (nonatomic, retain) UIViewController *cartVC;
@property (nonatomic, retain) UIViewController *homeVC;
@property (nonatomic, retain) UIViewController *couponsVC;
@property (nonatomic, retain) UIViewController *promotionsVC;
@property (nonatomic, retain) UIViewController *aboutUsVC;
@property (nonatomic, retain) UIViewController *whatWeDoVC;
@property (nonatomic, retain) UIViewController *contactUsVC;
@property (nonatomic, retain) UIViewController *termsVC;
@property (nonatomic, retain) UIViewController *notificationsVC;
@property (nonatomic, retain) UIViewController *myAccountVC;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)reloadUI;

@end

