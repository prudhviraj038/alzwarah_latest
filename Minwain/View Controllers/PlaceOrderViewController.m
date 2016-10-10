//
//  PlaceOrderViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 20/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import "PlaceOrderAddressTableViewCell.h"
#import "SpecialRequestTableViewCell.h"
#import "PlaceOrderCouponTableViewCell.h"
#import "PlaceOrderProductsTableViewCell.h"
#import "Product.h"
#import "PlaceOrderHeader.h"
#import "PlaceOrderFooter.h"
#import "PlaceOrderPaymentTableViewCell.h"
#import "PaymentViewController.h"
#import "ProductRestaurant.h"
#import "ProductOption.h"
#import "ProductGroup.h"
#import "ProductAddon.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "OrderSummaryViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "PopViewControllerDelegate.h"
#import "SelectAddressViewController.h"
#import "PlaceOrderSelectAddressTableViewCell.h"
#import "UserAddress.h"
#import "UserAddressArea.h"
#import "AddAddressViewController.h"
#import "ProductRestaurantPayment.h"
#import "PaymentOption.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "DynamicPaymentTableViewCell.h"
#import "UserOrder.h"
#import <ActionSheetDatePicker.h>
#import "DeliveryDateTime.h"
#import "NSDate+MDExtension.h"
#import "MDDatePickerDialog.h"
#import "MDTimePickerDialog.h"

@interface PlaceOrderViewController () <UITableViewDelegate, UITableViewDataSource, PopViewControllerDelegate, MDDatePickerDialogDelegate, MDTimePickerDialogDelegate> {
    float deliveryCharges;
    float discount;
    NSString *couponCode;
    NSMutableArray *cells;
    NSString *deliveryDate, *deliveryTime;
    NSString *deliveryDatenow, *deliveryTimenow;
    NSString *noworlater;
    UserAddress *userAddress;
    
}
@property (nonatomic) ProductRestaurantPayment *payment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonPay;
@property (nonatomic) NSMutableArray *products;
@end

@implementation PlaceOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    couponCode = @"";
    noworlater = @"now";
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    deliveryTime=dateString;
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStringnow = [dateFormatter stringFromDate:currDate];
    deliveryDate=dateStringnow;

    self.navigationItem.title = Localized(@"title_checkout");
    
    self.products = [[NSMutableArray alloc] init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_datetime"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PlaceOrderSelectAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_address"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SpecialRequestTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_comments"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PlaceOrderCouponTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_coupons"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlaceOrderProductsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_product"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DynamicPaymentTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_payment"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DeliveryDateTime" bundle:nil] forCellReuseIdentifier:@"cell_delivery_date"];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"products"];
    
    [self.products removeAllObjects];
    [self.products addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.buttonPay setTitle:Localized(@"proceed_to_pay") forState:UIControlStateNormal];

    Product *product = [self.products objectAtIndex:0];
    if ([product.restaurant count] > 0) {
        ProductRestaurant *restaurant = [product.restaurant objectAtIndex:0];
        [self makePostCallForPage:PAGE_GET_CHARGES
                       withParams:@{@"rest_id":restaurant.productRestaurantId, @"area":[defaults valueForKey:@"areaId"]}
                  withRequestCode:10];
    }
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if (reqeustCode == 10) {
        deliveryCharges = [[result valueForKey:@"price"] floatValue];
    } else if (reqeustCode == 500) {
        NSDictionary *dictionary = (NSDictionary *)result;
        NSString *status = [dictionary valueForKey:@"status"];
        if ([status isEqualToString:@"Failure"]) {
            discount = 0;
            couponCode = @"";
            [self showErrorAlertWithMessage:[dictionary valueForKey:@"message"]];
        } else {
            NSString *type = [dictionary valueForKey:@"discount_type"];
            NSString *value = [dictionary valueForKey:@"discount_value"];
            
            if ([type isEqualToString:@"amount"]) {
                discount = [value floatValue];
            } else if ([type isEqualToString:@"percentage"]) {
                float totalPrice = 0;
                for (Product *product in self.products) {
                    totalPrice += ([product.price floatValue] * product.quantity);
                }
                
                discount = ([value floatValue] * totalPrice) / 100;
            }
        }
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3]
                      withRowAnimation:UITableViewRowAnimationNone];

    } else if (requestCode == 450) {
        NSDictionary *dictionary = (NSDictionary *)result;
        if ([[dictionary valueForKey:@"status"] isEqualToString:@"Success"]) {
            [self placeOrderToServer];
        } else {
            [self showErrorAlertWithMessage:[dictionary valueForKey:@"message"]];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)placeOrderToServer {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:@{
                            @"area": userAddress.area.userAddressAreaId,
                            @"block": userAddress.block,
                            @"street": userAddress.street,
                            @"building": userAddress.building,
                            @"floor": userAddress.floor,
                            @"flat": userAddress.appFlat,
                            @"mobile": userAddress.phone
                            }
                   forKey:@"address"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults valueForKey:@"comments"] length] > 0) {
        [dictionary setValue:[defaults valueForKey:@"comments"] forKey:@"comments"];
    } else {
        [dictionary setValue:@"" forKey:@"comments"];
    }
    
    [dictionary setValue:deliveryDate forKey:@"delivery_date"];
    [dictionary setValue:deliveryTime forKey:@"delivery_time"];

    /*
     PlaceOrderCouponTableViewCell *cellCoupon = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
     [dictionary setValue:cellCoupon.editCouponCode.text forKey:@"coupon_code"];
     */
    
    [dictionary setValue:couponCode forKey:@"coupon_code"];
    [dictionary setValue:[NSString stringWithFormat:@"%0.2f", discount] forKey:@"discount_amount"];
    
    [dictionary setValue:[Utils loggedInUserIdStr] forKey:@"member_id"];
    
    if ([self.payment.paymentId intValue] == 1) {
        [dictionary setValue:@"cash" forKey:@"payment_method"];
    } else if ([self.payment.paymentId intValue] == 3) {
        [dictionary setValue:@"credit_card" forKey:@"payment_method"];
    } else if ([self.payment.paymentId intValue] == 2) {
        [dictionary setValue:@"knet" forKey:@"payment_method"];
    }
    
    float totalPrice = 0;
    for (Product *product in self.products) {
        totalPrice += ([product.price floatValue] * product.quantity);
    }
    
    [dictionary setValue:[NSString stringWithFormat:@"%0.2f", totalPrice] forKey:@"price"];
    [dictionary setValue:[NSString stringWithFormat:@"%0.2f", deliveryCharges] forKey:@"delivery_charges"];
    [dictionary setValue:[NSString stringWithFormat:@"%0.2f", deliveryCharges + totalPrice] forKey:@"total_price"];
    
    Product *product = [self.products objectAtIndex:0];
    if ([product.restaurant count] > 0) {
        ProductRestaurant *restaurant = [product.restaurant objectAtIndex:0];
        [dictionary setValue:restaurant.productRestaurantId forKey:@"restaurant_id"];
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (Product *product in self.products) {
        NSMutableDictionary *p = [[NSMutableDictionary alloc] init];
        [p setValue:product.productId forKey:@"product_id"];
        [p setValue:product.comments forKey:@"special_request"];
        [p setValue:[NSString stringWithFormat:@"%d", product.quantity] forKey:@"quantity"];
        [p setValue:[NSString stringWithFormat:@"%0.2f", [product.price floatValue] * product.quantity] forKey:@"price"];
        
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (ProductOption *option in product.options) {
            if (option.selected) {
                [options addObject:@{@"option_id":option.optionId, @"price":option.price}];
            }
        }
        [p setObject:options forKey:@"options"];
        
        NSMutableArray *groups = [[NSMutableArray alloc] init];
        for (ProductGroup *group in product.group) {
            for (ProductAddon *addon in group.addons) {
                if (addon.selected) {
                    [groups addObject:@{@"addon_id":addon.addonId, @"price":addon.price}];
                }
            }
        }
        [p setObject:groups forKey:@"addons"];
        
        [array addObject:p];
    }
    [dictionary setObject:array forKey:@"products"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"json: %@", json);
    
    
    if (([self.payment.paymentId intValue] == 2) || ([self.payment.paymentId intValue] == 3)) {
        
        float totalPrice = 0;
        for (Product *product in self.products) {
            totalPrice += ([product.price floatValue] * product.quantity);
        }
        
        totalPrice += deliveryCharges;
        totalPrice -= discount;
        PaymentViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PaymentViewController"];
        vc.amount = [NSString stringWithFormat:@"%0.2f", totalPrice];
        vc.completionBlock = ^(NSString *status) {
            if ([status isEqualToString:@"success"]) {
                [self placeOrder:json];
            } else {
                [Utils showErrorAlertWithMessage:Localized(@"payment_failed")];
            }
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self placeOrder:json];
    }
}

- (IBAction)proceedToPay:(id)sender {
    if (userAddress == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_address")];
    } else if (self.payment == nil) {
        [self showErrorAlertWithMessage:Localized(@"empty_payment")];
    } else if (deliveryDate == nil ) {
        [self showErrorAlertWithMessage:Localized(@"empty_delivery_date")];
    } else if (deliveryTime == nil ) {
        [self showErrorAlertWithMessage:Localized(@"empty_delivery_time")];
    } else {
        
        Product *product = [self.products objectAtIndex:0];
        if ([product.restaurant count] > 0) {
            ProductRestaurant *restaurant = [product.restaurant objectAtIndex:0];
            [self makePostCallForPage:PAGE_DELIVERY_DATE_CHECK withParams:@{@"rest_id":restaurant.productRestaurantId, @"date":deliveryDate, @"time":deliveryTime} withRequestCode:450];
        }
    }
}

- (void)placeOrder:(NSString *)json {
    if (![Utils isOnline]) {
        [Utils showErrorAlertWithMessage:[MCLocalization stringForKey:@"internet_error"]];
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[[Utils createURLForPage:PAGE_PLACE_ORDER withParameters:nil] absoluteString] parameters:@{@"order":json} progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        
        [self.products removeAllObjects];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSData *adata = [NSKeyedArchiver archivedDataWithRootObject:self.products];
        [prefs setObject:adata forKey:@"products"];
        [prefs synchronize];
        
        //[self.navigationController popToRootViewControllerAnimated:YES];
        OrderSummaryViewController *vc = [Utils getViewControllerWithId:@"OrderSummaryViewController"];
        vc.order = [UserOrder instanceFromDictionary:responseObject];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
        
        [self showErrorAlertWithMessage:[error localizedDescription]];
    }];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    
    if (indexPath.section == 0) {
        height = 380;
    } else if (indexPath.section == 1) {
        height = 140;
    } else if (indexPath.section == 2) {
        height = 157;
    } else if (indexPath.section == 3) {
        height = 44;
    } else if (indexPath.section == 4) {
        height = 137;
    } else if (indexPath.section == 5) {
        height = 150;
    }
    
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 1;
            break;
        case 1:
            rows = 1;
            break;
        case 2:
            rows = 1;
            break;
        case 3:
            rows = [self.products count];
            break;
        case 4:
            rows = 1;
            break;
        case 5:
            rows = 1;
            break;
    }
    return rows;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        PlaceOrderHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"PlaceOrderHeader" owner:self options:nil] lastObject];
        return header;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 56;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 120;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3) {
        
        PlaceOrderFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"PlaceOrderFooter" owner:self options:nil] lastObject];
        float totalPrice = 0;
        for (Product *product in self.products) {
            totalPrice += ([product.price floatValue] * product.quantity);
        }
        
        footer.labelSubTotal.text = [NSString stringWithFormat:@"%0.2f %@", totalPrice, Localized(@"currency")];
        footer.labelDeliveryCharges.text = [NSString stringWithFormat:@"%0.2f %@", deliveryCharges, Localized(@"currency")];
        
        totalPrice += deliveryCharges;
        footer.labelGrandTotal.text = [NSString stringWithFormat:@"%@ %0.2f", Localized(@"currency"), totalPrice];
        footer.labelDiscount.text = [NSString stringWithFormat:@"%0.2f %@", discount, Localized(@"currency")];
        
        totalPrice -= discount;
        footer.labelGrandTotal.text = [NSString stringWithFormat:@"%0.2f %@", totalPrice, Localized(@"currency")];
        return footer;
    }
    
    return nil;
}

- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        PlaceOrderSelectAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_address" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.selectAddress = ^() {
            SelectAddressViewController *vc = [[SelectAddressViewController alloc] initWithNibName:@"SelectAddressViewController" bundle:nil];
            vc.delegate = self;
            vc.completionBlock = ^(UserAddress *address) {
                userAddress = address;
                cell.labelArea.text = address.area.title;
                cell.labelBlock.text = address.block;
                cell.labelStreet.text = address.street;
                cell.labelBuilding.text = address.building;
                cell.labelFloor.text = address.floor;
                cell.labbelFlat.text = address.appFlat;
                cell.labelMobile.text = address.phone;
            };
            [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
        };
        
        cell.addAddress = ^() {
            AddAddressViewController *vc = [Utils getViewControllerWithId:@"AddAddressViewController"];
            Product *product = [self.products objectAtIndex:0];
            if ([product.restaurant count] > 0) {
                ProductRestaurant *restaurant = [product.restaurant objectAtIndex:0];
                vc.restId = restaurant.productRestaurantId;
            }
            
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        cell.editAddress = ^() {
            if (userAddress == nil) {
                [self showErrorAlertWithMessage:Localized(@"empty_address")];
            } else {
                AddAddressViewController *vc = [Utils getViewControllerWithId:@"AddAddressViewController"];
                vc.address = userAddress;
                vc.editedAddress = ^(UserAddress *address) {
                    userAddress = address;
                    cell.labelArea.text = address.area.title;
                    cell.labelBlock.text = address.block;
                    cell.labelStreet.text = address.street;
                    cell.labelBuilding.text = address.building;
                    cell.labelFloor.text = address.floor;
                    cell.labbelFlat.text = address.appFlat;
                    cell.labelMobile.text = address.phone;
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_comments" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        PlaceOrderCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_coupons" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.applyCoupon = ^(NSString *code) {
            couponCode = code;
            Product *product = [self.products objectAtIndex:0];
            if ([product.restaurant count] > 0) {
                
                float totalPrice = 0;
                for (Product *product in self.products) {
                    totalPrice += ([product.price floatValue] * product.quantity);
                }
                
                totalPrice += deliveryCharges;
                
                ProductRestaurant *restaurant = [product.restaurant objectAtIndex:0];
                [self makePostCallForPage:PAGE_COUPON_CHECK
                               withParams:@{@"rest_id":restaurant.productRestaurantId,
                                            @"cart_total":[NSString stringWithFormat:@"%0.2f", totalPrice],
                                            @"coupon":code}
                          withRequestCode:500];
            }
            
        };
        return cell;
    } else if (indexPath.section == 3) {
        PlaceOrderProductsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_product" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Product *product = [self.products objectAtIndex:indexPath.row];
        cell.labeltitle.text = product.title;
        cell.labelQty.text = [NSString stringWithFormat:@"%d x %0.2f", product.quantity, [product.price floatValue]];
        cell.labelPrice.text = [NSString stringWithFormat:@"%0.2f %@", (product.quantity * [product.price floatValue]), Localized(@"currency")];
        return cell;
    } else if (indexPath.section == 5) {
        DynamicPaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_payment" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (UIView *v in cell.viewContainer.subviews) {
            [v removeFromSuperview];
        }
        
        Product *product = [self.products objectAtIndex:0];
        if ([product.restaurant count] > 0) {
            ProductRestaurant *restaurant = [product.restaurant objectAtIndex:0];
            int size = (self.view.frame.size.width - 26) / restaurant.payment.count;
            for (int index = 0; index < restaurant.payment.count; index++) {
                ProductRestaurantPayment *payment = [restaurant.payment objectAtIndex:index];
                PaymentOption *option = [[[NSBundle mainBundle] loadNibNamed:@"PaymentOption" owner:self options:nil] lastObject];
                option.frame = CGRectMake(index * size, 20, size, 80);
                
                [option.imageViewMethod setImageWithURL:[NSURL URLWithString:payment.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                [cell.viewContainer addSubview:option];
                option.isSelected = payment.selected;
                
                option.changeStatus = ^(BOOL status) {
                    self.payment = nil;
                    if (status) {
                        self.payment = payment;
                        payment.selected = YES;
                        
                        for (ProductRestaurantPayment *payment in restaurant.payment) {
                            payment.selected = NO;
                        }
                        
                        payment.selected = YES;
                    }
                    
                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
                };
            }
        }
        return cell;
    } else if (indexPath.section == 4) {
        DeliveryDateTime *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_delivery_date" forIndexPath:indexPath];
        
        if([noworlater isEqualToString:@"now"])
        {
            cell.check_box_now.alpha=1;
            cell.check_box_later.alpha=0;
        }else{
            cell.check_box_now.alpha=0;
            cell.check_box_later.alpha=1;

        }
        
        
        if([noworlater isEqualToString:@"now"])
        cell.labelDate.text = @"date";
        else
        cell.labelDate.text = deliveryDate;
        
        if([noworlater isEqualToString:@"now"])
            cell.labelTime.text = @"time";
        else
            cell.labelTime.text = deliveryTime;
        

        cell.delSelectnow = ^ (){
            noworlater=@"now";
            NSDate *currDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"HH:mm"];
            NSString *dateString = [dateFormatter stringFromDate:currDate];
            cell.labeltimenow.text=dateString;
            deliveryTime=dateString;
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateStringnow = [dateFormatter stringFromDate:currDate];
            deliveryDate=dateStringnow;
            cell.labelDate.text = @"date";
            cell.labelTime.text = @"time";

        };
        
        cell.delSelectlater = ^ (){
            noworlater=@"later";
        };
        
        cell.timeSelect = ^() {
            noworlater=@"later";

            MDTimePickerDialog *timePicker = [[MDTimePickerDialog alloc] init];
            timePicker.delegate = self;            
            [timePicker show];
        };
        
        cell.dateSelect = ^() {
            noworlater=@"later";
            NSDate *date = [NSDate date];
            MDDatePickerDialog *datePicker = [[MDDatePickerDialog alloc] init];
            datePicker = datePicker;
            datePicker.minimumDate = date;
            datePicker.selectedDate = date;
            datePicker.delegate = self;
            datePicker.header.textColor = [UIColor colorWithRed:0.916  green:0.659  blue:0 alpha:1];
            datePicker.header.backgroundColor = [UIColor colorWithRed:0.916  green:0.659  blue:0 alpha:1];
            
            [datePicker show];
        };
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - datepicker

- (void)datePickerDialogDidSelectDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    deliveryDate = [formatter stringFromDate:date];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - timepicker

- (void)timePickerDialog:(MDTimePickerDialog *)timePickerDialog
           didSelectHour:(NSInteger)hour
               andMinute:(NSInteger)minute {
    deliveryTime = [NSString stringWithFormat:@"%.2li:%.2li", (long)hour, (long)minute];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
}

@end

