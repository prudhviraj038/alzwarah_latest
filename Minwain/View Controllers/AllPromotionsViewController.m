//
//  AllPromotionsViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 15/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "AllPromotionsViewController.h"
#import "PromotionUITableViewCell.h"
#import "ProductRestaurantPromotion.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "ProductRestaurant.h"
#import "AllPromotion.h"
#import "ProductRestaurant.h"
#import "RestaurantDetailsViewController.h"
#import "AllPromotionTableViewCell.h"

@interface AllPromotionsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) NSMutableArray *promotions;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AllPromotionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.promotions = [[NSMutableArray alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.rowHeight = 140;
    [self.tableView registerNib:[UINib nibWithNibName:@"AllPromotionTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [self makePostCallForPage:PAGE_PROMOTIONS withParams:@{@"category_id":self.category.productRestaurantCategoryId} withRequestCode:1];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    NSArray *temp = (NSArray *) result;
    for (NSDictionary *dictionary in temp) {
        [self.promotions addObject:[AllPromotion instanceFromDictionary:dictionary]];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.promotions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllPromotionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    AllPromotion *promotion = [self.promotions objectAtIndex:indexPath.row];
    cell.labelTtitle.text = promotion.title;
    
    NSString *str = [Utils getHTMLString:[NSString stringWithFormat:@"<br/><br/>%@", promotion.descriptionText]];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    cell.labelDescription.text = promotion.descriptionText;
    
    [cell.imageViewRestaurant setImageWithURL:[NSURL URLWithString:promotion.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
//    if ([promotion.restaurant count] > 0) {
//        ProductRestaurant *restaurant = [promotion.restaurant objectAtIndex:0];
//        [cell.imageViewRest setImageWithURL:[NSURL URLWithString:restaurant.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    }
    
    if ([promotion.price intValue] == 0) {
        cell.labelPrice.text = Localized(@"price_depends_on_selection");
    } else {
        cell.labelPrice.text = [NSString stringWithFormat:@"%@ %@", Localized(@"currency"), promotion.price];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    AllPromotion *promotion = [self.promotions objectAtIndex:indexPath.row];
    
    RestaurantDetailsViewController *vc = [Utils getViewControllerWithId:@"RestaurantDetailsViewController"];
    if ([promotion.restaurant count] > 0) {
        vc.restaurant = [promotion.restaurant objectAtIndex:0];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
