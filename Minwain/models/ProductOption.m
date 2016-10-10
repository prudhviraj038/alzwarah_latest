#import "ProductOption.h"

@implementation ProductOption

@synthesize option, price, optionId;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.option forKey:@"option"];
    [encoder encodeObject:self.optionId forKey:@"optionId"];
    [encoder encodeObject:self.price forKey:@"price"];
    [encoder encodeObject:[NSNumber numberWithBool:self.selected] forKey:@"selected"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.option = [decoder decodeObjectForKey:@"option"];
        self.optionId = [decoder decodeObjectForKey:@"optionId"];
        self.price = [decoder decodeObjectForKey:@"price"];
        self.selected = [[decoder decodeObjectForKey:@"selected"] boolValue];
    }
    return self;
}

+ (ProductOption *)instanceFromDictionary:(NSDictionary *)aDictionary {

    ProductOption *instance = [[ProductOption alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.optionId = [aDictionary objectForKey:@"option_id"];
    self.option = [aDictionary objectForKey:@"option"];
    self.price = [aDictionary objectForKey:@"price"];

}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.option) {
        [dictionary setObject:self.option forKey:@"option"];
    }

    if (self.price) {
        [dictionary setObject:self.price forKey:@"price"];
    }

    return dictionary;

}


@end
