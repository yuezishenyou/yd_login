//
//  TELTextField.m
//  ydx_login
//
//  Created by maoziyue on 2017/11/3.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "TELTextField.h"

@interface TELTextField ()
{
    NSInteger _num;
}
@end

@implementation TELTextField

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
  
    _num = 0;
    [self addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldDidEditing:(UITextField *)textField
{
    if (textField == self)
    {
        if (textField.text.length > _num)
        {
            if (textField.text.length == 4 || textField.text.length == 9 )
            {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }
            if (textField.text.length >= 13 )
            {//输入完成
                textField.text = [textField.text substringToIndex:13];
                //[textField resignFirstResponder];
            }
            _num = textField.text.length;
            
        }
        else if (textField.text.length < _num)
        {//删除
            if (textField.text.length == 4 || textField.text.length == 9)
            {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            _num = textField.text.length;
        }
    }
}























@end
