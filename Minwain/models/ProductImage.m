#import "ProductImage.h"

@implementation ProductImage

@synthesize image, thumb;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.image forKey:@"image"];
    [encoder encodeObject:self.thumb forKey:@"thumb"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.image = [decoder decodeObjectForKey:@"image"];
        self.thumb = [decoder decodeObjectForKey:@"thumb"];
    }
    return self;
}

+ (ProductImage *)instanceFromDictionary:(NSDictionary *)aDictionary {

    ProductImage *instance = [[ProductImage alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.image = [aDictionary objectForKey:@"image"];
    self.thumb = [aDictionary objectForKey:@"thumb"];

}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.image) {
        [dictionary setObject:self.image forKey:@"image"];
    }

    if (self.thumb) {
        [dictionary setObject:self.thumb forKey:@"thumb"];
    }

    return dictionary;

}


@end
