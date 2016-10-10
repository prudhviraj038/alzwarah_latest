#import "ProductGroup.h"

#import "ProductAddon.h"

@implementation ProductGroup

@synthesize addons, group, groupAr, maximum, minimum;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.addons forKey:@"addons"];
    [encoder encodeObject:self.group forKey:@"group"];
    [encoder encodeObject:self.groupAr forKey:@"groupAr"];
    [encoder encodeObject:self.maximum forKey:@"maximum"];
    [encoder encodeObject:self.minimum forKey:@"minimum"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.addons = [decoder decodeObjectForKey:@"addons"];
        self.group = [decoder decodeObjectForKey:@"group"];
        self.groupAr = [decoder decodeObjectForKey:@"groupAr"];
        self.maximum = [decoder decodeObjectForKey:@"maximum"];
        self.minimum = [decoder decodeObjectForKey:@"minimum"];
    }
    return self;
}

+ (ProductGroup *)instanceFromDictionary:(NSDictionary *)aDictionary {

    ProductGroup *instance = [[ProductGroup alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }


    NSArray *receivedAddons = [aDictionary objectForKey:@"addons"];
    if ([receivedAddons isKindOfClass:[NSArray class]]) {

        NSMutableArray *populatedAddons = [NSMutableArray arrayWithCapacity:[receivedAddons count]];
        for (NSDictionary *item in receivedAddons) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedAddons addObject:[ProductAddon instanceFromDictionary:item]];
            }
        }

        self.addons = populatedAddons;

    }
    self.group = [aDictionary objectForKey:@"group"];
    self.groupAr = [aDictionary objectForKey:@"group_ar"];
    self.maximum = [aDictionary objectForKey:@"maximum"];
    self.minimum = [aDictionary objectForKey:@"minimum"];

}

- (NSString *)group {
    if ([[[MCLocalization sharedInstance] language] isEqualToString:KEY_LANGUAGE_EN]) {
        return group;
    } else {
        return [groupAr length] > 0 ? groupAr : group;
    }
}


- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.addons) {
        [dictionary setObject:self.addons forKey:@"addons"];
    }

    if (self.group) {
        [dictionary setObject:self.group forKey:@"group"];
    }

    if (self.maximum) {
        [dictionary setObject:self.maximum forKey:@"maximum"];
    }

    if (self.minimum) {
        [dictionary setObject:self.minimum forKey:@"minimum"];
    }

    return dictionary;

}


@end
