#import <Foundation/Foundation.h>

@interface ProductArea : NSObject <NSCoding> {

}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleAr;

+ (ProductArea *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
