//
//  CouponsListViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 24/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "CouponsListViewController.h"
#import "DiscountCoupon.h"
#import "CouponsTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface CouponsListViewController ()
@property (nonatomic) NSMutableArray *coupons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CouponsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coupons = [[NSMutableArray alloc] init];
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    } else {
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    }
    
    self.tableView.rowHeight = 152;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"CouponsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.title = Localized(@"menu_coupons");
    [self makePostCallForPage:PAGE_COUPONS withParams:@{} withRequestCode:1];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    NSArray *temp = (NSArray *)result;
    
    [self.coupons removeAllObjects];
    for (NSDictionary *dictionary in temp) {
        [self.coupons addObject:[DiscountCoupon instanceFromDictionary:dictionary]];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.coupons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    DiscountCoupon *coupon = [self.coupons objectAtIndex:indexPath.row];
    
    cell.showAlert = ^() {
        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        [pb setString:coupon.code];

        [self showSuccessMessage:Localized(@"coupon_code_copied")];
    };
    
    cell.code = coupon.code;
    cell.labelTitle.text = coupon.restaurant;
    cell.labelDescription.text = coupon.descriptionText;

    [cell.imageViewCoupon setImageWithURL:[NSURL URLWithString:coupon.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    if ([coupon.discountType isEqualToString:@"amount"]) {
        cell.labelPrice.text = [NSString stringWithFormat:@"%@ %@ %@", Localized(@"discount"), Localized(@"currency"), coupon.discount];
    } else if ([coupon.discountType isEqualToString:@"percentage"]) {
        cell.labelPrice.text = [NSString stringWithFormat:@"%@ %@ %%", Localized(@"discount"), coupon.discount];
    }
    
    return cell;
}


@end
