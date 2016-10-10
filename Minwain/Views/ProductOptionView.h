//
//  ProductOption.h
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductOptionView : UIView

@property (nonatomic) BOOL option1;
@property (nonatomic, weak) IBOutlet UIView *viewOption1;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIButton *button1;

@property (nonatomic) BOOL option2;
@property (nonatomic, weak) IBOutlet UIView *viewOption2;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIButton *button2;

- (IBAction)toggleOption1:(id)sender;

@property (nonatomic, copy) void (^option1Changes)(BOOL status);
@property (nonatomic, copy) void (^option2Changes)(BOOL status);

@end
