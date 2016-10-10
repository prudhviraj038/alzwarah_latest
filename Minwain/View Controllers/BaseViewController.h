//
//  BaseViewController.h
//  StreetWhere
//
//  Created by Amit Kulkarni on 10/04/15.
//  Copyright (c) 2015 Mobentia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UISearchBarDelegate> {
    int requestCode;
    
}

@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL dismissProgress;

- (void) makePostCallForPage:(NSString *)page
                  withParams:(NSDictionary *)params
             withRequestCode:(int)code;
- (void) makeGetCallForPage:(NSString *)page
                 withParams:(NSDictionary *)params
            withRequestCode:(int)code;

- (void) parseResult:(id) result withCode:(int)reqeustCode;
- (void) showErrorAlertWithMessage:(NSString *)message;
- (void) showSuccessMessage:(NSString *)message;

- (void) showHUD:(NSString *)labelText;
- (void) hideHUD;
- (void)refreshItems;
- (void)showSideMenu;

@end
