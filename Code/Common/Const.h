//
//  Const.h
//  ydx_login
//
//  Created by maoziyue on 2017/11/3.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#ifndef Const_h
#define Const_h

#define GATEWAY @"http://114.215.208.42:9091"

//1.判断手机号是否已经被注册
///user/isExist?phone=17612161504
//
//2.获取短信验证码
///user/getVCode?phone=17612161504
//
//3.注册
///user/reg?phone=17612161504&password=yd123456&vcode=817796
//
//4.登录
///user/login?phone=17612161504&password=yd123456
//
//5.使用短信验证码快速登录
///user/loginsms?phone=17612161504&vcode=064675
//
//6.获取用户信息
///user/getUserInfo?token=c23bbc67-0445-4710-8381-abb4888ef179
//
//7.找回密码
///user/findPassword?phone=17612161504&vcode=265845
//
//8.找回密码
///user/resetPassword?phone=17612161504&vcode=265845&password=newpwd
//
//9.修改用户信息(post)
///user/updateUserInfo
//
//{
//    "id": 3,
//    "phone": "17612161504",
//    "password": "gk123456",
//    "name": "Chris Chen",
//    "vcode": null,
//    "token": "662d51f8-0521-428f-9022-eca1e82fe0cf",
//    "wsToken": null
//}

//10.修改用户信息（协议测试）
///user/modifyUserInfo
//
//{
//    "protocol": {
//        "ver": "1.0",
//        "channel": "mi",
//        "os": "android",
//        "token": "f23c171a-0844-4482-926d-1dddb030bfc0",
//        "lng": 120.6354125525,
//        "lat": 33.2665855233
//    },
//    "params": {
//        "id": 3,
//        "phone": "17612161504",
//        "password": "gk123456",
//        "name": "Chris Chen",
//        "token": "f23c171a-0844-4482-926d-1dddb030bfc0"
//    }
//}
//
//此接口提供规范协议包装的RequestBody请求模式，期待那un可以用这个api进行调用测试。
//
//11.退出登录
///user/logout?token=f23c171a-0844-4482-926d-1dddb030bfc0



#endif /* Const_h */
