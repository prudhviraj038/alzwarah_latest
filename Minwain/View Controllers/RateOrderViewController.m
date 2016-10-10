//
//  RateOrderViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 28/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "RateOrderViewController.h"
#import <RatingBar.h>
#import <SZTextView.h>

@interface RateOrderViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic) RatingBar *bar;
@property (weak, nonatomic) IBOutlet SZTextView *textInfo;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UIView *viewRating;
@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;

@end

@implementation RateOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navItem.title = Localized(@"rate_order");
    [self.buttonSubmit setTitle:Localized(@"submit") forState:UIControlStateNormal];
    
    self.textInfo.placeholder = Localized(@"enter_review");
//    self.bar = [[RatingBar alloc] initWithFrame:CGRectMake(50, 50, 180, 30)];
//    self.bar.backgroundColor = [UIColor redColor];
//    self.bar.center = self.view.center;
//    self.bar.starNumber = 5;
//    [self.viewRating addSubview:self.bar];
    
    self.bar = [[RatingBar alloc] initWithFrame:CGRectMake(50, 50, 180, 30)];
    [self.view addSubview:self.bar];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.layer.cornerRadius = 10;
    self.view.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)submit:(id)sender {
    [self makePostCallForPage:PAGE_ADD_RATING withParams:@{@"order_id":self.orderId, @"rating":[NSString stringWithFormat:@"%ld", self.bar.starNumber], @"review":self.textInfo.text} withRequestCode:1];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {    
    [self.delegate cancelButtonClicked:self];
}

@end
