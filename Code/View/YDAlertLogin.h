//
//  YDAlertLogin.h
//  ydx_login
//
//  Created by meiyue on 2017/11/3.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, LoginMode) {
    LoginModeVerity = 0 , //验证码
    LoginModePass,        //密码
    
};

@interface YDAlertLogin : UIView

@property (nonatomic, assign) LoginMode loginMode;






@end
