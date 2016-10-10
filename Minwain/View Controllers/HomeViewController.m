//
//  HomeViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "ProductRestaurant.h"
#import "ProductRestaurantCategory.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "TrendingCollectionViewCell.h"
#import "PopViewControllerDelegate.h"
#import "UIViewController+MJPopupViewController.h"
#import "SelectRestaurantCategoryViewController.h"
#import "CountryArea.h"
#import "SelectAreaViewController.h"
#import "SearchRestaurantsViewController.h"
#import "RestaurantDetailsViewController.h"
#import "AdvertisementViewController.h"
#import "LanguageViewController.h"

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, PopViewControllerDelegate> 
@property (nonnull) NSMutableArray *trendingProducts;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *buttonCategory;
@property (weak, nonatomic) IBOutlet UIButton *buttonArea;
@property (nonatomic) CountryArea *area;
@property (nonatomic) ProductRestaurantCategory *category;
@property (weak, nonatomic) IBOutlet UILabel *labelTrending;
@property (weak, nonatomic) IBOutlet UIButton *buttonOrder;
@property (weak, nonatomic) IBOutlet UIButton *buttonChooseArea;
@property (weak, nonatomic) IBOutlet UIButton *buttonChoose;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self.buttonArea setTitle:Localized(@"choose_area") forState:UIControlStateNormal];
    [self.buttonOrder setTitle:Localized(@"what_do_you_want") forState:UIControlStateNormal];
    [self.buttonChoose setTitle:@"Search Restaurants" forState:UIControlStateNormal];
    
    
    self.labelTrending.text = Localized(@"title_trending");
    
    self.trendingProducts = [[NSMutableArray alloc] init];
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    self.navigationItem.title = Localized(@"");
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
    
    UIView *viewButtons = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    
    UIButton *buttonLanguage = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonLanguage setBackgroundImage:[UIImage imageNamed:@"button_background_icon.png"] forState:UIControlStateNormal];
    [buttonLanguage addTarget:self action:@selector(switchLanguage) forControlEvents:UIControlEventTouchUpInside];
    [viewButtons addSubview:buttonLanguage];
    
    
    UIButton *buttonUser = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonUser setBackgroundImage:[UIImage imageNamed:@"button_background_icon.png"] forState:UIControlStateNormal];
    [buttonUser setImage:[UIImage imageNamed:@"user.png"] forState:UIControlStateNormal];
    [buttonUser addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchUpInside];
    [viewButtons addSubview:buttonUser];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [buttonLanguage setTitle:@"EN" forState:UIControlStateNormal];
        buttonLanguage.frame = CGRectMake(0, 2, 35, 35);
        buttonUser.frame = CGRectMake(38, 2, 35, 35);
    } else {
        buttonUser.frame = CGRectMake(0, 2, 35, 35);
        buttonLanguage.frame = CGRectMake(38, 2, 35, 35);
        [buttonLanguage setTitle:@"AR" forState:UIControlStateNormal];
    }
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:viewButtons];
    
//    } else {
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user.png"] style:UIBarButtonItemStyleDone target:self action:@selector(loginUser)];
//    }
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TrendingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    if ([Utils isOnline]) {
        if ([[Utils getLanguage] length] == 0) {
            LanguageViewController *vc = [Utils getViewControllerWithId:@"LanguageViewController"];
            [self presentViewController:vc animated:YES completion:nil];
        } else {
            [self makePostCallForPage:PAGE_GET_RESTAURANTS withParams:@{@"type":@"trending"} withRequestCode:1];
            AdvertisementViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AdvertisementViewController"];
            [self presentViewController:vc animated:YES completion:nil];
        }
    } else {
        [Utils showErrorAlertWithMessage:[MCLocalization stringForKey:@"internet_error"]];
    }
}

- (void)switchLanguage {
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [Utils setLanguage:KEY_LANGUAGE_EN];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_EN];
        //[self showErrorAlertWithMessage:Localized(@"restart_app")];
    } else {
        [Utils setLanguage:KEY_LANGUAGE_AR];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_AR];
        //[self showErrorAlertWithMessage:Localized(@"restart_app")];
    }
    
    [APP_DELEGATE reloadUI];
}


- (void)viewWillAppear:(BOOL)animated {
    if ([APP_DELEGATE notificationRestaurantId]) {
        RestaurantDetailsViewController *vc = [Utils getViewControllerWithId:@"RestaurantDetailsViewController"];
        vc.restaurantId = [APP_DELEGATE notificationRestaurantId];
        [self.navigationController pushViewController:vc animated:YES];
        [APP_DELEGATE setNotificationRestaurantId:nil];
    }
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if (reqeustCode == 1) {
        NSArray *array = (NSArray *)result;
        [self.trendingProducts removeAllObjects];
        for (NSDictionary *dictionary in array) {
            [self.trendingProducts addObject:[ProductRestaurant instanceFromDictionary:dictionary]];
        }
        
        [self.collectionView reloadData];
        
        NSString *memberId = [Utils loggedInUserIdStr];
        if ([memberId length] == 0) {
            memberId = @"0";
        }
        
        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"];
        if ([deviceToken length] == 0) {
            deviceToken = @"";
        }
        [self makePostCallForPage:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken, @"member_id":[Utils loggedInUserIdStr]} withRequestCode:100];
        
    }
}

- (void)loginUser {
    if ([Utils loggedInUserId] == -1) {
        LoginViewController *vc = [Utils getViewControllerWithId:@"LoginViewController"];
        [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    } else {
        [self.navigationController pushViewController:[APP_DELEGATE myAccountVC] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}

- (IBAction)showRestaurantCategories:(id)sender {
    SelectRestaurantCategoryViewController *vc = [[SelectRestaurantCategoryViewController alloc] initWithNibName:@"SelectRestaurantCategoryViewController" bundle:nil];
    vc.delegate = self;
    vc.completionBlock = ^(ProductRestaurantCategory *category) {
        self.category = category;
        [self.buttonCategory setTitle:category.title forState:UIControlStateNormal];
    };
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
}

- (IBAction)chooseArea:(id)sender {
    SelectAreaViewController *vc = [[SelectAreaViewController alloc] initWithNibName:@"SelectAreaViewController" bundle:nil];
    vc.delegate = self;
    vc.completionBlock = ^(CountryArea *area) {
        self.area = area;
        [self.buttonArea setTitle:area.title forState:UIControlStateNormal];
    };
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
}

- (IBAction)searchRestaurants:(id)sender {
    if(self.category==nil){
        [self showErrorAlertWithMessage:Localized(@"empty_category")];
    }
    if (self.area == nil) {
        [self showErrorAlertWithMessage:Localized(@"empty_area")];
    } else {
        SearchRestaurantsViewController *vc = [Utils getViewControllerWithId:@"SearchRestaurantsViewController"];
        vc.areaCode = self.area;
        vc.category = self.category;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark collectionview

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.trendingProducts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TrendingCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ProductRestaurant *restaurant = [self.trendingProducts objectAtIndex:indexPath.row];
    cell.labelTitle.text = restaurant.title;
    [cell.imageViewProduct setImageWithURL:[NSURL URLWithString:restaurant.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantDetailsViewController *vc = [Utils getViewControllerWithId:@"RestaurantDetailsViewController"];
    vc.restaurant = [self.trendingProducts objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
