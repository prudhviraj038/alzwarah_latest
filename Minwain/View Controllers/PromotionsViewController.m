//
//  PromotionsViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PromotionsViewController.h"
#import "PromotionUITableViewCell.h"
#import "ProductRestaurantPromotion.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "ProductRestaurant.h"

@interface PromotionsViewController ()  <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation PromotionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.rowHeight = 140;
    [self.tableView registerNib:[UINib nibWithNibName:@"PromotionUITableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PromotionUITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    ProductRestaurantPromotion *promotion = [self.items objectAtIndex:indexPath.row];
    cell.labelTitle.text = promotion.title;
//    cell.labelCategories.text = promotion.descriptionText;
//    
//    NSString *str = [Utils getHTMLString:promotion.descriptionText];
//    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    cell.labelContents.attributedText = attrStr;
//
    
    [cell.imageViewOffer setImageWithURL:[NSURL URLWithString:promotion.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [cell.imageViewRest setImageWithURL:[NSURL URLWithString:self.restaurant.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
