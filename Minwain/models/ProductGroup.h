#import <Foundation/Foundation.h>

@interface ProductGroup : NSObject <NSCoding> {

}

@property (nonatomic, copy) NSArray *addons;
@property (nonatomic, copy) NSString *group;
@property (nonatomic, copy) NSString *groupAr;
@property (nonatomic, copy) NSString *maximum;
@property (nonatomic, copy) NSString *minimum;

+ (ProductGroup *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
