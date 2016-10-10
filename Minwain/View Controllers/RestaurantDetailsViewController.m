//
//  RestaurantDetailsViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 13/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "RestaurantDetailsViewController.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "RestaurantDetailsAboutTableViewCell.h"
#import "RestaurantDetailsInfoTableViewCell.h"
#import "ProductRestaurantCategory.h"
#import "ProductArea.h"
#import "SelectAreaViewController.h"
#import <RateView.h>
#import "PopViewControllerDelegate.h"
#import "UIViewController+MJPopupViewController.h"
#import "MenuListViewController.h"
#import "PromotionsViewController.h"
#import "ProductRestaurantPayment.h"
#import "PromotionTableViewCell.h"
#import "ProductRestaurantPromotion.h"
#import "ReviewTableViewCell.h"

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface RestaurantDetailsViewController () <UITableViewDelegate, UITableViewDataSource, PopViewControllerDelegate> {
    DetailsMode detailsMode;
    float charges;
    BOOL showSelectArea;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *starAlignment;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBanner;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRestaurantIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelInfo;
@property (weak, nonatomic) IBOutlet UILabel *labelReviews;
@property (weak, nonatomic) IBOutlet UIButton *buttonShowMenu;
@property (strong, nonatomic) UIColor *underline_color;

@end

@implementation RestaurantDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabindex=0;
    [self.imageViewBanner setImageWithURL:[NSURL URLWithString:self.restaurant.banner] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.underline_color = [UIColor magentaColor];
    
    self.underline_color = Rgb2UIColor(247,228,230
);
    
    showSelectArea = (self.selectedArea == nil);
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.buttonShowMenu setTitle:Localized(@"show_menu") forState:UIControlStateNormal];
    self.buttonShowMenu.layer.cornerRadius = self.buttonShowMenu.frame.size.height/2;
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        self.starAlignment.constant = 20;
    } else {
        self.starAlignment.constant = -20;
    }
    
    
    /*
    NSMutableString *categories = [[NSMutableString alloc] init];
    for (ProductRestaurantCategory *cat in self.restaurant.category) {
        if ([categories length] == 0) {
            [categories appendFormat:@"%@", cat.title];
        } else {
            [categories appendFormat:@", %@", cat.title];
        }
    }
    self.labelInfo.text = categories;
    */

    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"show_menu_cell"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"select_area_cell"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"promotions_cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RestaurantDetailsAboutTableViewCell" bundle:nil] forCellReuseIdentifier:@"about_cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RestaurantDetailsInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"info_cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PromotionTableViewCell" bundle:nil] forCellReuseIdentifier:@"res_offers_cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReviewTableViewCell" bundle:nil] forCellReuseIdentifier:@"res_reviews_cell"];
    

    
    
    self.imageViewRestaurantIcon.layer.cornerRadius = 10;
    self.imageViewRestaurantIcon.clipsToBounds = YES;
    
    if (self.restaurant) {
        [self.imageViewRestaurantIcon setImageWithURL:[NSURL URLWithString:self.restaurant.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.labelInfo.text = self.restaurant.smallDescription;
        self.labelReviews.text = [NSString stringWithFormat:@"(%d)", [self.restaurant.reviews intValue]];
        self.labelTitle.text = self.restaurant.title;
        
        RateView *rv = [RateView rateViewWithRating:[self.restaurant.rating floatValue]];
        rv.starSize = 15;
        rv.starFillColor = [UIColor whiteColor];
        rv.starBorderColor = [UIColor whiteColor];
        rv.starFillMode = StarFillModeHorizontal;
        [self.ratingView addSubview:rv];
    } else  {
        [self makePostCallForPage:PAGE_GET_RESTAURANTS withParams:@{@"rest_id":self.restaurantId} withRequestCode:400];
    }
    self.res_info_line.alpha=1;
    self.res_reviews_line.alpha=0;
    self.res_offers_line.alpha=0;
    self.res_offers_btn.backgroundColor = [UIColor clearColor];
    self.res_info_btn.backgroundColor = self.underline_color;
    self.res_reviews_btn.backgroundColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.selectedArea != nil) {
        [self makePostCallForPage:PAGE_CHARGES withParams:@{@"rest_id":self.restaurant.productRestaurantId, @"area":self.selectedArea.countryAreaId} withRequestCode:1];
    }
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    if (reqeustCode == 1) {
        NSDictionary *dictionary = (NSDictionary *)result;
        charges = [[dictionary valueForKey:@"price"] floatValue];
        
        [self.tableView reloadData];
    } else if (reqeustCode == 400) {
        self.restaurant = [ProductRestaurant instanceFromDictionary:[result objectAtIndex:0]];
        [self.imageViewRestaurantIcon setImageWithURL:[NSURL URLWithString:self.restaurant.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.labelInfo.text = self.restaurant.smallDescription;
        self.labelReviews.text = [NSString stringWithFormat:@"(%d)", [self.restaurant.reviews intValue]];
        self.labelTitle.text = self.restaurant.title;
        
        RateView *rv = [RateView rateViewWithRating:[self.restaurant.rating floatValue]];
        rv.starSize = 15;
        rv.starFillColor = [UIColor whiteColor];
        rv.starBorderColor = [UIColor whiteColor];
        rv.starFillMode = StarFillModeHorizontal;
        [self.ratingView addSubview:rv];
        
        [self.tableView reloadData];
    }
}

- (IBAction)showMenu:(id)sender {
    if (self.selectedArea == nil) {
        [self showErrorAlertWithMessage:Localized(@"empty_area")];
    } else {
        if ([self.restaurant.menu count] == 0) {
            [self showErrorAlertWithMessage:Localized(@"empty_restaurant_menu")];
        } else {
            MenuListViewController *vc = [Utils getViewControllerWithId:@"MenuListViewController"];
            vc.menus = self.restaurant.menu;
            vc.selectedRestaurant = self.restaurant;
            vc.area = self.selectedArea;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 2) {
//        if (showSelectArea) {
//            return 1;
//        } else {
//            return 0;
//        }
//        
//    } else if (section == 1) {
//        if ([self.restaurant.promotions count] > 0) {
//            return 1;
//        } else {
//            return 0;
//        }
//    } else if (section == 0) {
//        return 2;
//    }
    if(self.tabindex == 0)
        return 1;
    else if(self.tabindex == 1)
        return self.restaurant.promotions.count;
    else if(self.tabindex == 2)
        return 5;
    
    return 1;
}

#define FONT_SIZE 15.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 20.0f

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float height = 350;
    
//    if (indexPath.section == 2) {
//        if (indexPath.row == 0) {
//            NSString *text = [NSString stringWithFormat:@"\n\n%@", self.restaurant.descriptionText];
//            NSLog(@"text:%@",text);
//            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
//            CGRect textRect = [text boundingRectWithSize:constraint
//                                                 options:NSStringDrawingUsesLineFragmentOrigin
//                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}
//                                                 context:nil];
//            
//            height = textRect.size.height + 0;
//        } else if (indexPath.row == 1) {
//            height = 350;
//        }
//    }
    if(self.tabindex==1)
        return 73;
    else if (self.tabindex==2)
        return 60;
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 3) {
//        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"select_area_cell"];
//        
//        UILabel *labelMenu = [cell.contentView viewWithTag:100];
//        if (labelMenu == nil) {
//            labelMenu = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.view.frame.size.width - 40, 40)];
//            labelMenu.backgroundColor = [UIColor whiteColor];
//            labelMenu.textColor = [UIColor blackColor];
//            labelMenu.layer.cornerRadius = 5;
//            labelMenu.clipsToBounds = YES;
//            labelMenu.tag = 100;
//            labelMenu.textAlignment = NSTextAlignmentCenter;
//            cell.backgroundColor = [UIColor clearColor];
//            [cell.contentView addSubview:labelMenu];
//        }
//        
//        if (self.selectedArea == nil) {
//            labelMenu.text = Localized(@"select_area");
//        } else {
//            labelMenu.text = self.selectedArea.title;
//        }
//        
//        return cell;
//    } else if (indexPath.section == 1) {
//        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"promotions_cell"];
//        UILabel *labelMenu = [cell.contentView viewWithTag:100];
//        if (labelMenu == nil) {
//            labelMenu = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.view.frame.size.width - 40, 40)];
//            labelMenu.backgroundColor = [UIColor whiteColor];
//            labelMenu.textColor = [UIColor blackColor];
//            labelMenu.layer.cornerRadius = 5;
//            labelMenu.clipsToBounds = YES;
//            labelMenu.tag = 100;
//            labelMenu.textAlignment = NSTextAlignmentCenter;
//            cell.backgroundColor = [UIColor clearColor];
//            [cell.contentView addSubview:labelMenu];
//        }
//        labelMenu.text = Localized(@"title_promotions");
//        return cell;
//    } else if (indexPath.section == 2) {
//        if (indexPath.row == 0) {
//            RestaurantDetailsAboutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"about_cell"];
//            cell.labelAbout.text = [NSString stringWithFormat:@"%@", self.restaurant.title];
//            
//            NSString *str = [NSString stringWithFormat:@"\n\n%@", self.restaurant.descriptionText];
////            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
////            cell.labelDescription.attributedText = attrStr;
//            cell.labelDescription.text = str;
//            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor = [UIColor clearColor];
//            cell.contentView.backgroundColor = [UIColor clearColor];
//            
//            
//            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
//            CGRect textRect = [self.restaurant.descriptionText boundingRectWithSize:constraint
//                                                                            options:NSStringDrawingUsesLineFragmentOrigin
//                                                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]}
//                                                                            context:nil];
//            
//            float height = textRect.size.height + 0;
//            CGRect rect = cell.labelDescription.frame;
//            rect.size.height = height;
//            cell.labelDescription.frame = rect;
//            
//            return cell;

//        } else
    
//if (indexPath.row == 0) {
    
    if(self.tabindex==0){
            RestaurantDetailsInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"info_cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            
            if (self.selectedArea == nil) {
                cell.labelArea.text = Localized(@"select_area");
                cell.labelStatus.text = Localized(@"select_area");
                cell.labelCuisines.text = Localized(@"select_area");
                cell.labelWorkingHrs.text = Localized(@"select_area");
                cell.labelDeliveryTime.text = Localized(@"select_area");
                cell.labelMinOrder.text = Localized(@"select_area");
                cell.labelDeliveryCharges.text = Localized(@"select_area");
                cell.labelPaymentType.text = Localized(@"select_area");
            } else {
            
                for (int index = 0; index < [self.restaurant.payment count]; index++) {
                    ProductRestaurantPayment *payment = [self.restaurant.payment objectAtIndex:index];
                    float x = 0;
                    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
                        x = index * 25;
                    } else {
                        x = 100 - (index * 25);
                    }
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, 24, 20)];
                    [imageView setImageWithURL:[NSURL URLWithString:payment.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                    [cell.viewPayment addSubview:imageView];
                }
                
                /*
                NSMutableString *area = [[NSMutableString alloc] init];
                for (ProductArea *a in self.restaurant.area) {
                    if ([area length] == 0) {
                        [area appendString:a.title];
                    } else {
                        [area appendFormat:@", %@", a.title];
                    }
                }*/
                cell.labelArea.text = self.selectedArea.title;
                cell.labelStatus.text = self.restaurant.currentStatus;
                
                NSMutableString *categories = [[NSMutableString alloc] init];
                for (ProductRestaurantCategory *cat in self.restaurant.category) {
                    if ([categories length] == 0) {
                        [categories appendFormat:@"%@", cat.title];
                    } else {
                        [categories appendFormat:@", %@", cat.title];
                    }
                }
                
                cell.labelCuisines.text = categories;
                cell.labelWorkingHrs.text = self.restaurant.hours;
                cell.labelDeliveryTime.text = self.restaurant.time;
                cell.labelMinOrder.text = [NSString stringWithFormat:@"KD %0.2f", [self.restaurant.minimum floatValue]];
                cell.labelDeliveryCharges.text = [NSString stringWithFormat:@"KD %0.2f", charges];
                
                if ([self.restaurant.payment count] > 0) {
                    NSDictionary *dictionary = [self.restaurant.payment objectAtIndex:0];
                    cell.labelPaymentType.text = [dictionary valueForKey:@"title"];
                } else {
                    cell.labelPaymentType.text = @"";
                }
            
            }
            return cell;
    }
    
    else if(self.tabindex==1){
        PromotionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"res_offers_cell"];
        
        ProductRestaurantPromotion *promotion = [self.restaurant.promotions objectAtIndex:indexPath.row];
        
        cell.labelTitle.text = promotion.title;
        cell.labelContents.text = promotion.descriptionText;
        
        [cell.imageViewPromotion setImageWithURL:[NSURL URLWithString:promotion.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        
//        [cell.imageViewRest setImageWithURL:[NSURL URLWithString:self.restaurant.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

        
        
    }else if(self.tabindex==2){
        
        ReviewTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"res_reviews_cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
//        } else if (indexPath.row == 2) {
//            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"show_menu_cell"];
//            
//            UILabel *labelMenu = [cell.contentView viewWithTag:100];
//            if (labelMenu == nil) {
//                labelMenu = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.view.frame.size.width - 40, 40)];
//                labelMenu.backgroundColor = [UIColor colorWithRed:0.204  green:0.486  blue:0.608 alpha:1];
//                labelMenu.textColor = [UIColor whiteColor];
//                labelMenu.text = Localized(@"show_menu");
//                labelMenu.layer.cornerRadius = 10;
//                labelMenu.clipsToBounds = YES;
//                labelMenu.tag = 100;
//                labelMenu.textAlignment = NSTextAlignmentCenter;
//                cell.backgroundColor = [UIColor clearColor];
//                [cell.contentView addSubview:labelMenu];
//            }
//            
//            return cell;
//        }
//    }
//    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 5) {
        SelectAreaViewController *vc = [[SelectAreaViewController alloc] initWithNibName:@"SelectAreaViewController" bundle:nil];
        vc.delegate = self;
        vc.restId = self.restaurant.productRestaurantId;
        
        vc.completionBlock = ^(CountryArea *area) {
            self.selectedArea = area;
            [self viewWillAppear:YES];
        };
        [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
    } else if (indexPath.section == 2) {
        if (indexPath.row == 2) {
            if (self.selectedArea == nil) {
                [self showErrorAlertWithMessage:Localized(@"empty_area")];
            } else {
                if ([self.restaurant.menu count] == 0) {
                    [self showErrorAlertWithMessage:Localized(@"empty_restaurant_menu")];
                } else {
                    MenuListViewController *vc = [Utils getViewControllerWithId:@"MenuListViewController"];
                    vc.menus = self.restaurant.menu;
                    vc.selectedRestaurant = self.restaurant;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
    } else if (indexPath.section == 1) {
        PromotionsViewController *vc = [Utils getViewControllerWithId:@"PromotionsViewController"];
        vc.items = self.restaurant.promotions;
        vc.restaurant = self.restaurant;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}

- (IBAction)res_offers_action:(id)sender {
    self.res_info_line.alpha=0;
    self.res_reviews_line.alpha=0;
    self.res_offers_line.alpha=1;
    
    self.res_offers_btn.backgroundColor = self.underline_color;
    self.res_info_btn.backgroundColor = [UIColor clearColor];
    self.res_reviews_btn.backgroundColor = [UIColor clearColor];
    self.tabindex=1;
    [self.tableView reloadData];
}

- (IBAction)res_reviews_action:(id)sender {
    self.res_info_line.alpha=0;
    self.res_reviews_line.alpha=1;
    self.res_offers_line.alpha=0;
    self.res_offers_btn.backgroundColor = [UIColor clearColor];
    self.res_info_btn.backgroundColor = [UIColor clearColor];
    self.res_reviews_btn.backgroundColor = self.underline_color;
    self.tabindex=2;
    [self.tableView reloadData];

}

- (IBAction)res_info_action:(id)sender {
    self.res_info_line.alpha=1;
    self.res_reviews_line.alpha=0;
    self.res_offers_line.alpha=0;
    self.res_offers_btn.backgroundColor = [UIColor clearColor];
    self.res_info_btn.backgroundColor = self.underline_color;
    self.res_reviews_btn.backgroundColor = [UIColor clearColor];
    self.tabindex=0;
    [self.tableView reloadData];


}
@end
