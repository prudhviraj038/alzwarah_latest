
//
//  SearchRestaurantsViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "SearchRestaurantsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "ProductRestaurantCategory.h"
#import "RestaurantListViewController.h"
#import "CountryArea.h"

@interface SearchRestaurantsViewController () {
    CarbonTabSwipeNavigation *tabSwipe;
}
@property (nonatomic) NSMutableArray *categories;
@end

@implementation SearchRestaurantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categories = [[NSMutableArray alloc] init];
    [self makePostCallForPage:PAGE_GET_RESTAURANT_CATEGORIES withParams:@{} withRequestCode:1];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    
    [self.categories removeAllObjects];
    
    int catIndex = 0;
    NSMutableArray *names = [[NSMutableArray alloc] init];
    NSArray *array = (NSArray *)result;
    for (int index = 0; index < [array count]; index++) {
        NSDictionary *dictionary = [array objectAtIndex:index];
        ProductRestaurantCategory *category = [ProductRestaurantCategory instanceFromDictionary:dictionary];
        
        if ([self.category.productRestaurantCategoryId isEqualToString:category.productRestaurantCategoryId]) {
            catIndex = index;
            [self.categories addObject:category];
            [names addObject:category.title];
        }
    }
    
    tabSwipe = [[CarbonTabSwipeNavigation alloc] initWithItems:names delegate:self withRTL:[[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]];
    [tabSwipe setNormalColor:[UIColor blackColor]]; // default tintColor with alpha 0.8
    [tabSwipe setSelectedColor:THEME_COLOR];
    [tabSwipe setIndicatorHeight:0.0f];
    [tabSwipe insertIntoRootViewController:self];
    [tabSwipe setTabBarHeight:0.0f];
    [tabSwipe setCurrentTabIndex:catIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (nonnull UIViewController *)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {
    RestaurantListViewController *vc = [Utils getViewControllerWithId:@"RestaurantListViewController"];
    vc.category = [self.categories objectAtIndex:index];
    vc.selectedArea = self.areaCode;
    return vc;
}


@end
