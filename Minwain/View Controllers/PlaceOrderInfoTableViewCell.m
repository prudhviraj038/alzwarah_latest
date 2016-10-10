//
//  PlaceOrderInfoTableViewCell.m
//  Minwain
//
//  Created by Amit Kulkarni on 24/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "PlaceOrderInfoTableViewCell.h"

@implementation PlaceOrderInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.labelInfo.layer.cornerRadius = 5;
    self.labelInfo.clipsToBounds = YES;
    
    self.viewContainer.layer.cornerRadius = 5;
    self.viewContainer.clipsToBounds = YES;
    self.viewContainer.backgroundColor = [UIColor whiteColor];
    
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.labelInfo.text = Localized(@"title_personal_info");
    self.labelFirstNAme.text = Localized(@"title_first_name");
    self.labelLastNAme.text = Localized(@"title_last_name");
    self.labelWorkPhone.text = Localized(@"text_mobile");
    self.labelHomePhone.text = Localized(@"title_home_phone");
    //self.labelMobile.text = Localized(@"title_mobile");
    
    self.editFirstName.placeholder = Localized(@"title_first_name");
    self.editLastName.placeholder = Localized(@"title_last_name");
    self.editWorkPhone.placeholder = Localized(@"text_mobile");
    self.editHomePhone.placeholder = Localized(@"title_home_phone");
    //self.editMobile.placeholder = Localized(@"title_mobile");
    
    
    self.editFirstName.delegate = self;
    self.editLastName.delegate = self;
    self.editWorkPhone.delegate = self;
    self.editHomePhone.delegate = self;
    //self.editMobile.delegate = self;

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (textField == self.editFirstName) {
        [defaults setValue:self.editFirstName.text forKey:@"guest_first_name"];
    } else if (textField == self.editLastName) {
        [defaults setValue:self.editLastName.text forKey:@"guest_last_name"];
    } else if (textField == self.editWorkPhone) {
        [defaults setValue:self.editWorkPhone.text forKey:@"guest_work_phone"];
    } else if (textField == self.editHomePhone) {
        [defaults setValue:self.editHomePhone.text forKey:@"guest_home_phone"];
    }/* else if (textField == self.editMobile) {
        [defaults setValue:self.editMobile.text forKey:@"guest_mobile"];
    }*/
    [defaults synchronize];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
