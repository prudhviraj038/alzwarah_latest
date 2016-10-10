//
//  ProductDetailsViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "Product.h"
#import "ProductImage.h"
#import "ProductRestaurant.h"
#import "ProductCategory.h"
#import "ProductOption.h"
#import "ProductOptionView.h"
#import "ProductGroup.h"
#import "ProductAddon.h"
#import "KIImagePager.h"
#import "CountryArea.h"

#import "ProductInfoViewController.h"
#import "PopViewControllerDelegate.h"
#import "UIViewController+MJPopupViewController.h"


#import "SpecialRequestTableViewCell.h"
#import "ProductOptionsTableViewCell.h"
#import "AddToCartTableViewCell.h"

@interface ProductDetailsViewController () <UITableViewDelegate, UITableViewDataSource, KIImagePagerDataSource, KIImagePagerDelegate, PopViewControllerDelegate>
@property (nonatomic) int quantity;

@property (weak, nonatomic) IBOutlet UIButton *buttonAddToCart;
@property (weak, nonatomic) IBOutlet UILabel *labelQuantity;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRestaurantIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelInfo;
@property (weak, nonatomic) IBOutlet UILabel *labelReviews;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UIView *viewImageContainer;
@property (weak, nonatomic) IBOutlet UILabel *labeldescription;

@property (nonatomic) KIImagePager *imagePager;
@end

@implementation ProductDetailsViewController

- (IBAction)showInfo:(id)sender {
    ProductInfoViewController *vc = [[ProductInfoViewController alloc] initWithNibName:@"ProductInfoViewController" bundle:nil];
    vc.delegate = self;
    vc.info = self.product.descriptionText;
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
}

- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.imagePager = [[KIImagePager alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 5, self.viewImageContainer.frame.size.height)];
    
    self.imagePager.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    self.imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    self.imagePager.slideshowTimeInterval = 5.5f;
    self.imagePager.slideshowShouldCallScrollToDelegate = YES;
    self.imagePager.delegate = self;
    self.imagePager.dataSource = self;
    
  //  self.viewImageContainer.backgroundColor = [UIColor clearColor];
    
    [self.viewImageContainer addSubview:self.imagePager];
    
    self.quantity = 1;
    
    [self.buttonAddToCart setTitle:Localized(@"add_to_cart") forState:UIControlStateNormal];
    
    /*NSMutableString *categories = [[NSMutableString alloc] init];
    for (ProductCategory *cat in self.product.category) {
        if ([categories length] == 0) {
            [categories appendFormat:@"%@", cat.title];
        } else {
            [categories appendFormat:@", %@", cat.title];
        }
    }
    self.labelInfo.text = categories;*/
    self.labelInfo.text = self.product.descriptionText;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SpecialRequestTableViewCell" bundle:nil] forCellReuseIdentifier:@"request_cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductOptionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"options_cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddToCartTableViewCell" bundle:nil] forCellReuseIdentifier:@"add_to_cart"];
    
    self.labelTitle.text = self.product.title;
    self.labeldescription.text = self.product.descriptionText;
    
    self.labelPrice.text = [NSString stringWithFormat:@"%@ %@", Localized(@"currency"), self.product.price];
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        self.labelPrice.textAlignment = NSTextAlignmentRight;
    } else {
        self.labelPrice.textAlignment = NSTextAlignmentLeft;
    }
}

#pragma mark - KIImagePager DataSource

- (NSArray *) arrayWithImages:(KIImagePager*)pager {
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (ProductImage *image in self.product.images) {
        [images addObject:image.image];
    }
    return images;
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image inPager:(KIImagePager *)pager {
    return UIViewContentModeScaleAspectFill;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addQuantity:(id)sender {
    _quantity++;
    self.labelQuantity.text = [NSString stringWithFormat:@"%d", self.quantity];
}

- (IBAction)removeQuantity:(id)sender {
    _quantity--;
    if (_quantity < 0) {
        _quantity = 0;
    } else {
        self.labelQuantity.text = [NSString stringWithFormat:@"%d", self.quantity];
    }
}

- (IBAction)addToCart:(id)sender {
    if ([self.product.restaurant count] > 0) {
        ProductRestaurant *restaurant = [self.product.restaurant objectAtIndex:0];
        if ([restaurant.currentStatus isEqualToString:@"Closed"]) {
            [self showErrorAlertWithMessage:Localized(@"product_cannot_add_close")];
            return;
        } else if ([restaurant.currentStatus isEqualToString:@"Busy"]) {
            [self showErrorAlertWithMessage:Localized(@"product_cannot_add_busy")];
            return;
        }
    }
    
    int index = 0;
    if ([self.product.options count] > 0) {
        for (ProductOption *op in self.product.options) {
            if (op.selected) {
                index++;
            }
        }
        
        if (index == 0) {
            [self showErrorAlertWithMessage:Localized(@"empty_product_option")];
            return;
        }
    }
    
    for (ProductGroup *group in self.product.group) {
        index = 0;
        for (ProductAddon *addon in group.addons) {
            if (addon.selected) {
                index++;
            }
        }
        
        if (index < [group.minimum intValue]) {
            [self showErrorAlertWithMessage:[NSString stringWithFormat:Localized(@"empty_product_group"), group.group]];
            return;
        }
    }
    
    self.product.quantity = self.quantity;
    
    float totalPrice = [self.product.price floatValue];
    for (ProductOption *option in self.product.options) {
        if (option.selected) {
            totalPrice += [option.price floatValue];
        }
    }
    
    for (ProductGroup *group in self.product.group) {
        for (ProductAddon *addon in group.addons) {
            if (addon.selected) {
                totalPrice += [addon.price floatValue];
            }
        }
    }
    
    self.product.price = [NSString stringWithFormat:@"%0.2f", totalPrice];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self.product.comments = [prefs valueForKey:@"comments"];
    
    NSData *data = [prefs objectForKey:@"products"];
    NSMutableArray *products = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (products == nil) {
        products = [[NSMutableArray alloc] init];
        [products addObject:self.product];
    } else {
        
        ProductRestaurant *restaurant = nil;
        if ([[self.product restaurant] count] > 0) {
            restaurant = [[self.product restaurant] objectAtIndex:0];
        }
        
        // check other restaurant
        if ([products count] > 0) {
            Product *p = [products objectAtIndex:0];
            if ([[p restaurant] count] > 0) {
                ProductRestaurant *rest = [[p restaurant] objectAtIndex:0];
                if (![restaurant.productRestaurantId isEqualToString:rest.productRestaurantId]) {
                    [products removeAllObjects];
                }
            }
        }
        
        for (int index = 0; index < products.count; index++) {
            Product *product = [products objectAtIndex:index];
            if ([self.product.productId isEqualToString:product.productId]) {
                [products removeObject:product];
            }
        }
        
        [products addObject:self.product];
    }
    
    [prefs setValue:self.area.countryAreaId forKey:@"areaId"];
    [prefs setValue:self.area.title forKey:@"areaTitle"];
    [prefs setValue:self.area.titleAr forKey:@"areaTitleAr"];
    
    NSData *adata = [NSKeyedArchiver archivedDataWithRootObject:products];
    [prefs setObject:adata forKey:@"products"];
    [prefs synchronize];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:Localized(@"message_open_cart") preferredStyle:UIAlertControllerStyleAlert];
    
    [controller addAction:[UIAlertAction actionWithTitle:Localized(@"text_checkout") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //self.navigationController.viewControllers = @[[APP_DELEGATE cartVC]];
        [self.navigationController pushViewController:[APP_DELEGATE cartVC] animated:YES];
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:Localized(@"text_continue") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float height = 44;
    if (indexPath.section == 2) {
        height = 140;
    } else if (indexPath.section == 0) {
        if ([self.product.options count] == 0) {
            height = 0;
        } else {
            NSInteger count = [self.product.options count];
            
            height = 70 + (count * 40);
        }
    } else if (indexPath.section == 1) {
        ProductGroup *group = [self.product.group objectAtIndex:indexPath.row];
        NSInteger count = [group.addons count];
                height = 70 + (count * 35);
    }
    
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 1;
    } else if (section == 0) {
        NSInteger count = [self.product.options count];
        return  (count == 0) ? 0 : 1;
    } else if (section == 1) {
        return [self.product.group count];
    } else if (section == 3) {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        SpecialRequestTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"request_cell"];
        
        
        return cell;
    } else if (indexPath.section == 0) {
        ProductOptionsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"options_cell" forIndexPath:indexPath];
        for (UIView *view in [cell.container subviews]) {
            [view removeFromSuperview];
        }
        
        cell.labelTitle.text = Localized(@"product_options");
        NSInteger count = [self.product.options count];
        
        int width = self.view.frame.size.width - 20;
        int y = 35;
        for (int index = 0; index < count; index++) {
            
            ProductOptionView *optionView = [[[NSBundle mainBundle] loadNibNamed:@"ProductOption" owner:self options:nil] objectAtIndex:0];
            optionView.frame = CGRectMake(0, y, width, 30);
            
                ProductOption *option = [self.product.options objectAtIndex:index];
                    optionView.label1.text = [NSString stringWithFormat:@" %d . %@ (%@ %@)",index+1, option.option, Localized(@"currency"), option.price];
                
                optionView.label1.font = [UIFont systemFontOfSize:12];
                optionView.label1.numberOfLines = 0;
                optionView.label1.lineBreakMode = NSLineBreakByWordWrapping;
                
                optionView.option1Changes = ^(BOOL status) {
                    for (ProductOption *op in self.product.options) {
                        op.selected = NO;
                    }
                    
                    option.selected = status;
                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                };
                
                [optionView setOption1:option.selected];
            
            
            y += 5 + (30);
            
            [cell.container addSubview:optionView];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else if (indexPath.section == 1) {
        ProductOptionsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"options_cell" forIndexPath:indexPath];
        for (UIView *view in [cell.container subviews]) {
            [view removeFromSuperview];
        }
        
        ProductGroup *group = [self.product.group objectAtIndex:indexPath.row];
        cell.labelTitle.text = group.group;
        NSInteger count = [group.addons count];
        
        int width = self.view.frame.size.width - 20;
        int y = 35;
        for (int index = 0; index < count; index++) {
            
            ProductOptionView *optionView = [[[NSBundle mainBundle] loadNibNamed:@"ProductOption" owner:self options:nil] objectAtIndex:0];
            optionView.frame = CGRectMake(0, y, width, 30);
            
            
                ProductAddon *addon = [group.addons objectAtIndex:index];
                    optionView.label1.text = [NSString stringWithFormat:@"%d . %@ (%@ %@)",index+1, addon.addon, Localized(@"currency"), addon.price];
            
                optionView.label1.font = [UIFont systemFontOfSize:12];
                optionView.label1.numberOfLines = 0;
                optionView.label1.lineBreakMode = NSLineBreakByWordWrapping;
                
                optionView.option1Changes = ^(BOOL status) {
                    if (status) {
                        int index = 0;
                        for (ProductAddon *op in group.addons) {
                            if (op.selected == YES) {
                                index++;
                            }
                        }
                        if (index >= [group.maximum intValue]) {
                            [self showErrorAlertWithMessage:Localized(@"max_options_selected")];
                            addon.selected = NO;
                            [optionView setOption1:NO];
                        } else {
                            addon.selected = status;
                        }
                    } else {
                        addon.selected = status;
                    }
                    
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                };
                
                [optionView setOption1:addon.selected];
            
            
            
            y += 5 + (30);
            
            [cell.container addSubview:optionView];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (indexPath.section == 3) {
        AddToCartTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"add_to_cart"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        cell.addToCart = ^(int quantity) {
        };
        
        return cell;
    }
    
    return nil;
}

@end
