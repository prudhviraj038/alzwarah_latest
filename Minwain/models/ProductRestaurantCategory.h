#import <Foundation/Foundation.h>

@interface ProductRestaurantCategory : NSObject <NSCoding> {

}

@property (nonatomic, copy) NSString *productRestaurantCategoryId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleAr;

+ (ProductRestaurantCategory *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
