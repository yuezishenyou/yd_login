//
//  YDMainController.m
//  ydx_login
//
//  Created by meiyue on 2017/11/3.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "YDMainController.h"
#import "YDLoginController.h"
#import "YDNetworking.h"
#import "DejActivityView.h"
#import "DejFlickerView.h"





@interface YDMainController ()

//@property (nonatomic, strong) mabaView;

@end

@implementation YDMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSubViews];
    
    
    //[self loadData];
    
    //[self loadData1];  //验证码
    
    //[self loadData2];   //注册
    
    //[self loadData3];    //登录
    
    //[self loadData4];    //登录2
    
    //[self loadData5];     //用户信息
    
    //[self loadData6];     //退出
    
    
    
}

- (void)loadData6
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"ODE3MWI3OTllYTliNDdkM2I2MGVlYTI1MDU0NzhiOGQ=",@"token",
                          
                          nil];
    
    [YDNetworking postGetLogoutDictionary:dict resultBlock:^(YDLogoutModel *model, NSError *error) {
        
        
    }];
}


- (void)loadData5
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"ODE3MWI3OTllYTliNDdkM2I2MGVlYTI1MDU0NzhiOGQ=",@"token",
                          
                          nil];
    
    [YDNetworking postGetUserInfoDictionary:dict resultBlock:^(YDUserInfoModel *model, NSError *error) {
        
    }];
}





- (void)loadData4
{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"18217726501",@"phone",
                          @"322826",@"vcode",
                          nil];
    
    [YDNetworking postGetLoginCodeDictionary:dict resultBlock:^(YDLoginModel *model, NSError *error) {
        //ODE3MWI3OTllYTliNDdkM2I2MGVlYTI1MDU0NzhiOGQ=
    }];
}


- (void)loadData3
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"18217726501",@"phone",
                          @"maoziyue",@"password",
                          nil];

    [YDNetworking postGetLoginPassDictionary:dict resultBlock:^(YDLoginModel *model, NSError *error) {
        
    }];
}


- (void)loadData2
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"18217726501",@"phone",
                          @"maoziyue",@"password",
                          @"32821",@"vcode",
                          nil];
    [YDNetworking postGetRegistDictionary:dict resultBlock:^(YDRegisterModel *model, NSError *error) {
       
    }];
}







- (void)loadData1
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"18217726501",@"phone",
                          nil];
    
    [YDNetworking postGetAuthCodeDictionary:dict resultBlock:^(YDAuthCodeModel *model, NSError *error) {

        if (!error) {
            if ([model.code isEqualToString:@"0"]) {
                NSLog(@"--1--");
            }
        }
    
    }];;

}







- (void)loadData
{
    //17612161504
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"18217726501",@"phone",
                          nil];
    
 
    [DejActivityView activityViewForView:self.view withLabel:@"数据加载"];
    

    [YDNetworking postGetVaildPhoneWithDictionary:dict resultBlock:^(YDVaildPhoneModel *model, NSError *error) {

        [DejActivityView activityViewForView:self.view withError:@"加载失败"];
        if (!error) {
            //data = 0 没注册  data = 1 已经注册过了
        }
        else
        {

        }
    }];
    
}






















- (void)initSubViews
{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
}

































- (void)login
{
    YDLoginController *login = [[YDLoginController alloc]initWithNibName:@"YDLoginController_iPhone" bundle:nil];
    
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:login];
    
    [self presentViewController:navc animated:YES completion:nil];
    
}













@end
