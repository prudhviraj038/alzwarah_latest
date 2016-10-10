//
//  MenuInfo.m
//  DanDen
//
//  Created by Amit Kulkarni on 28/03/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "MenuInfo.h"

@implementation MenuInfo

+ (MenuInfo *)itemWithTitle:(NSString *)title withImageName:(NSString *)name withId:(NSString *)menuId {
    MenuInfo *item = [[MenuInfo alloc] init];
    item.menuItem = title;
    item.imageName = name;
    item.menuId = menuId;
    return item;
}

@end
