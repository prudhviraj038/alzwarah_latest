//
//  CartViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 15/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "CartViewController.h"
#import "Product.h"
#import "ProductImage.h"
#import "ProductRestaurant.h"
#import "CartTableViewCell.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface CartViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) NSMutableArray *products;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelMinimumOrderAmount;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalAmount;
@property (weak, nonatomic) IBOutlet UIButton *buttonCheckout;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = Localized(@"menu_cart");
    [self.buttonCheckout setTitle:Localized(@"title_checkout") forState:UIControlStateNormal];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CartTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.products = [[NSMutableArray alloc] init];
    [self.tableView setRowHeight:113];
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.navigationController.viewControllers.count == 1) {
//        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//        } else {
//            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showSideMenu)];
//        }
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    [self refreshCart];
}

- (void)refreshCart {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"products"];
    
    [self.products removeAllObjects];
    [self.products addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    [self.tableView reloadData];
    
    [self updateTotalPrice];
}

- (void)updateTotalPrice {
    ProductRestaurant *restaurant = nil;
    float totalPrice = 0;
    for (Product *product in self.products) {
        if ([[product restaurant] count] > 0) {
            restaurant = [[product restaurant] objectAtIndex:0];
        }
        
        totalPrice += ([product.price floatValue] * product.quantity);
    }
    
    self.labelMinimumOrderAmount.text = [NSString stringWithFormat:@"%@  |  %@ %0.2f", Localized(@"minimum_order_amout"), Localized(@"currency"), [restaurant.minimum floatValue]];
    self.labelTotalAmount.text = [NSString stringWithFormat:@"%@  |  %@ %0.2f", Localized(@"your_total_amout"), Localized(@"currency"), totalPrice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)checkoutProducts:(id)sender {
    if ([self.products count] == 0) {
        [self showErrorAlertWithMessage:Localized(@"no_products_in_cart")];
    } else {
        
        float totalPrice = 0;
        ProductRestaurant *restaurant = nil;
        for (Product *product in self.products) {
            if ([[product restaurant] count] > 0) {
                restaurant = [[product restaurant] objectAtIndex:0];
            }
            
            totalPrice += ([product.price floatValue] * product.quantity);
        }
        
        if (totalPrice < [restaurant.minimum floatValue]) {
            [self showErrorAlertWithMessage:Localized(@"product_total_less_than_min")];
            return;
        }
        
        if ([Utils loggedInUserId] == -1) {
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:Localized(@"login_to_checkout") preferredStyle:UIAlertControllerStyleAlert];
            [controller addAction:[UIAlertAction actionWithTitle:Localized(@"login") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:[Utils getViewControllerWithId:@"LoginViewController"]] animated:YES completion:nil];
            }]];
            
            [controller addAction:[UIAlertAction actionWithTitle:Localized(@"guest_checkout") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GuestPlaceOrderViewController"]
                                                     animated:YES];
            }]];
            
            [controller addAction:[UIAlertAction actionWithTitle:Localized(@"cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:controller animated:YES completion:nil];
        } else {
            [self.navigationController pushViewController:[Utils getViewControllerWithId:@"PlaceOrderViewController"]
                                                 animated:YES];
        }
    }
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    Product *product = [self.products objectAtIndex:indexPath.row];
    cell.labelTitle.text = product.title;
    cell.labelQuantity.text = [NSString stringWithFormat:@"%d",product.quantity];
    
    cell.labelPric.text = [NSString stringWithFormat:@"%@: %@ %@", Localized(@"price"), Localized(@"currency"), product.price];
    cell.labelTotal.text = [NSString stringWithFormat:@"%0.2f %@", ([product.price floatValue] * product.quantity),Localized(@"currency")];
    
    cell.completionBlock = ^(int quantity) {
        
        if(quantity==0){
            
            if(product.quantity>1){
                product.quantity--;
            }
            
        }else{
            
            if(product.quantity<99)
                product.quantity++;
            
        }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *adata = [NSKeyedArchiver archivedDataWithRootObject:self.products];
        [defaults setObject:adata forKey:@"products"];
        [defaults synchronize];
        
        cell.labelQuantity.text = [NSString stringWithFormat:@" %d", product.quantity];
        cell.labelTotal.text = [NSString stringWithFormat:@"%0.2f", ([product.price floatValue] * product.quantity)];
        
        
        [self updateTotalPrice];
    };
    
    cell.deleteProduct = ^() {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [defaults objectForKey:@"products"];
        
        NSMutableArray *temp = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [temp removeObjectAtIndex:indexPath.row];
        
        NSData *adata = [NSKeyedArchiver archivedDataWithRootObject:temp];
        [defaults setObject:adata forKey:@"products"];
        [defaults synchronize];
        
        [self refreshCart];
    };
    
    if ([product.images count] > 0) {
        ProductImage *image = [product.images objectAtIndex:0];
        [cell.imageViewProduct setImageWithURL:[NSURL URLWithString:image.image] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
