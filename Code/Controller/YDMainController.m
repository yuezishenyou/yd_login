//
//  YDMainController.m
//  ydx_login
//
//  Created by meiyue on 2017/11/3.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "YDMainController.h"
#import "YDLoginController.h"
#import "YDNetWork.h"





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
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"17612161504",@"phone",
                          @"yd123456",@"password",
                          nil];
    
    //user/login?phone=17612161504&password=yd123456
    
    NSString *url = [NSString stringWithFormat:@"%@%@",GATEWAY,@"/user/login"];
    
    [[YDNetWork manager]GET:url parameters:dict success:^(id responseBody) {
        
        NSLog(@"--responseBody:%@--",responseBody);
        
    } failure:^(NSError *error) {
        NSLog(@"--xxx---");
    }];
    
}
























































- (void)login
{
    YDLoginController *login = [[YDLoginController alloc]initWithNibName:@"YDLoginController_iPhone" bundle:nil];
    
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:login];
    
    [self presentViewController:navc animated:YES completion:nil];
    
}













@end
