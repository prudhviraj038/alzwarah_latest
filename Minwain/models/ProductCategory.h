#import <Foundation/Foundation.h>

@interface ProductCategory : NSObject <NSCoding> {

}

@property (nonatomic, copy) NSString *productCategoryId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleAr;

+ (ProductCategory *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
