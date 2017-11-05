//
//  YDAlertRegist.m
//  ydx_login
//
//  Created by maoziyue on 2017/11/5.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "YDAlertRegist.h"
#import "TELTextField.h"
#import "CodTextField.h"
#import "PASTextField.h"
#import "TimerManager.h"



#define kDFont 18
#define kXFont 15
#define kSpace 20
#define kHSpace 50
#define kTextFieldH  50
#define kHeight      180   //背景框高度
#define kTimerName   @"REGISTGETCODE"
#define KTimerCount  20

@interface YDAlertRegist ()
{
    CGFloat width;
    CGFloat height;
    NSInteger count;
    BOOL  isFirst;
}
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) TELTextField *telTextField;
@property (nonatomic, strong) CodTextField *codTextField;
@property (nonatomic, strong) UIButton *getCodeBtn;
@property (nonatomic, strong) PASTextField *pasTextField;
@property (nonatomic, strong) UITextField *serTextField;//服务点
@property (nonatomic, strong) UIButton *registBtn;

@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *line4;

@end


@implementation YDAlertRegist

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        width = frame.size.width;
        height = frame.size.height;
        count = KTimerCount;
        //self.backgroundColor = [UIColor yellowColor];
        [self setup];
    }
    return self;
}


- (void)setup
{
    [self addSubview:self.titleLab];
    [self addSubview:self.telTextField];
    [self addSubview:self.line1];
    [self addSubview:self.codTextField];
    [self addSubview:self.getCodeBtn];
    [self addSubview:self.line2];
    [self addSubview:self.pasTextField];
    [self addSubview:self.line3];
    [self addSubview:self.serTextField];
    [self addSubview:self.line4];
    
    [self addSubview:self.registBtn];
    
    CGRect rect = self.frame;
    rect.size.height = CGRectGetMaxY(_registBtn.frame) + kSpace *2;
    self.frame = rect;
}

- (void)getCode:(UIButton *)btn
{
    NSString *phone = [self dealWithMobile];
    if (_getCodeBlock) {
        _getCodeBlock(phone);
    }
}

- (void)registBtnAction
{
    NSString *phone = [self dealWithMobile];
    NSString *pass = [self dealWithPass];
    NSString *code = self.codTextField.text;
    NSString *service = self.serTextField.text;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          phone,@"phone",
                          code,@"vcode",
                          pass,@"password",
                          service,@"service",
                          nil];
    
    if (_registBlock) {
        _registBlock(dict);
    }
}


- (NSString *)dealWithMobile
{
    NSString *phone = self.telTextField.text;

    phone = [phone stringByReplacingOccurrencesOfString:@" "withString:@""];
    
    return phone;
}

- (NSString *)dealWithPass
{
    NSString *data = self.pasTextField.text;

    data = [data stringByReplacingOccurrencesOfString:@" "withString:@""];
    
    return data;
}








// 重新发送验证码
- (void)runTimer
{
    NSString * msg = [NSString stringWithFormat:@"%lds后重发",(long)count];
    [self.getCodeBtn setTitle:msg forState:UIControlStateNormal];
    self.getCodeBtn.userInteractionEnabled = NO;
    
    TimerManager *time = [TimerManager manager];
    [time addTimerWithName:kTimerName timerSpace:60.f timercb:^{
        NSLog(@"---count:%ld----",(long)count);
        count --;
        NSString * msg = [NSString stringWithFormat:@"%lds后重发",(long)count];
        [self.getCodeBtn setTitle:msg forState:UIControlStateNormal];
        
        if (count == 0)
        {
            [self stopTimer];
            [self.getCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
            self.getCodeBtn.userInteractionEnabled = YES;
        }
    }];
}


// 倒计时完毕 、输入验证码之后跳转成功、点击返回按钮、释放
- (void)stopTimer
{
    count = KTimerCount;
    TimerManager *time = [TimerManager manager];
    [time deleteTimerWithName:kTimerName];
}


















#pragma mark ----lazy
- (UILabel *)titleLab
{
    if (!_titleLab) {
        CGRect rect = CGRectMake(0, 20, width, 20);
        _titleLab = [[UILabel alloc]initWithFrame:rect];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:kDFont];
        _titleLab.text = @"快速注册";
    }
    return _titleLab;
}

- (UITextField *)telTextField
{
    if (!_telTextField) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_titleLab.frame) + kSpace, width - kSpace *2, kTextFieldH);
        _telTextField = [[TELTextField alloc]initWithFrame:rect];
        _telTextField.placeholder = @"手机号";
        _telTextField.borderStyle = UITextBorderStyleNone;
    }
    return _telTextField;
}

- (UIView *)line1
{
    if (!_line1) {
         CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_telTextField.frame), width - kSpace *2, 1);
        _line1 = [[UIView alloc]initWithFrame:rect];
        _line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line1;
}

- (UIButton *)getCodeBtn
{
    if (!_getCodeBtn) {
        CGFloat btnW  = 100;
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCodeBtn.frame = CGRectMake(width - btnW - kSpace , CGRectGetMaxY(_line1.frame), btnW, kTextFieldH);
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:kXFont];
        [_getCodeBtn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeBtn;
}

- (UITextField *)codTextField
{
    if (!_codTextField) {
        CGFloat btnW = 100;
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_line1.frame), width - kSpace*2 - btnW - kSpace , kTextFieldH);
        _codTextField = [[CodTextField alloc]initWithFrame:rect];
        _codTextField.placeholder = @"验证码";
        _codTextField.borderStyle = UITextBorderStyleNone;
        _codTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codTextField;
}

- (UIView *)line2
{
    if (!_line2) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_codTextField.frame), width - kSpace *2, 1);
        _line2 = [[UIView alloc]initWithFrame:rect];
        _line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line2;
}

- (UITextField *)pasTextField
{
    if (!_pasTextField) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_line2.frame), width - kSpace *2, kTextFieldH);
        _pasTextField = [[PASTextField alloc]initWithFrame:rect];
        _pasTextField.placeholder = @"密码";
        _pasTextField.borderStyle = UITextBorderStyleNone;
    }
    return _pasTextField;
}

- (UIView *)line3
{
    if (!_line3) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_pasTextField.frame), width - kSpace *2, 1);
        _line3 = [[UIView alloc]initWithFrame:rect];
        _line3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line3;
}

- (UITextField *)serTextField
{
    if (!_serTextField) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_line3.frame), width - kSpace *2, kTextFieldH);
        _serTextField = [[UITextField alloc]initWithFrame:rect];
        _serTextField.placeholder = @"服务点";
        _serTextField.borderStyle = UITextBorderStyleNone;
    }
    return _serTextField;
}

- (UIView *)line4
{
    if (!_line4) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_serTextField.frame), width - kSpace *2, 1);
        _line4 = [[UIView alloc]initWithFrame:rect];
        _line4.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line4;
}


- (UIButton *)registBtn
{
    if (!_registBtn) {
        CGFloat btnW = 160;
        CGFloat btnH = 50;
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registBtn.frame = CGRectMake((width - btnW)/2, CGRectGetMaxY(_line4.frame) + kSpace *2, btnW, btnH);
        [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _registBtn.backgroundColor = [UIColor orangeColor];
        [_registBtn addTarget:self action:@selector(registBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBtn;
}






- (void)dealloc
{
    NSLog(@"--注册View释放---");
}



@end
