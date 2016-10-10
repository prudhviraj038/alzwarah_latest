//
//  CartTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 19/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CartTableViewCell : AppTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *buttonTrash;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelQuantity;
@property (weak, nonatomic) IBOutlet UILabel *labelPric;
@property (weak, nonatomic) IBOutlet UILabel *labelTotal;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
- (IBAction)add_quantity:(id)sender;
- (IBAction)remove_quantity:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *add_btn;

@property (weak, nonatomic) IBOutlet UIButton *minus_btn;

@property (nonatomic) void (^deleteProduct)();
@property (nonatomic, copy) void (^completionBlock)(int quantity);

@end
