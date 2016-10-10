//
//  AppTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 31/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "AppTableViewCell.h"

@implementation AppTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.contentView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
//    [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView* view,
//                                                            NSUInteger idx,
//                                                            BOOL * stop) {
//         view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
//         //[view setTransform:CGAffineTransformMakeScale(1, 1)];
//     }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            self.contentView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
            [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView* view,
                                                                    NSUInteger idx,
                                                                    BOOL * stop) {
                view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
                //[view setTransform:CGAffineTransformMakeScale(1, 1)];
            }];
            
            self.textLabel.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
            self.detailTextLabel.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        } else {
            self.contentView.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
            [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView* view,
                                                                    NSUInteger idx,
                                                                    BOOL * stop) {
                view.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
                //[view setTransform:CGAffineTransformMakeScale(1, 1)];
            }];
            
            self.textLabel.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
            self.detailTextLabel.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
        }
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ([super initWithCoder:aDecoder]) {
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            self.contentView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
            [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView* view,
                                                                    NSUInteger idx,
                                                                    BOOL * stop) {
                view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
                //[view setTransform:CGAffineTransformMakeScale(1, 1)];
            }];
            
            self.textLabel.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
            self.detailTextLabel.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        } else {
            self.contentView.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
            [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView* view,
                                                                    NSUInteger idx,
                                                                    BOOL * stop) {
                view.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
                //[view setTransform:CGAffineTransformMakeScale(1, 1)];
            }];
            
            self.textLabel.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
            self.detailTextLabel.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
        }
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
