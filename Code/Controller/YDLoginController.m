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
    
    self.view.backgroundColor = [UIColor yellowColor];
    

    
    
    [self initSubViews];
    
    
    
}


- (void)initSubViews
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"X" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    
    

    self.alertLogin = [[YDAlertLogin alloc]initWithFrame:CGRectMake(0, 100, kScreenW, 100)];
    
    self.alertLogin.loginMode = LoginModeVerity;
    
    [self.view addSubview:self.alertLogin];
    
    [DejFlickerView flickerWithLabeText:@"什么错误呀"];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self.view endEditing:YES];
    
}










-(void)dealloc
{
    NSLog(@"---login释放--");
}
















@end
