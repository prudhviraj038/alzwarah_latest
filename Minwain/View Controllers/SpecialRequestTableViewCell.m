//
//  SpecialRequestTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 14/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "SpecialRequestTableViewCell.h"

@implementation SpecialRequestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textViewInfo.delegate = self;
    self.container.layer.cornerRadius = 5;
    self.container.clipsToBounds = YES;
    
    self.labelTitle.layer.cornerRadius = 5;
    self.labelTitle.clipsToBounds = YES;
    self.labelTitle.text = Localized(@"special_request");
 
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.textViewInfo.placeholder = Localized(@"special_request");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.textViewInfo.text forKey:@"comments"];
    [defaults synchronize];
}

@end
