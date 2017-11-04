//
//  YDAlertLogin.m
//  ydx_login
//
//  Created by meiyue on 2017/11/3.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "YDAlertLogin.h"
#import "TELTextField.h"
#import "PASTextField.h"
#import "CodTextField.h"
#import "NSString+Valid.h"
#import "UIView+animated.h"
#import "TimerManager.h"

#define kDFont 18
#define kXFont 15
#define kSpace 20
#define kHSpace 50
#define kTextFieldH  50
#define kHeight      180   //背景框高度
#define kTimerName   @"GETCODE"
#define KTimerCount  20

@interface YDAlertLogin ()
{
    CGFloat width;
    CGFloat height;
    NSInteger count;
    BOOL  isFirst;
}
@property (nonatomic, strong) UIView * verityView;//验证码背景框
@property (nonatomic, strong) UIView * passView;  //登录背景框

@property (nonatomic, strong) UILabel *verTitleLab;
@property (nonatomic, strong) TELTextField *verTelTextField;
@property (nonatomic, strong) CodTextField *verCodeTextField;
@property (nonatomic, strong) UIButton *verGetCodeBtn;
@property (nonatomic, strong) UIView *verLine1;
@property (nonatomic, strong) UIView *verLine2;



@property (nonatomic, strong) UILabel *pasTitleLab;
@property (nonatomic, strong) TELTextField *pasTelTextField;
@property (nonatomic, strong) PASTextField *pasWordTextField;
@property (nonatomic, strong) UIView *pasLine1;
@property (nonatomic, strong) UIView *pasLine2;


@property (nonatomic, strong) UIButton *changeBtn;//切换
@property (nonatomic, strong) UIButton *loginBtn; //登录
@property (nonatomic, strong) UIButton *registBtn;//注册

@property (nonatomic, copy  ) NSString *phone;
@property (nonatomic, copy  ) NSString *pass;
@property (nonatomic, copy  ) NSString *code;







@end


@implementation YDAlertLogin



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
      
        width = frame.size.width;
        height = frame.size.height;
        count = KTimerCount;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)setupVerity
{
    self.verityView.backgroundColor = [UIColor whiteColor];
    [self.verityView addSubview:self.verTitleLab];
    [self.verityView addSubview:self.verTelTextField];
    [self.verityView addSubview:self.verLine1];
    [self.verityView addSubview:self.verCodeTextField];
    [self.verityView addSubview:self.verGetCodeBtn];
    [self.verityView addSubview:self.verLine2];

    [self addSubview:self.changeBtn];
    [self addSubview:self.loginBtn];
    [self addSubview:self.registBtn];
    
}

- (void)setupPass
{
    self.passView.backgroundColor = [UIColor whiteColor];
    [self.passView addSubview:self.pasTitleLab];
    [self.passView addSubview:self.pasTelTextField];
    [self.passView addSubview:self.pasLine1];
    [self.passView addSubview:self.pasWordTextField];
    [self.passView addSubview:self.pasLine2];
    
    [self addSubview:self.changeBtn];
    [self addSubview:self.loginBtn];
    [self addSubview:self.registBtn];
    
}


- (void)setLoginMode:(LoginMode)loginMode
{
    _loginMode = loginMode;
    
    if (loginMode == LoginModeVerity)
    {
        self.phone =  _pasTelTextField.text;
        
        [self setupVerity];
        
        _verTelTextField.text = self.phone;
        _verCodeTextField.text = @"";
        
        if (!isFirst){
            isFirst = YES;
            [self.verityView showInView:self animationMode:AnimationModeNone];
        }
        else{
            [self.verityView showInView:self animationMode:AnimationModeDDLeft];
        }
    }
    else if (loginMode == LoginModePass)
    {
        self.phone = _verTelTextField.text;
        
        [self setupPass];
        
        _pasTelTextField.text = self.phone;
        _pasWordTextField.text = @"";
        
        if (!isFirst) {
            isFirst = YES;
            [self.passView showInView:self animationMode:AnimationModeNone];
        }else{
            [self.passView showInView:self animationMode:AnimationModeDDLeft];
        }

    }
    
    CGRect rect = self.frame;
    rect.size.height = CGRectGetMaxY(_registBtn.frame) + kSpace *2;
    self.frame = rect;
}

- (void)changeBtnAction:(UIButton *)btn
{
    NSLog(@"--切换--");
    [self.verityView endEditing:YES];
    [self.passView endEditing:YES];
    
    if (_loginMode == LoginModeVerity)
    {
        [btn setTitle:@"验证码登录" forState:UIControlStateNormal];
        self.loginMode = LoginModePass;
    }
    else
    {
        [btn setTitle:@"密码登录" forState:UIControlStateNormal];
        self.loginMode = LoginModeVerity;
    }
}


- (void)loginBtnAction
{
    NSLog(@"--登录--");
}

- (void)registBtnAction
{

    NSLog(@"--注册--");
}

- (void)getCode:(UIButton *)btn
{
    
    NSString *phone = [self dealWithMobile];
    
    if (![NSString validateMobile:phone]) {
        
        NSLog(@"---手机号无效---");
        
        return ;
    }
    
    
    
    NSLog(@"--获取验证码:%@--",phone);

    [self runTimer];
    
}


- (NSString *)dealWithMobile
{
    NSString *phone = nil;
    if (_loginMode == LoginModeVerity)
    {
        phone = _verTelTextField.text;
    }
    else if(_loginMode == LoginModePass)
    {
        phone = _pasTelTextField.text;
    }
    
    phone = [phone stringByReplacingOccurrencesOfString:@" "withString:@""];
    
    return phone;
}







// 忘记密码事件之后， 重新发送验证码
- (void)runTimer
{
    NSString * msg = [NSString stringWithFormat:@"%lds后重发",(long)count];
    [self.verGetCodeBtn setTitle:msg forState:UIControlStateNormal];
    self.verGetCodeBtn.userInteractionEnabled = NO;
    
    TimerManager *time = [TimerManager manager];
    [time addTimerWithName:kTimerName timerSpace:60.f timercb:^{
        NSLog(@"---count:%ld----",(long)count);
        count --;
        NSString * msg = [NSString stringWithFormat:@"%lds后重发",(long)count];
        [self.verGetCodeBtn setTitle:msg forState:UIControlStateNormal];
        
        if (count == 0)
        {
            [self stopTimer];
            [self.verGetCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
            self.verGetCodeBtn.userInteractionEnabled = YES;
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






















































































#pragma mark --切换和登录按钮
- (UIButton *)changeBtn
{
    if (!_changeBtn) {
        CGFloat btnW = 100;
        _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeBtn.frame = CGRectMake(kSpace, kHeight, btnW, 30);
        [_changeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_changeBtn addTarget:self action:@selector(changeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _changeBtn.titleLabel.font = [UIFont systemFontOfSize:kXFont];
        _changeBtn.layer.borderWidth = 1;
        _changeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _changeBtn.layer.cornerRadius = 3;
        _changeBtn.layer.masksToBounds = YES;
        
        if (_loginMode == LoginModeVerity)
        {
            [_changeBtn setTitle:@"密码登录" forState:UIControlStateNormal];
        }
        else
        {
            [_changeBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
        }
        
    }
    return _changeBtn;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        CGFloat btnW = 160;
        CGFloat btnH = 50;
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake((width - btnW)/2, CGRectGetMaxY(_changeBtn.frame) + kSpace *2, btnW, btnH);
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _loginBtn.backgroundColor = [UIColor orangeColor];
        [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)registBtn
{
    if (!_registBtn) {
        CGFloat btnW = 100;
        CGFloat btnH = 40;
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registBtn.frame = CGRectMake((width - btnW)/2, CGRectGetMaxY(_loginBtn.frame) + kSpace *3, btnW, btnH);
        [_registBtn setTitle:@"注册 >" forState:UIControlStateNormal];
         [_registBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        //_registBtn.backgroundColor = [UIColor orangeColor];
        [_registBtn addTarget:self action:@selector(registBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBtn;
}




#pragma mark --lazy
- (UIView *)verityView
{
    if (!_verityView) {
        CGRect rect = CGRectMake(0, 0, width, kHeight);
        _verityView = [[UIView alloc]initWithFrame:rect];
        [self addSubview:_verityView];
    }
    return _verityView;
}

- (UIView *)passView
{
    if (!_passView) {
        CGRect rect = CGRectMake(0, 0, width, kHeight);
        _passView = [[UIView alloc]initWithFrame:rect];
        [self addSubview:_passView];
    }
    return _passView;
}



#pragma mark --密码登录

- (UILabel *)pasTitleLab
{
    if (!_pasTitleLab) {
        CGRect rect = CGRectMake(0, 20, width, 20);
        _pasTitleLab = [[UILabel alloc]initWithFrame:rect];
        _pasTitleLab.textAlignment = NSTextAlignmentCenter;
        _pasTitleLab.font = [UIFont systemFontOfSize:kDFont];
        _pasTitleLab.text = @"密码登录";
    }
    return _pasTitleLab;
}

- (UITextField *)pasTelTextField
{
    if (!_pasTelTextField) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_pasTitleLab.frame) + kSpace, width - kSpace *2, kTextFieldH);
        _pasTelTextField = [[TELTextField alloc]initWithFrame:rect];
        _pasTelTextField.borderStyle = UITextBorderStyleNone;
        _pasTelTextField.placeholder = @"手机号";
    }
    return _pasTelTextField;
}

- (UIView *)pasLine1
{
    if (!_pasLine1) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_pasTelTextField.frame), width - kSpace *2, 1);
        _pasLine1 = [[UIView alloc]initWithFrame:rect];
        _pasLine1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _pasLine1;
}

- (PASTextField *)pasWordTextField
{
    if (!_pasWordTextField) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_pasLine1.frame), width - kSpace*2, kTextFieldH);
        _pasWordTextField = [[PASTextField alloc]initWithFrame:rect];
        _pasWordTextField.borderStyle = UITextBorderStyleNone;
        _pasWordTextField.placeholder = @"密码";
        _pasWordTextField.font = [UIFont systemFontOfSize:kXFont];
        
    }
    return _pasWordTextField;
}

- (UIView *)pasLine2
{
    if (!_pasLine2) {
        CGRect rect =  CGRectMake(kSpace, CGRectGetMaxY(_pasWordTextField.frame), width - kSpace *2, 1);
        _pasLine2 = [[UIView alloc]initWithFrame:rect];
        _pasLine2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _pasLine2;
}





#pragma mark --验证码登录
- (UILabel *)verTitleLab
{
    if (!_verTitleLab) {
        CGRect rect = CGRectMake(0, 20, width, 20);
        _verTitleLab = [[UILabel alloc]initWithFrame:rect];
        _verTitleLab.textAlignment = NSTextAlignmentCenter;
        _verTitleLab.font = [UIFont systemFontOfSize:kDFont];
        _verTitleLab.text = @"验证码登陆";
    }
    return _verTitleLab;
}

- (UITextField *)verTelTextField
{
    if (!_verTelTextField) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_verTitleLab.frame) + kSpace, width - kSpace *2, kTextFieldH);
        _verTelTextField = [[TELTextField alloc]initWithFrame:rect];
        _verTelTextField.placeholder = @"手机号";
        _verTelTextField.borderStyle = UITextBorderStyleNone;
    }
    return _verTelTextField;
}

- (UIView *)verLine1
{
    if (!_verLine1) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_verTelTextField.frame), width - kSpace *2, 1);
        _verLine1 = [[UIView alloc]initWithFrame:rect];
        _verLine1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _verLine1;
}

- (UIButton *)verGetCodeBtn
{
    if (!_verGetCodeBtn) {
        CGFloat btnW  = 100;
        _verGetCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _verGetCodeBtn.frame = CGRectMake(width - btnW - kSpace , CGRectGetMaxY(_verLine1.frame), btnW, kTextFieldH);
        [_verGetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verGetCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_verGetCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _verGetCodeBtn.titleLabel.font = [UIFont systemFontOfSize:kXFont];
        [_verGetCodeBtn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
        //_verGetCodeBtn.backgroundColor = [UIColor orangeColor];
    }
    return _verGetCodeBtn;
}

- (CodTextField *)verCodeTextField
{
    if (!_verCodeTextField) {
        CGFloat btnW = 100;
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_verTelTextField.frame), width - kSpace*2 - btnW - kSpace , kTextFieldH);
        _verCodeTextField = [[CodTextField alloc]initWithFrame:rect];
        _verCodeTextField.placeholder = @"验证码";
        _verCodeTextField.borderStyle = UITextBorderStyleNone;
        _verCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _verCodeTextField;
}

- (UIView *)verLine2
{
    if (!_verLine2) {
        CGRect rect = CGRectMake(kSpace, CGRectGetMaxY(_verCodeTextField.frame), width - kSpace *2, 1);
        _verLine2 = [[UIView alloc]initWithFrame:rect];
        _verLine2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _verLine2;
}


- (void)dealloc
{
    NSLog(@"--d登录释放--");
}


@end
