#import <Foundation/Foundation.h>

@interface ProductAddon : NSObject <NSCoding> {

}

@property (nonatomic) BOOL selected;
@property (nonatomic, copy) NSString *addonId;
@property (nonatomic, copy) NSString *addon;
@property (nonatomic, copy) NSString *addonAr;
@property (nonatomic, copy) NSString *price;

+ (ProductAddon *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
