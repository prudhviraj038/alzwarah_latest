#import "ProductRestaurantCategory.h"

@implementation ProductRestaurantCategory

@synthesize productRestaurantCategoryId, title, titleAr;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.productRestaurantCategoryId forKey:@"productRestaurantCategoryId"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.titleAr forKey:@"titleAr"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.productRestaurantCategoryId = [decoder decodeObjectForKey:@"productRestaurantCategoryId"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.titleAr = [decoder decodeObjectForKey:@"titleAr"];
    }
    return self;
}

- (NSString *)title {
    if ([[[MCLocalization sharedInstance] language] isEqualToString:KEY_LANGUAGE_EN]) {
        return title;
    } else {
        return [titleAr length] > 0 ? titleAr : title;
    }
}


+ (ProductRestaurantCategory *)instanceFromDictionary:(NSDictionary *)aDictionary {

    ProductRestaurantCategory *instance = [[ProductRestaurantCategory alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.productRestaurantCategoryId = [aDictionary objectForKey:@"id"];
    self.title = [aDictionary objectForKey:@"title"];
    self.titleAr = [aDictionary objectForKey:@"title_ar"];

}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.productRestaurantCategoryId) {
        [dictionary setObject:self.productRestaurantCategoryId forKey:@"productRestaurantCategoryId"];
    }

    if (self.title) {
        [dictionary setObject:self.title forKey:@"title"];
    }

    if (self.titleAr) {
        [dictionary setObject:self.titleAr forKey:@"titleAr"];
    }

    return dictionary;

}


@end
