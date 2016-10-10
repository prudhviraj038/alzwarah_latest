//
//  AdvertisementViewController.m
//  DanDen
//
//  Created by Amit Kulkarni on 23/04/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "AdvertisementViewController.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface AdvertisementViewController ()
@property (nonatomic) NSString *link;
@property (weak, nonatomic) IBOutlet UIButton *buttonSkip;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation AdvertisementViewController

- (IBAction)openLink:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.link]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.buttonSkip setTitle:Localized(@"skip") forState:UIControlStateNormal];
    
    [self makeGetCallForPage:PAGE_GET_FULL_AD
                  withParams:@{}
             withRequestCode:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    NSDictionary *dictionary = [(NSArray *)result objectAtIndex:0];
    [self.imageView setImageWithURL:[NSURL URLWithString:[dictionary valueForKey:@"image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.link = [dictionary valueForKey:@"link"];
        
        [NSTimer scheduledTimerWithTimeInterval:5. target:self selector:@selector(skip:) userInfo:nil repeats:NO];
        
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}

- (IBAction)skip:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^(){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
