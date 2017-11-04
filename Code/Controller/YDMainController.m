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
    

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
    
    
    [self loadData];
    
    
}










- (void)loadData
{
    //17612161504
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"18217726501",@"phone",
                          nil];
    
     //[DejActivityView activityViewForView:self.view withLabel:@"逆发改委个地方你啊对方的方式地方"];
    //[DejFlickerView flickerWithLabeText:self.view withLabel:@"验证码不能为空"];
    [DejFlickerView flickerViewForView:self.view withLabel:@"abc"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[DejActivityView activityViewForView:self.view withError:@"加载失败"];
    });
    
    
   
//    [YDNetworking postGetVaildPhoneWithDictionary:dict resultBlock:^(YDVaildPhoneModel *model, NSError *error) {
//
//        [DejActivityView activityViewForView:self.view withError:@"加载失败"];
//        if (!error) {
//            //data = 0 没注册
//        }
//        else
//        {
//
//        }
//    }];
    
}
























































- (void)login
{
    YDLoginController *login = [[YDLoginController alloc]initWithNibName:@"YDLoginController_iPhone" bundle:nil];
    
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:login];
    
    [self presentViewController:navc animated:YES completion:nil];
    
}













@end
