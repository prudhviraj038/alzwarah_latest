//
//  OrderDetailsViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 27/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "OrderDetailsAddressTableViewCell.h"

#import "UserOrder.h"
#import "UserOrderArea.h"
#import "UserOrderProduct.h"
#import "UserOrderRestaurant.h"

#import "Product.h"
#import "PlaceOrderHeader.h"
#import "PlaceOrderFooter.h"

#import "OrderHistoryHeader.h"
#import "OrderHistoryFooter.h"
#import "UserOrderHistory.h"

#import "HistoryItemCell.h"

#import "PlaceOrderProductsTableViewCell.h"

@interface OrderDetailsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = Localized(@"order_details");
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderDetailsAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_address"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PlaceOrderProductsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_product"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryItemCell" bundle:nil] forCellReuseIdentifier:@"cell_history"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    switch (indexPath.section) {
        case 0:
            height = 359;
            break;
        case 1:
            height = 44;
            break;
        case 2:
            height = 44;
            break;
    }
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        PlaceOrderHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"PlaceOrderHeader" owner:self options:nil] lastObject];
        return header;
    } else if (section == 2) {
        OrderHistoryHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"OrderHistoryHeader" owner:self options:nil] lastObject];
        return header;
    }


    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 56;
    } else if (section == 2) {
        return 56;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 120;
    } else if (section == 2) {
        return 22;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 1;
            break;
        case 1:
            rows = [self.order.products count];
            break;
        case 2:
            rows = [self.order.history count];
            break;
            
        default:
            break;
    }
    return rows;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        PlaceOrderFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"PlaceOrderFooter" owner:self options:nil] lastObject];
        float totalPrice = 0;
        for (UserOrderProduct *product in self.order.products) {
            totalPrice += ([product.price floatValue] * [product.quantity intValue]);
        }
        
        footer.labelSubTotal.text = [NSString stringWithFormat:@"%@ %0.2f", Localized(@"currency"), totalPrice];
        footer.labelDeliveryCharges.text = [NSString stringWithFormat:@"%@ %0.2f", Localized(@"currency"), [self.order.deliveryCharges floatValue]];
        
        totalPrice += [self.order.deliveryCharges floatValue];
        footer.labelGrandTotal.text = [NSString stringWithFormat:@"%@ %0.2f", Localized(@"currency"), totalPrice];
        footer.labelDiscount.text = [NSString stringWithFormat:@"%@ %0.2f", Localized(@"currency"), [self.order.discountAmount floatValue]];
        
        totalPrice -= [self.order.discountAmount floatValue];
        footer.labelGrandTotal.text = [NSString stringWithFormat:@"%@ %0.2f", Localized(@"currency"), totalPrice];
        return footer;
    } else if (section == 2) {
        OrderHistoryFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"OrderHistoryFooter" owner:self options:nil] lastObject];
        return footer;
    }
    
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        OrderDetailsAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_address" forIndexPath:indexPath];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:self.order.date];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        cell.labelOrderId.text = self.order.userOrderId;
        cell.labelOrderDate.text = [formatter stringFromDate:date];
        cell.labelBlock.text = self.order.block;
        cell.labelArea.text = self.order.area.title;
        cell.labelStreet.text = self.order.street;
        cell.labelBuilding.text = self.order.building;
        cell.labelFloor.text = self.order.floor;
        cell.labbelFlat.text = self.order.flat;
        cell.labelMobile.text = self.order.phone;
        return cell;
    } else if (indexPath.section == 1) {
        PlaceOrderProductsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_product" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UserOrderProduct *product = [self.order.products objectAtIndex:indexPath.row];
        cell.labeltitle.text = product.productName;
        cell.labelQty.text = [NSString stringWithFormat:@"%@ x %0.2f", product.quantity, [product.price floatValue]];
        cell.labelPrice.text = [NSString stringWithFormat:@"%0.2f %@", ([product.quantity floatValue] * [product.price floatValue]), Localized(@"currency")];
        return cell;
    } else if (indexPath.section == 2) {
        HistoryItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_history" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UserOrderHistory *history = [self.order.history objectAtIndex:indexPath.row];
        cell.labeltitle.text = history.message;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *d = [formatter dateFromString:history.time];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        cell.labelPrice.text = [formatter stringFromDate:d];
        return cell;
    }
    
    return nil;
}


@end
