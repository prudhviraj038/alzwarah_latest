#import <Foundation/Foundation.h>

@interface ProductRestaurant : NSObject <NSCoding> {

}

@property (nonatomic, copy) NSArray *area;
@property (nonatomic, copy) NSArray *category;
@property (nonatomic, copy) NSString *currentStatus;
@property (nonatomic, copy) NSString *descriptionAr;
@property (nonatomic, copy) NSString *descriptionText;
@property (nonatomic, copy) NSString *hours;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSArray *menu;
@property (nonatomic, copy) NSString *minimum;
@property (nonatomic, copy) NSString *productRestaurantId;
@property (nonatomic, copy) NSArray *payment;
@property (nonatomic, copy) NSArray *promotions;
@property (nonatomic, copy) NSNumber *rating;
@property (nonatomic, copy) NSNumber *reviews;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *banner;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleAr;
@property (nonatomic, copy) NSString *smallDescription;
@property (nonatomic, copy) NSString *smallDescriptionAr;

+ (ProductRestaurant *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
