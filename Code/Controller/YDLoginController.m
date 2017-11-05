//
//  YDLoginController.m
//  ydx_login
//
//  Created by meiyue on 2017/11/3.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "YDLoginController.h"
#import "YDAlertLogin.h"
#import "DejFlickerView.h"
#import "YDNetworking.h"
#import "NSString+Valid.h"
#import "YDRegistController.h"

#define kScreenW ([[UIScreen mainScreen]bounds].size.width)
#define kScreenH ([[UIScreen mainScreen]bounds].size.height)


@interface YDLoginController ()

@property (nonatomic, strong) YDAlertLogin *alertLogin;

@end

@implementation YDLoginController

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadView
{
    [super loadView];
    self.view.frame = [[UIScreen mainScreen]bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    
    [self initSubViews];
    
    
    [self addBlock];
    
    
    
}

- (void)addBlock
{
    __weak typeof(self) weakSelf = self;
    
    [self.alertLogin setLoginBlock:^(NSInteger loginMode, NSString *phone, NSString *data) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf login:loginMode phone:phone data:data];

    }];
    
    
    [self.alertLogin setGetCodeBlock:^(NSString *phone) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getCode:phone];
    }];
    
    [self.alertLogin setJumpRegistBlock:^(NSString *phone) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf regist:phone];
    }];
    
}
- (void)regist:(NSString *)phone
{
    YDRegistController *regist = [[YDRegistController alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
}



- (void)getCode:(NSString *)phone
{
    if (![NSString validateMobile:phone]) {
        [DejFlickerView flickerWithLabeText:@"手机号码格式有误!"];
        return;
    }
    
    [self.alertLogin runTimer];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"18217726501",@"phone",
                          nil];
    
    [YDNetworking postGetAuthCodeDictionary:dict resultBlock:^(YDAuthCodeModel *model, NSError *error) {
        if (!error) {
            if ([model.code isEqualToString:@"0"]) {
                [DejFlickerView flickerWithLabeText:@"验证码已发送,注意查收!"];
            }
        }
    }];
}





- (void)login:(NSInteger)loginMode phone:(NSString *)phone data:(NSString *)data
{
    if (![NSString validateMobile:phone]) {
        [DejFlickerView flickerWithLabeText:@"手机格式有误!"];
        return;
    }
    
    NSDictionary *dict;
    if (loginMode == LoginModeVerity){
        dict = [NSDictionary dictionaryWithObjectsAndKeys:
                phone,@"phone",
                data,@"vcode",
                nil];
    }
    else{
        if (![NSString validatePass:data]) {
            [DejFlickerView flickerWithLabeText:@"密码格式有误!"];
            return;
        }
        dict = [NSDictionary dictionaryWithObjectsAndKeys:
                phone,@"phone",
                data,@"password",
                nil];
    }
    
    [YDNetworking postGetLoginDictionary:dict loginMode:loginMode resultBlock:^(YDLoginModel *model, NSError *error) {
        
        if (!error) {
            if ([model.code isEqualToString:@"0"]){
                NSString *token = model.data;
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud setObject:token forKey:@"token"];
                
                [self.alertLogin stopTimer];
                [self.alertLogin removeFromSuperview];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                [DejFlickerView flickerWithLabeText:model.msg];
            }
        }
        
    }];
}























- (void)initSubViews
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"X" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    

    self.alertLogin = [[YDAlertLogin alloc]initWithFrame:CGRectMake(0, 100, kScreenW, 100)];
    
    self.alertLogin.loginMode = LoginModeVerity;
    
    [self.view addSubview:self.alertLogin];
    
    //[DejFlickerView flickerWithLabeText:@"什么错误呀"];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}










-(void)dealloc
{
    NSLog(@"---login释放--");
}
















@end
