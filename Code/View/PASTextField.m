//
//  PASTextField.m
//  ydx_login
//
//  Created by maoziyue on 2017/11/4.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "PASTextField.h"

@implementation PASTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.keyboardType = UIKeyboardTypeASCIICapable;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.spellCheckingType = UITextSpellCheckingTypeNo;
    self.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.secureTextEntry = YES;
}









@end
