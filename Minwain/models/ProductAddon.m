#import "ProductAddon.h"

@implementation ProductAddon

@synthesize addon, addonId, price, addonAr;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.addonId forKey:@"addonId"];
    [encoder encodeObject:self.addon forKey:@"addon"];
    [encoder encodeObject:self.addonAr forKey:@"addonAr"];
    [encoder encodeObject:self.price forKey:@"price"];
    [encoder encodeObject:[NSNumber numberWithBool:self.selected] forKey:@"selected"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.addonId = [decoder decodeObjectForKey:@"addonId"];
        self.addon = [decoder decodeObjectForKey:@"addon"];
        self.addonAr = [decoder decodeObjectForKey:@"addonAr"];
        self.price = [decoder decodeObjectForKey:@"price"];
        self.selected = [[decoder decodeObjectForKey:@"selected"] boolValue];
    }
    return self;
}

+ (ProductAddon *)instanceFromDictionary:(NSDictionary *)aDictionary {

    ProductAddon *instance = [[ProductAddon alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.addonId = [aDictionary objectForKey:@"addon_id"];
    self.addon = [aDictionary objectForKey:@"addon"];
    self.addonAr = [aDictionary objectForKey:@"addon_ar"];
    self.price = [aDictionary objectForKey:@"price"];

}

- (NSString *)addon {
    if ([[[MCLocalization sharedInstance] language] isEqualToString:KEY_LANGUAGE_EN]) {
        return addon;
    } else {
        return [addonAr length] > 0 ? addonAr : addon;
    }
}



- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.addon) {
        [dictionary setObject:self.addon forKey:@"addon"];
    }

    if (self.price) {
        [dictionary setObject:self.price forKey:@"price"];
    }

    return dictionary;

}


@end
