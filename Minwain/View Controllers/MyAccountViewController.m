//
//  MyAccountViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 17/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "MyAccountViewController.h"
#import "AddAddressViewController.h"
#import "UserAddress.h"
#import "UserAddressArea.h"
#import "UserOrder.h"
#import "UserOrderArea.h"
#import "UserOrderProduct.h"
#import "UserOrderRestaurant.h"
#import "OrderTableViewCell.h"
#import <NSDate+TimeAgo.h>
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "OrderDetailsViewController.h"
#import "PopViewControllerDelegate.h"
#import "UIViewController+MJPopupViewController.h"
#import "RateOrderViewController.h"

@interface MyAccountViewController () <UITabBarDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, PopViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;
@property (nonatomic) NSMutableArray *addresses;
@property (nonatomic) NSMutableArray *orders;
@property (weak, nonatomic) IBOutlet UITableView *tableViewOrders;

@property (weak, nonatomic) IBOutlet UIView *viewSettings;
@property (weak, nonatomic) IBOutlet UIView *viewOrders;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;
@property (weak, nonatomic) IBOutlet UIView *viewEditProfile;
@property (weak, nonatomic) IBOutlet UIView *viewAddresses;

@property (weak, nonatomic) IBOutlet UITabBarItem *itemOrders;
@property (weak, nonatomic) IBOutlet UITabBarItem *itemPassword;
@property (weak, nonatomic) IBOutlet UITabBarItem *itemProfile;
@property (weak, nonatomic) IBOutlet UITabBarItem *itemSettings;
@property (weak, nonatomic) IBOutlet UITabBarItem *itemAddress;

@property (weak, nonatomic) IBOutlet UITextField *editPassword;
@property (weak, nonatomic) IBOutlet UITextField *editConfirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonChangePassword;

@property (weak, nonatomic) IBOutlet UITextField *editFirstName;
@property (weak, nonatomic) IBOutlet UITextField *editLastName;
@property (weak, nonatomic) IBOutlet UITextField *editMobile;
@property (weak, nonatomic) IBOutlet UITextField *editEmail;
@property (weak, nonatomic) IBOutlet UITextField *editHomePhone;
@property (weak, nonatomic) IBOutlet UITextField *editWorkPhone;

@property (weak, nonatomic) IBOutlet UIButton *buttonSave;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddAddress;

@property (weak, nonatomic) IBOutlet UITableView *tableViewAddresses;

@property (weak, nonatomic) IBOutlet UIImageView *tickFirstName;
@property (weak, nonatomic) IBOutlet UIImageView *tickLastName;
@property (weak, nonatomic) IBOutlet UIImageView *tickMobile;
@property (weak, nonatomic) IBOutlet UIImageView *tickHomePhone;
@property (weak, nonatomic) IBOutlet UIImageView *tickWorkPhone;

@end

@implementation MyAccountViewController

- (IBAction)addNewAddress:(id)sender {
    AddAddressViewController *vc = [Utils getViewControllerWithId:@"AddAddressViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)changePassword:(id)sender {
    if ([self.editPassword.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_password")];
    } else if ([self.editConfirmPassword.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_confirm_password")];
    } else if (![self.editPassword.text isEqualToString:self.editConfirmPassword.text]) {
        [self showErrorAlertWithMessage:Localized(@"invalid_confirm_password")];
    } else {
        
        [self.editPassword resignFirstResponder];
        [self.editConfirmPassword resignFirstResponder];
        
        [self makePostCallForPage:PAGE_CHANGE_PASSWORD withParams:@{@"member_id":[Utils loggedInUserIdStr], @"password":self.editPassword.text, @"cpassword":self.editPassword.text} withRequestCode:100];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.editFirstName) {
        if ([textField.text length] > 0) {
            self.tickFirstName.hidden = NO;
        } else {
            self.tickFirstName.hidden = YES;
        }
    } else if (textField == self.editLastName) {
        if ([textField.text length] > 0) {
            self.tickLastName.hidden = NO;
        } else {
            self.tickLastName.hidden = YES;
        }
    } else if (textField == self.editMobile) {
        if ([textField.text length] > 0) {
            self.tickMobile.hidden = NO;
        } else {
            self.tickMobile.hidden = YES;
        }
    } else if (textField == self.editHomePhone) {
        if ([textField.text length] > 0) {
            self.tickHomePhone.hidden = NO;
        } else {
            self.tickHomePhone.hidden = YES;
        }
    } else if (textField == self.editWorkPhone) {
        if ([textField.text length] > 0) {
            self.tickWorkPhone.hidden = NO;
        } else {
            self.tickWorkPhone.hidden = YES;
        }
    }
}

- (IBAction)updateProfile:(id)sender {
    if ([self.editFirstName.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_first_name")];
    } else if ([self.editFirstName.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_last_name")];
    } else if ([self.editFirstName.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"empty_mobile")];
    } else {
        
        [self makePostCallForPage:PAGE_EDIT_PROFILE
                       withParams:@{
                                    @"fname":self.editFirstName.text,
                                    @"lname":self.editLastName.text,
                                    @"mobile":self.editMobile.text,
                                    @"home_phone":self.editHomePhone.text,
                                    @"work_phone":self.editWorkPhone.text,
                                    @"member_id":[Utils loggedInUserIdStr]
                                    }
                  withRequestCode:800];
        
    }
}

- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
    [self makePostCallForPage:PAGE_ORDER_LIST withParams:@{@"member_id":[Utils loggedInUserIdStr]} withRequestCode:400];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if (requestCode == 100) {
        self.editPassword.text = @"";
        self.editConfirmPassword.text = @"";
        [self showSuccessMessage:Localized(@"password_changed")];
    } else if (requestCode == 20) {
        [self.addresses removeAllObjects];
        
        NSArray *temp = (NSArray *)result;
        for (NSDictionary *dictionary in temp) {
            [self.addresses addObject:[UserAddress instanceFromDictionary:dictionary]];
        }
        
        [self.tableViewAddresses reloadData];
    } else if (reqeustCode == 300) {
        [self makePostCallForPage:PAGE_ADDRESS_LIST withParams:@{@"member_id":[Utils loggedInUserIdStr]} withRequestCode:20];
    } else if (reqeustCode == 400) {
        [self.orders removeAllObjects];
        
        NSArray *temp = (NSArray *)result;
        for (NSDictionary *dictionary in temp) {
            [self.orders addObject:[UserOrder instanceFromDictionary:dictionary]];
        }
        
        [self.tableViewOrders reloadData];
        [self makePostCallForPage:PAGE_ADDRESS_LIST withParams:@{@"member_id":[Utils loggedInUserIdStr]} withRequestCode:20];
    } else if (requestCode == 600) {
        NSDictionary *dictionary = (NSDictionary *)result;
        self.editFirstName.text = [dictionary valueForKey:@"fname"];
        self.editLastName.text = [dictionary valueForKey:@"lname"];
        self.editMobile.text = [dictionary valueForKey:@"mobile"];
        self.editHomePhone.text = [dictionary valueForKey:@"home_phone"];
        self.editWorkPhone.text = [dictionary valueForKey:@"home_phone"];
        
        [self makePostCallForPage:PAGE_ORDER_LIST withParams:@{@"member_id":[Utils loggedInUserIdStr]} withRequestCode:400];
    } else if (reqeustCode == 800) {
        [self showSuccessMessage:Localized(@"message_updated_profile")];
    }
}

- (void)logout {
    [Utils logoutUser];
    self.navigationController.viewControllers = @[[APP_DELEGATE homeVC]];
}

- (IBAction)selectArabic:(id)sender {
    [Utils setLanguage:KEY_LANGUAGE_AR];
    [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_AR];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self showErrorAlertWithMessage:Localized(@"restart_app")];
}

- (IBAction)selectEnglist:(id)sender {
    [Utils setLanguage:KEY_LANGUAGE_EN];
    [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_EN];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self showErrorAlertWithMessage:Localized(@"restart_app")];
}

- (void)viewWillAppear:(BOOL)animated {
    if ([Utils loggedInUserId] != -1) {
        [self makePostCallForPage:PAGE_USER_DETAILS withParams:@{@"member_id":[Utils loggedInUserIdStr]} withRequestCode:600];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableViewOrders.rowHeight = 174;
    [self.tableViewOrders registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableViewAddresses registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.addresses = [[NSMutableArray alloc] init];
    self.orders = [[NSMutableArray alloc] init];
    
    [self.itemOrders setTitle:Localized(@"my_orders")];
    [self.itemProfile setTitle:Localized(@"edit_profile")];
    [self.itemPassword setTitle:Localized(@"change_password")];
    [self.itemSettings setTitle:Localized(@"settings")];
    [self.itemAddress setTitle:Localized(@"address_list")];
    
    self.tableViewAddresses.backgroundColor = [UIColor clearColor];
    self.tableViewOrders.backgroundColor = [UIColor clearColor];
    
    [self.buttonAddAddress setTitle:Localized(@"add_address") forState:UIControlStateNormal];
    [self.buttonChangePassword setTitle:Localized(@"change_password") forState:UIControlStateNormal];
    [self.buttonSave setTitle:Localized(@"save") forState:UIControlStateNormal];

    self.editPassword.placeholder = Localized(@"password");
    self.editConfirmPassword.placeholder = Localized(@"confirm_password");
    
    self.editFirstName.placeholder = Localized(@"first_name");
    self.editLastName.placeholder = Localized(@"last_name");
    //self.editPassword2.placeholder = Localized(@"password");
    self.editMobile.placeholder = Localized(@"text_mobile");
    self.editEmail.placeholder = Localized(@"email_address");
    self.editHomePhone.placeholder = Localized(@"title_home_phone");
    self.editWorkPhone.placeholder = Localized(@"title_work_phone");
    
//    self.editArea.placeholder = Localized(@"text_area");
//    self.editBlock.placeholder = Localized(@"text_block");
//    self.editStreet.placeholder = Localized(@"text_street");
//    self.editHouse.placeholder = Localized(@"house");
//    self.editFloorNo.placeholder = Localized(@"floor");
//    self.editFlatNo.placeholder = Localized(@"flat_number");
//
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:Localized(@"logout") style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
//    } else {
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:Localized(@"logout") style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
//    }
    
    self.viewPassword.hidden = YES;
    self.viewEditProfile.hidden = YES;
    self.viewSettings.hidden = YES;
    self.viewAddresses.hidden = YES;
    
    self.navigationItem.title = Localized(@"menu_my_account");
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    if (item == self.itemOrders) {
        self.viewOrders.hidden = NO;
        self.viewPassword.hidden = YES;
        self.viewEditProfile.hidden = YES;
        self.viewSettings.hidden = YES;
        self.viewAddresses.hidden = YES;
    } else if (item == self.itemPassword) {
        self.viewOrders.hidden = YES;
        self.viewPassword.hidden = NO;
        self.viewEditProfile.hidden = YES;
        self.viewSettings.hidden = YES;
        self.viewAddresses.hidden = YES;
    } else if (item == self.itemProfile) {
        self.viewOrders.hidden = YES;
        self.viewPassword.hidden = YES;
        self.viewEditProfile.hidden = NO;
        self.viewSettings.hidden = YES;
        self.viewAddresses.hidden = YES;
    } else if (item == self.itemSettings) {
        self.viewOrders.hidden = YES;
        self.viewPassword.hidden = YES;
        self.viewEditProfile.hidden = YES;
        self.viewSettings.hidden = NO;
        self.viewAddresses.hidden = YES;
    } else if (item == self.itemAddress) {
        self.viewOrders.hidden = YES;
        self.viewPassword.hidden = YES;
        self.viewEditProfile.hidden = YES;
        self.viewSettings.hidden = YES;
        self.viewAddresses.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return (tableView == self.tableViewAddresses) ? YES : NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    UserAddress *address = [self.addresses objectAtIndex:indexPath.row];
    [self makePostCallForPage:PAGE_ADD_ADDRESS
                   withParams:@{@"member_id":[Utils loggedInUserIdStr], @"address_id":address.userAddressId}
              withRequestCode:300];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Localized(@"delete_address");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (tableView == self.tableViewAddresses) ? [self.addresses count] : [self.orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableViewAddresses) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        UserAddress *address = [self.addresses objectAtIndex:indexPath.row];
        cell.textLabel.text = address.alias;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (tableView == self.tableViewOrders){
        OrderTableViewCell *cell = [self.tableViewOrders dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        UserOrder *order = [self.orders objectAtIndex:indexPath.row];
        if ([order.rating intValue] == 0) {
            [cell.buttonRate setHidden:NO];
        } else {
            [cell.buttonRate setHidden:YES];
        }
        
        cell.rateOrderTapped = ^() {
            RateOrderViewController *vc = [[RateOrderViewController alloc] initWithNibName:@"RateOrderViewController" bundle:nil];
            vc.delegate = self;
            vc.orderId = order.userOrderId;
            [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
        };
        
        cell.labelTotal.text = [NSString stringWithFormat:@"%@: %@ %@", Localized(@"order_total"), Localized(@"currency"), order.totalPrice];
        cell.labelStatus.text = [NSString stringWithFormat:@"%@: %@", Localized(@"order_status"), order.deliveryStatus];
        cell.labelPaymentMethod.text = [NSString stringWithFormat:@"%@: %@", Localized(@"order_payment_method"), order.paymentMethod];
        cell.labelOrderId.text = [NSString stringWithFormat:@"%@: %@", Localized(@"order_id"), order.userOrderId];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:order.date];
        
        [cell.imageViewOrder setImageWithURL:[NSURL URLWithString:order.restaurant.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        
        cell.labelOderDate.text = [NSString stringWithFormat:@"%@: %@", Localized(@"order_date"), [date timeAgo]];
        cell.lableRestaurantTitle.text = order.restaurant.title;
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.tableViewAddresses) {
        AddAddressViewController *vc = [Utils getViewControllerWithId:@"AddAddressViewController"];
        vc.address = [self.addresses objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (tableView == self.tableViewOrders) {
        OrderDetailsViewController *vc = [Utils getViewControllerWithId:@"OrderDetailsViewController"];
        vc.order = [self.orders objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
