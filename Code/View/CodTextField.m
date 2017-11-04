//
//  CodTextField.m
//  ydx_login
//
//  Created by maoziyue on 2017/11/4.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "CodTextField.h"

@implementation CodTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    //self.passTextField.secureTextEntry = YES;
}







@end
