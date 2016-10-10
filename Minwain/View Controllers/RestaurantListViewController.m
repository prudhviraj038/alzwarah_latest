//
//  RestaurantListViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "RestaurantListViewController.h"
#import "ProductRestaurant.h"
#import "ProductRestaurantMenu.h"
#import "RestaurantTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "RestaurantDetailsViewController.h"
#import "CountryArea.h"
#import "ProductRestaurantPayment.h"

@interface RestaurantListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) NSMutableArray *restaurants;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation RestaurantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.restaurants = [[NSMutableArray alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"RestaurantTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 105;
    [self makePostCallForPage:PAGE_GET_RESTAURANTS withParams:@{@"category_id":self.category.productRestaurantCategoryId, @"area_id":self.selectedArea.countryAreaId} withRequestCode:1];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    NSArray *temp = (NSArray *)result;
    for (NSDictionary *dictionary in temp) {
        [self.restaurants addObject:[ProductRestaurant instanceFromDictionary:dictionary]];
    }
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell layoutIfNeeded];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    ProductRestaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    [cell.imageViewProduct setImageWithURL:[NSURL URLWithString:restaurant.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    cell.labelTotle.text = restaurant.title;
    
    /*
    NSMutableString *categories = [[NSMutableString alloc] init];
    for (ProductRestaurantCategory *cat in restaurant.category) {
        if ([categories length] == 0) {
            [categories appendFormat:@"%@", cat.title];
        } else {
            [categories appendFormat:@", %@", cat.title];
        }
    }*/
    
//    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[restaurant.smallDescription dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    
    cell.labelAddress.text = restaurant.smallDescription;
    cell.labelTime.text = restaurant.time;
    cell.labelMinOrder.text = restaurant.hours;
    cell.labelCharges.text = restaurant.time;
    
    for (UIImageView *imageView in cell.viewPayment.subviews) {
        [imageView removeFromSuperview];
    }
    
    for (int index = 0; index < [restaurant.payment count]; index++) {
        ProductRestaurantPayment *payment = [restaurant.payment objectAtIndex:index];
        float x = 0;
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
            x = index * 25;
        } else {
            x = (cell.viewPayment.frame.size.width - 25) - (index * 25);
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, 24, 20)];
        [imageView setImageWithURL:[NSURL URLWithString:payment.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [cell.viewPayment addSubview:imageView];
    }
    if ([restaurant.currentStatus isEqualToString:@"Open"]) {
        cell.imageViewStatus.image = [UIImage imageNamed:@"open.png"];
        cell.labelStatus.text = Localized(@"status_open");
    } else if ([restaurant.currentStatus isEqualToString:@"Closed"]) {
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
    vc.selectedArea = self.selectedArea;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.restaurants count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
