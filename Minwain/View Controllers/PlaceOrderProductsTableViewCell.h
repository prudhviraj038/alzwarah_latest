//
//  PlaceOrderProductsTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 20/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrderProductsTableViewCell : AppTableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UILabel *labeltitle;
@property (weak, nonatomic) IBOutlet UILabel *labelQty;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;

@end
