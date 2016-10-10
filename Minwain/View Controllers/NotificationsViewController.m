//
//  NotificationsViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 17/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "NotificationsViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "Notification.h"
#import "NotificationTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "RestaurantDetailsViewController.h"

@interface NotificationsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) NSMutableArray *notifications;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.notifications = [[NSMutableArray alloc] init];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NotificationTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.rowHeight = 98;
    
    self.navigationItem.title = Localized(@"menu_notifications");
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    } else {
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//    }
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    [self.notifications removeAllObjects];
    for (NSDictionary *dictionary in result) {
        [self.notifications addObject:[Notification instanceFromDictionary:dictionary]];
    }
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self makePostCallForPage:PAGE_NOTIFICATIONS withParams:@{@"member_id":[Utils loggedInUserIdStr]} withRequestCode:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.notifications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    Notification *notification = [self.notifications objectAtIndex:indexPath.row];
    cell.labelTitle.text = notification.title;
    cell.labeMessage.text = notification.message;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:notification.time];
    cell.labelDate.text = [formatter stringFromDate:date];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.imageViewNotification setImageWithURL:[NSURL URLWithString:notification.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Notification *notification = [self.notifications objectAtIndex:indexPath.row];
    if ([notification.type isEqualToString:@"order"] || [notification.type isEqualToString:@"account"]) {
        self.navigationController.viewControllers = @[[APP_DELEGATE myAccountVC]];
    } else if ([notification.type isEqualToString:@"rest"]) {
        RestaurantDetailsViewController *vc = [Utils getViewControllerWithId:@"RestaurantDetailsViewController"];
        vc.restaurantId = notification.typeId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
