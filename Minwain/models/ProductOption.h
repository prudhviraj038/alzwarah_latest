#import <Foundation/Foundation.h>

@interface ProductOption : NSObject <NSCoding> {

}

@property (nonatomic) BOOL selected;
@property (nonatomic, copy) NSString *option;
@property (nonatomic, copy) NSString *optionId;
@property (nonatomic, copy) NSString *price;

+ (ProductOption *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
