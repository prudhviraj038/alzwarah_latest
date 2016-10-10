#import <Foundation/Foundation.h>

@interface ProductRestaurantMenu : NSObject <NSCoding> {

}

@property (nonatomic, copy) NSString *productRestaurantMenuId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleAr;

+ (ProductRestaurantMenu *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
