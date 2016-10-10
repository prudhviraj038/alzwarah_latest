//
//  MenuViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuInfo.h"
#import "MenuTableViewCell.h"
#import "CouponsListViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *menuItems, *bottomMenuItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UINavigationController *transitionsNavigationController;
@property (weak, nonatomic) IBOutlet UITableView *tableViewBottom;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"categoryCell"];
    [self.tableView setRowHeight:35];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableViewBottom registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"categoryCell"];

    [self.tableViewBottom setRowHeight:35];
    self.tableViewBottom.backgroundColor = [UIColor clearColor];
    
    self.menuItems = [[NSMutableArray alloc] init];
    [self.menuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_home") withImageName:@"home.png" withId:@"1"]];
    [self.menuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_promotions") withImageName:@"promotions.png" withId:@"2"]];
    //[self.menuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_coupons") withImageName:@"promotions.png" withId:@"7"]];
    //[self.menuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_live_support") withImageName:@"live_support.png" withId:@"3"]];
    [self.menuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_cart") withImageName:@"cart.png" withId:@"4"]];
    [self.menuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_my_account") withImageName:@"my_account.png" withId:@"5"]];
    [self.menuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_notifications") withImageName:@"notifications.png" withId:@"6"]];
    //[self.menuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_picks_category") withImageName:@"picks_category.png" withId:@"7"]];
    
    self.bottomMenuItems = [[NSMutableArray alloc] init];
    [self.bottomMenuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_about_us") withImageName:@"about_us.png" withId:@"1"]];
    [self.bottomMenuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_what_we_do") withImageName:@"what_we_do.png" withId:@"2"]];
    [self.bottomMenuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_terms_and_conditions") withImageName:@"terms.png" withId:@"4"]];
    [self.bottomMenuItems addObject:[MenuInfo itemWithTitle:Localized(@"menu_contact_us") withImageName:@"contact_us.png" withId:@"3"]];

    self.transitionsNavigationController = (UINavigationController *) self.slidingViewController.topViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]]
                          withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.tableView == tableView) ? [self.menuItems count] : [self.bottomMenuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuInfo *info = (self.tableView == tableView) ? [self.menuItems objectAtIndex:indexPath.row] : [self.bottomMenuItems objectAtIndex:indexPath.row];
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
    if ([info.menuId isEqualToString:@"4"] && tableView == self.tableView) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [defaults objectForKey:@"products"];
        NSArray *temp = [NSKeyedUnarchiver unarchiveObjectWithData:data];

        cell.labelMenuTitle.text = [NSString stringWithFormat:@"%@ (%ld)", info.menuItem, [temp count]];
    } else {
        cell.labelMenuTitle.text = info.menuItem;
    }
    
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        cell.labelMenuTitle.textAlignment = NSTextAlignmentLeft;
    } else {
        cell.labelMenuTitle.textAlignment = NSTextAlignmentRight;
    }
    
    cell.imageViewMenu.image = [UIImage imageNamed:info.imageName];
    cell.imageViewMenu.contentMode = UIViewContentModeCenter;
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.tableView == tableView) {
        MenuInfo *info = [self.menuItems objectAtIndex:indexPath.row];
        if ([info.menuId isEqualToString:@"2"]) {
            [self.transitionsNavigationController setViewControllers:@[[APP_DELEGATE promotionsVC]]];
        } else if ([info.menuId isEqualToString:@"7"]) {
            [self.transitionsNavigationController setViewControllers:@[[APP_DELEGATE couponsVC]]];
        } else if ([info.menuId isEqualToString:@"1"]) {
            [self.transitionsNavigationController setViewControllers:@[[APP_DELEGATE homeVC]]];
        } else if ([info.menuId isEqualToString:@"4"]) {
//            if ([Utils loggedInUserId] == -1) {
//                [self.transitionsNavigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:[Utils getViewControllerWithId:@"LoginViewController"]] animated:YES completion:nil];
//            } else {
                [self.transitionsNavigationController setViewControllers:@[[APP_DELEGATE cartVC]]];
//            }
        } else if ([info.menuId isEqualToString:@"5"]) {
            if ([Utils loggedInUserId] == -1) {
                [self.transitionsNavigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:[Utils getViewControllerWithId:@"LoginViewController"]] animated:YES completion:nil];
            } else {
                [self.transitionsNavigationController setViewControllers:@[[APP_DELEGATE myAccountVC]]];
            }
            
        } else if ([info.menuId isEqualToString:@"6"]) {
            if ([Utils loggedInUserId] == -1) {
                [self.transitionsNavigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:[Utils getViewControllerWithId:@"LoginViewController"]] animated:YES completion:nil];
            } else {
                [self.transitionsNavigationController setViewControllers:@[[APP_DELEGATE notificationsVC]]];
            }
        }
    } else {
        MenuInfo *info = [self.bottomMenuItems objectAtIndex:indexPath.row];
        if ([info.menuId isEqualToString:@"1"]) {
            [self.transitionsNavigationController setViewControllers:@[[APP_DELEGATE aboutUsVC]]];
        } else if ([info.menuId isEqualToString:@"2"]) {
            //[self.transitionsNavigationController setViewControllers:@[[APP_DELEGATE whatWeDoVC]]];
            [self makePostCallForPage:PAGE_SETTINGS withParams:@{} withRequestCode:200];
        } else if ([info.menuId isEqualToString:@"3"]) {
            [self.transitionsNavigationController setViewControllers:@[[APP_DELEGATE contactUsVC]]];
        } else if ([info.menuId isEqualToString:@"4"]) {
            [self.transitionsNavigationController setViewControllers:@[[APP_DELEGATE termsVC]]];
        }
    }
    
    self.slidingViewController.topViewController = self.transitionsNavigationController;
    [self.slidingViewController resetTopViewAnimated:YES];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if (reqeustCode == 200) {
        NSDictionary *d = (NSDictionary *)result;
        NSString *url = [d valueForKey:@"itunes_link"];
        
        NSURL *myWebsite = [NSURL URLWithString:url];
        NSArray *objectsToShare = @[myWebsite];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
        NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                       UIActivityTypePrint,
                                       UIActivityTypeAssignToContact,
                                       UIActivityTypeSaveToCameraRoll,
                                       UIActivityTypeAddToReadingList,
                                       UIActivityTypePostToFlickr,
                                       UIActivityTypePostToVimeo];
        
        activityVC.excludedActivityTypes = excludeActivities;
        
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}

@end
