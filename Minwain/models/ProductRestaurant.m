#import "ProductRestaurant.h"

#import "ProductArea.h"
#import "ProductRestaurantCategory.h"
#import "ProductRestaurantMenu.h"
#import "ProductRestaurantPayment.h"
#import "ProductRestaurantPromotion.h"

@implementation ProductRestaurant

@synthesize area, category, currentStatus, descriptionAr, descriptionText, hours, image, menu, minimum, productRestaurantId, payment, promotions, rating, reviews, time, title, titleAr, banner, smallDescription, smallDescriptionAr;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.smallDescriptionAr forKey:@"smallDescriptionAr"];
    [encoder encodeObject:self.smallDescription forKey:@"smallDescription"];
    [encoder encodeObject:self.banner forKey:@"banner"];
    [encoder encodeObject:self.area forKey:@"area"];
    [encoder encodeObject:self.category forKey:@"category"];
    [encoder encodeObject:self.currentStatus forKey:@"currentStatus"];
    [encoder encodeObject:self.descriptionAr forKey:@"descriptionAr"];
    [encoder encodeObject:self.descriptionText forKey:@"descriptionText"];
    [encoder encodeObject:self.hours forKey:@"hours"];
    [encoder encodeObject:self.image forKey:@"image"];
    [encoder encodeObject:self.menu forKey:@"menu"];
    [encoder encodeObject:self.minimum forKey:@"minimum"];
    [encoder encodeObject:self.productRestaurantId forKey:@"productRestaurantId"];
    [encoder encodeObject:self.payment forKey:@"payment"];
    [encoder encodeObject:self.promotions forKey:@"promotions"];
    [encoder encodeObject:self.rating forKey:@"rating"];
    [encoder encodeObject:self.reviews forKey:@"reviews"];
    [encoder encodeObject:self.time forKey:@"time"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.titleAr forKey:@"titleAr"];
}

- (NSString *)descriptionText {
    if ([[[MCLocalization sharedInstance] language] isEqualToString:KEY_LANGUAGE_EN]) {
        return descriptionText;
    } else {
        return [descriptionAr length] > 0 ? descriptionAr : descriptionText;
    }
}

- (NSString *)smallDescription {
    if ([[[MCLocalization sharedInstance] language] isEqualToString:KEY_LANGUAGE_EN]) {
        return smallDescription;
    } else {
        return [smallDescriptionAr length] > 0 ? smallDescriptionAr : smallDescription;
    }
}


- (NSString *)title {
    if ([[[MCLocalization sharedInstance] language] isEqualToString:KEY_LANGUAGE_EN]) {
        return title;
    } else {
        return [titleAr length] > 0 ? titleAr : title;
    }
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.smallDescription = [decoder decodeObjectForKey:@"smallDescription"];
        self.smallDescriptionAr = [decoder decodeObjectForKey:@"smallDescriptionAr"];
        self.banner = [decoder decodeObjectForKey:@"banner"];
        self.area = [decoder decodeObjectForKey:@"area"];
        self.category = [decoder decodeObjectForKey:@"category"];
        self.currentStatus = [decoder decodeObjectForKey:@"currentStatus"];
        self.descriptionAr = [decoder decodeObjectForKey:@"descriptionAr"];
        self.descriptionText = [decoder decodeObjectForKey:@"descriptionText"];
        self.hours = [decoder decodeObjectForKey:@"hours"];
        self.image = [decoder decodeObjectForKey:@"image"];
        self.menu = [decoder decodeObjectForKey:@"menu"];
        self.minimum = [decoder decodeObjectForKey:@"minimum"];
        self.productRestaurantId = [decoder decodeObjectForKey:@"productRestaurantId"];
        self.payment = [decoder decodeObjectForKey:@"payment"];
        self.promotions = [decoder decodeObjectForKey:@"promotions"];
        self.rating = [decoder decodeObjectForKey:@"rating"];
        self.reviews = [decoder decodeObjectForKey:@"reviews"];
        self.time = [decoder decodeObjectForKey:@"time"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.titleAr = [decoder decodeObjectForKey:@"titleAr"];
    }
    return self;
}

+ (ProductRestaurant *)instanceFromDictionary:(NSDictionary *)aDictionary {

    ProductRestaurant *instance = [[ProductRestaurant alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }


    NSArray *receivedArea = [aDictionary objectForKey:@"area"];
    if ([receivedArea isKindOfClass:[NSArray class]]) {

        NSMutableArray *populatedArea = [NSMutableArray arrayWithCapacity:[receivedArea count]];
        for (NSDictionary *item in receivedArea) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedArea addObject:[ProductArea instanceFromDictionary:item]];
            }
        }

        self.area = populatedArea;

    }

    NSArray *receivedCategory = [aDictionary objectForKey:@"category"];
    if ([receivedCategory isKindOfClass:[NSArray class]]) {

        NSMutableArray *populatedCategory = [NSMutableArray arrayWithCapacity:[receivedCategory count]];
        for (NSDictionary *item in receivedCategory) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedCategory addObject:[ProductRestaurantCategory instanceFromDictionary:item]];
            }
        }

        self.category = populatedCategory;

    }
    
    self.smallDescription = [aDictionary objectForKey:@"small_description"];
    self.smallDescriptionAr = [aDictionary objectForKey:@"small_description_ar"];
    self.banner = [aDictionary objectForKey:@"banner"];
    self.currentStatus = [aDictionary objectForKey:@"current_status"];
    self.descriptionAr = [aDictionary objectForKey:@"description_ar"];
    self.descriptionText = [aDictionary objectForKey:@"description"];
    self.hours = [aDictionary objectForKey:@"hours"];
    self.image = [aDictionary objectForKey:@"image"];

    NSArray *receivedMenu = [aDictionary objectForKey:@"menu"];
    if ([receivedMenu isKindOfClass:[NSArray class]]) {

        NSMutableArray *populatedMenu = [NSMutableArray arrayWithCapacity:[receivedMenu count]];
        for (NSDictionary *item in receivedMenu) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedMenu addObject:[ProductRestaurantMenu instanceFromDictionary:item]];
            }
        }

        self.menu = populatedMenu;

    }
    self.minimum = [aDictionary objectForKey:@"minimum"];
    self.productRestaurantId = [aDictionary objectForKey:@"id"];

    NSArray *receivedPayment = [aDictionary objectForKey:@"payment"];
    if ([receivedPayment isKindOfClass:[NSArray class]]) {

        NSMutableArray *populatedPayment = [NSMutableArray arrayWithCapacity:[receivedPayment count]];
        for (NSDictionary *item in receivedPayment) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedPayment addObject:[ProductRestaurantPayment instanceFromDictionary:item]];
            }
        }

        self.payment = populatedPayment;

    }

    NSArray *receivedPromotions = [aDictionary objectForKey:@"promotions"];
    if ([receivedPromotions isKindOfClass:[NSArray class]]) {

        NSMutableArray *populatedPromotions = [NSMutableArray arrayWithCapacity:[receivedPromotions count]];
        for (NSDictionary *item in receivedPromotions) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedPromotions addObject:[ProductRestaurantPromotion instanceFromDictionary:item]];
            }
        }

        self.promotions = populatedPromotions;

    }
    self.rating = [aDictionary objectForKey:@"rating"];
    self.reviews = [aDictionary objectForKey:@"reviews"];
    self.time = [aDictionary objectForKey:@"time"];
    self.title = [aDictionary objectForKey:@"title"];
    self.titleAr = [aDictionary objectForKey:@"title_ar"];

}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.area) {
        [dictionary setObject:self.area forKey:@"area"];
    }

    if (self.category) {
        [dictionary setObject:self.category forKey:@"category"];
    }

    if (self.currentStatus) {
        [dictionary setObject:self.currentStatus forKey:@"currentStatus"];
    }

    if (self.descriptionAr) {
        [dictionary setObject:self.descriptionAr forKey:@"descriptionAr"];
    }

    if (self.descriptionText) {
        [dictionary setObject:self.descriptionText forKey:@"descriptionText"];
    }

    if (self.hours) {
        [dictionary setObject:self.hours forKey:@"hours"];
    }

    if (self.image) {
        [dictionary setObject:self.image forKey:@"image"];
    }

    if (self.menu) {
        [dictionary setObject:self.menu forKey:@"menu"];
    }

    if (self.minimum) {
        [dictionary setObject:self.minimum forKey:@"minimum"];
    }

    if (self.productRestaurantId) {
        [dictionary setObject:self.productRestaurantId forKey:@"productRestaurantId"];
    }

    if (self.payment) {
        [dictionary setObject:self.payment forKey:@"payment"];
    }

    if (self.promotions) {
        [dictionary setObject:self.promotions forKey:@"promotions"];
    }

    if (self.rating) {
        [dictionary setObject:self.rating forKey:@"rating"];
    }

    if (self.reviews) {
        [dictionary setObject:self.reviews forKey:@"reviews"];
    }

    if (self.time) {
        [dictionary setObject:self.time forKey:@"time"];
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
