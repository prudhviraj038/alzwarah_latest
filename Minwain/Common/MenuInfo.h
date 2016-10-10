//
//  MenuInfo.h
//  DanDen
//
//  Created by Amit Kulkarni on 28/03/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuInfo : NSObject
@property (nonatomic, strong) NSString *menuItem;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *menuId;

+ (MenuInfo *)itemWithTitle:(NSString *)title withImageName:(NSString *)name withId:(NSString *)menuId;
@end
