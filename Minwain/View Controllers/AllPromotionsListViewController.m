//
//  AllPromotionsListViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 15/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "AllPromotionsListViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "ProductRestaurantCategory.h"
#import "AllPromotionsViewController.h"
#import "CountryArea.h"
#import <CarbonKit.h>

@interface AllPromotionsListViewController () {
    CarbonTabSwipeNavigation *tabSwipe;
}
@property (nonatomic) NSMutableArray *categories;

@end

@implementation AllPromotionsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    } else {
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    }
//    
    self.categories = [[NSMutableArray alloc] init];
    [self makePostCallForPage:PAGE_GET_RESTAURANT_CATEGORIES withParams:@{} withRequestCode:1];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    
    [self.categories removeAllObjects];
    
    NSMutableArray *names = [[NSMutableArray alloc] init];
    NSArray *array = (NSArray *)result;
    for (NSDictionary *dictionary in array) {
        ProductRestaurantCategory *category = [ProductRestaurantCategory instanceFromDictionary:dictionary];
        [self.categories addObject:category];
        [names addObject:category.title];
    }
    
    tabSwipe = [[CarbonTabSwipeNavigation alloc] initWithItems:names delegate:self withRTL:[[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]];
    [tabSwipe setNormalColor:[UIColor blackColor]]; // default tintColor with alpha 0.8
    [tabSwipe setSelectedColor:THEME_COLOR];
    [tabSwipe setIndicatorHeight:2.f];
    [tabSwipe insertIntoRootViewController:self];
}

- (nonnull UIViewController *)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {
    AllPromotionsViewController *vc = [Utils getViewControllerWithId:@"AllPromotionsViewController"];
    vc.category = [self.categories objectAtIndex:index];
    return vc;
}

@end
