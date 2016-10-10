//
//  RestaurantMenuViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "RestaurantMenuViewController.h"
#import "ProductRestaurant.h"
#import "ProductRestaurantMenu.h"
#import "MenuProductTableViewCell.h"
#import "Product.h"
#import "ProductImage.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "ProductCategory.h"
#import "ProductDetailsViewController.h"
#import "CountryArea.h"

@interface RestaurantMenuViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) NSMutableArray *menuItems;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation RestaurantMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 102;
    [self makePostCallForPage:PAGE_GET_PRODUCTS withParams:@{@"rest_id":self.selectedRestaurant.productRestaurantId, @"category":self.selectedMenu.productRestaurantMenuId} withRequestCode:1];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    self.menuItems = [[NSMutableArray alloc] init];
    NSArray *temp = (NSArray *)result;
    for (NSDictionary *dictionary in temp) {
        [self.menuItems addObject:[Product instanceFromDictionary:dictionary]];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuItems count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailsViewController *vc = [Utils getViewControllerWithId:@"ProductDetailsViewController"];
    vc.product = [self.menuItems objectAtIndex:indexPath.row
                  ];
    vc.area = self.area;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuProductTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    Product *product = [self.menuItems objectAtIndex:indexPath.row];
    cell.quantity = 1;
    cell.labelTitle.text = product.title;
    if ([product.price intValue] == 0) {
        cell.labelPrice.text = Localized(@"price_depends_on_selection");
    } else {
        cell.labelPrice.text = [NSString stringWithFormat:@"%@ %@", Localized(@"currency"), product.price];
    }
    //  [cell setRating:product.rating];
    if ([product.images count] > 0) {
        ProductImage *image = [product.images objectAtIndex:0];
        [cell.imageViewProduct setImageWithURL:[NSURL URLWithString:image.thumb] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    
    /*NSMutableString *categories = [[NSMutableString alloc] init];
    for (ProductCategory *cat in product.category) {
        if ([categories length] == 0) {
            [categories appendFormat:@"%@", cat.title];
        } else {
            [categories appendFormat:@", %@", cat.title];
        }
    }
    cell.labelCategories.text = categories; */
    cell.labelCategories.text = product.descriptionText;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.layer.shadowOffset = CGSizeMake(1, 0);
    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.layer.shadowRadius = 4;
    cell.layer.shadowOpacity = .15;
    
    return cell;
}

@end
