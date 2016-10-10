#import <Foundation/Foundation.h>

@interface Product : NSObject <NSCoding> {

}

@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *about;
@property (nonatomic, copy) NSString *aboutAr;
@property (nonatomic, copy) NSArray *category;
@property (nonatomic, copy) NSString *descriptionAr;
@property (nonatomic, copy) NSString *descriptionText;
@property (nonatomic, copy) NSArray *group;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSArray *options;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSArray *restaurant;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleAr;
@property (nonatomic) float finalPrice;
@property (nonatomic) int quantity;

+ (Product *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
