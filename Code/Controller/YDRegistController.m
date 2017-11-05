//
//  YDRegistController.m
//  ydx_login
//
//  Created by maoziyue on 2017/11/5.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "YDRegistController.h"
#import "YDAlertRegist.h"
#import "NSString+Valid.h"
#import "DejFlickerView.h"
#import "YDNetworking.h"


#define kScreenW ([[UIScreen mainScreen]bounds].size.width)
#define kScreenH ([[UIScreen mainScreen]bounds].size.height)



@interface YDRegistController ()

@property (nonatomic, strong) YDAlertRegist *alertRegist;


@end

@implementation YDRegistController

- (void)back
{
    [self.alertRegist stopTimer];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSubViews];
    
    [self addBlock];
    
}

- (void)getCode:(NSString *)phone
{
    if (![NSString validateMobile:phone]) {
        [DejFlickerView flickerWithLabeText:@"手机号码格式有误!"];
        return ;
    }
    
    [self.alertRegist runTimer];
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


- (void)regist:(NSDictionary *)dict
{
    NSString *phone = dict[@"phone"];
    NSString *pass = dict[@"password"];
    NSString *code = dict[@"vcode"];
    NSString *service = dict[@"service"];
    
    NSLog(@"----dict:%@----",dict);
    
    if (![NSString validateMobile:phone]) {
        [DejFlickerView flickerWithLabeText:@"手机号码格式有误!"];
        return;
    }
    
    if (![NSString validatePass:pass]) {
        [DejFlickerView flickerWithLabeText:@"密码格式有误!"];
        return;
    }
    
    if (code.length == 0) {
        [DejFlickerView flickerWithLabeText:@"验证码不能为空!"];
        return;
    }
    
    if (service.length == 0) {
        [DejFlickerView flickerWithLabeText:@"服务点不能为空!"];
        return;
    }
    
    NSDictionary *mdict = [NSDictionary dictionaryWithObjectsAndKeys:
                           phone,@"phone",
                           pass,@"password",
                           code,@"vcode",
                           nil];
    
    
    
    [YDNetworking postGetRegistDictionary:mdict resultBlock:^(YDRegisterModel *model, NSError *error) {
        
        if (!error) {
            if ([model.code isEqualToString:@"0"]) {
                [self.alertRegist stopTimer];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
    }];
    
}




- (void)addBlock
{
    __weak typeof(self) weakSelf = self;
    
    [self.alertRegist setGetCodeBlock:^(NSString *phone) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getCode:phone];
        
    }];
    
    
    [self.alertRegist setRegistBlock:^(NSDictionary *dict) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"---dic:%@---",dict);
        [strongSelf regist:dict];
        
    }];

}














- (void)initSubViews
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    
    self.alertRegist = [[YDAlertRegist alloc]initWithFrame:CGRectMake(0, 100, kScreenW, 400)];
    
    [self.view addSubview:self.alertRegist];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}









- (void)dealloc
{
    NSLog(@"--注册vc释放---");
}




@end
