//
//  SpecialRequestTableViewCell.h
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SZTextView.h>

@interface SpecialRequestTableViewCell : AppTableViewCell <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet SZTextView *textViewInfo;

@property (weak, nonatomic) IBOutlet UIView *container;
@end
