#import <Foundation/Foundation.h>

@interface ProductImage : NSObject <NSCoding> {

}

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *thumb;

+ (ProductImage *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
