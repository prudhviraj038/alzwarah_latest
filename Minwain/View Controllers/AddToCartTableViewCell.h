//
//  AddToCartTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddToCartTableViewCell : AppTableViewCell
@property (nonatomic) int quantity;

@property (weak, nonatomic) IBOutlet UIButton *buttonAddToCart;
@property (weak, nonatomic) IBOutlet UILabel *labelQuantity;
@property (nonatomic, copy) void (^addToCart)(int quantity);

- (IBAction)addQuantity:(id)sender;
- (IBAction)removeQuantity:(id)sender;
- (IBAction)addToCart:(id)sender;
@end
