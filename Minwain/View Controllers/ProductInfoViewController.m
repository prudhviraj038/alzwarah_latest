//
//  ProductInfoViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 27/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "ProductInfoViewController.h"

@interface ProductInfoViewController ()
@property (nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@end

@implementation ProductInfoViewController


- (void)viewWillAppear:(BOOL)animated {
    self.view.layer.cornerRadius = 10;
    self.view.clipsToBounds = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.info;
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close.png"] style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = 10;
        self.navItem.rightBarButtonItems = @[negativeSpacer, closeButton];
    } else {
        self.navItem.leftBarButtonItem = closeButton;
    }
    
    self.navItem.title = Localized(@"title_product_info");
}

- (void)close {
    [self.delegate cancelButtonClicked:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
