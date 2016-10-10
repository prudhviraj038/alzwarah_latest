//
//  HistoryItemCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 07/06/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "AppTableViewCell.h"

@interface HistoryItemCell : AppTableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UILabel *labeltitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;

@end
