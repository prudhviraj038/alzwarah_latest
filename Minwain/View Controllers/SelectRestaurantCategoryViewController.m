//
//  SelectRestaurantCategoryViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "SelectRestaurantCategoryViewController.h"


@interface SelectRestaurantCategoryViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic) NSMutableArray *categories;
@end

@implementation SelectRestaurantCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categories = [[NSMutableArray alloc] init];
    
    ///[self.tableView registerClass:[AppTableViewCell class] forCellReuseIdentifier:@"cell"];
    
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
    
    self.navItem.title = Localized(@"title_select_category");
    
    [self makePostCallForPage:PAGE_GET_RESTAURANT_CATEGORIES withParams:@{} withRequestCode:1];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.layer.cornerRadius = 10;
    self.view.clipsToBounds = YES;
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    NSArray *array = (NSArray *)result;
    for (NSDictionary *dictionary in array) {
        [self.categories addObject:[ProductRestaurantCategory instanceFromDictionary:dictionary]];
    }
    [self.tableView reloadData];
}

- (void)close {
    [self.delegate cancelButtonClicked:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[AppTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    ProductRestaurantCategory *cat = [self.categories objectAtIndex:indexPath.row];
    cell.textLabel.text = cat.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.completionBlock([self.categories objectAtIndex:indexPath.row]);
    [self.delegate cancelButtonClicked:self];
}

@end
