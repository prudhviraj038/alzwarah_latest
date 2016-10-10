//
//  MenuListViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "MenuListViewController.h"
#import "ProductRestaurantMenu.h"
#import <CarbonKit.h>
#import "CountryArea.h"

#import "RestaurantMenuViewController.h"

@interface MenuListViewController ()  {
    CarbonTabSwipeNavigation *tabSwipe;
}

@end

@implementation MenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        NSMutableArray *names = [[NSMutableArray alloc] init];
    for (ProductRestaurantMenu *menu in self.menus) {
        [names addObject:menu.title];
    }
    
    tabSwipe = [[CarbonTabSwipeNavigation alloc] initWithItems:names delegate:self withRTL:[[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]];
    [tabSwipe setNormalColor:[UIColor blackColor]]; // default tintColor with alpha 0.8
    [tabSwipe setSelectedColor:THEME_COLOR];
    [tabSwipe setIndicatorHeight:2.f];
    [tabSwipe insertIntoRootViewController:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (nonnull UIViewController *)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {
    RestaurantMenuViewController *vc = [Utils getViewControllerWithId:@"RestaurantMenuViewController"];
    vc.selectedMenu = [self.menus objectAtIndex:index];
    vc.selectedRestaurant = self.selectedRestaurant;
    vc.area = self.area;
    return vc;
}


@end
