//
//  SearchRestaurantViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 18/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "SearchRestaurantViewController.h"
#import "ProductRestaurant.h"
#import "ProductRestaurantMenu.h"
#import "RestaurantTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "RestaurantDetailsViewController.h"
#import "CountryArea.h"
#import "ProductRestaurantCategory.h"

@interface SearchRestaurantViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) NSMutableArray *restaurants;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchRestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = Localized(@"title_search_restaurants");
    self.restaurants = [[NSMutableArray alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 105;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self makePostCallForPage:PAGE_GET_RESTAURANTS withParams:@{@"search":self.searchBar.text} withRequestCode:1];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    [self.restaurants removeAllObjects];
    NSArray *temp = (NSArray *)result;
    for (NSDictionary *dictionary in temp) {
        [self.restaurants addObject:[ProductRestaurant instanceFromDictionary:dictionary]];
    }
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    ProductRestaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    [cell.imageViewProduct setImageWithURL:[NSURL URLWithString:restaurant.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    cell.labelTotle.text = restaurant.title;
    
    NSMutableString *categories = [[NSMutableString alloc] init];
    for (ProductRestaurantCategory *cat in restaurant.category) {
        if ([categories length] == 0) {
            [categories appendFormat:@"%@", cat.title];
        } else {
            [categories appendFormat:@", %@", cat.title];
        }
    }
    cell.labelAddress.text = categories;
    cell.labelTime.text = restaurant.hours;
    cell.labelMinOrder.text = restaurant.minimum;
    cell.labelCharges.text = restaurant.time;
    
    
    if ([restaurant.currentStatus isEqualToString:@"Open"]) {
        cell.imageViewStatus.image = [UIImage imageNamed:@"open.png"];
        cell.labelStatus.text = Localized(@"status_open");
    } else if ([restaurant.currentStatus isEqualToString:@"Close"]) {
        cell.imageViewStatus.image = [UIImage imageNamed:@"close_.png"];
        cell.labelStatus.text = Localized(@"status_close");
    } else if ([restaurant.currentStatus isEqualToString:@"Busy"]) {
        cell.imageViewStatus.image = [UIImage imageNamed:@"busy.png"];
        cell.labelStatus.text = Localized(@"status_busy");
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    RestaurantDetailsViewController *vc = [Utils getViewControllerWithId:@"RestaurantDetailsViewController"];
    vc.restaurant = [self.restaurants objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.restaurants count];
}

@end
