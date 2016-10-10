//
//  SelectAddressViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 26/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "SelectAddressViewController.h"
#import "UserAddressArea.h"

@interface SelectAddressViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic) NSMutableArray *categories;

@end

@implementation SelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categories = [[NSMutableArray alloc] init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close.png"] style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = 10;
        self.navItem.rightBarButtonItems = @[negativeSpacer, closeButton];
    } else {
        self.navItem.leftBarButtonItem = closeButton;
    }
    
    self.navItem.title = Localized(@"select_address");
    
    [self makePostCallForPage:PAGE_ADDRESS_LIST withParams:@{@"member_id":[Utils loggedInUserIdStr]} withRequestCode:1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated {
    self.view.layer.cornerRadius = 10;
    self.view.clipsToBounds = YES;
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    NSArray *array = (NSArray *)result;
    for (NSDictionary *dictionary in array) {
        [self.categories addObject:[UserAddress instanceFromDictionary:dictionary]];
    }
    [self.tableView reloadData];
}

- (void)close {
    [self.delegate cancelButtonClicked:self];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    UserAddress *cat = [self.categories objectAtIndex:indexPath.row];
    cell.textLabel.text = cat.alias;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.completionBlock([self.categories objectAtIndex:indexPath.row]);
    [self.delegate cancelButtonClicked:self];
}
@end
