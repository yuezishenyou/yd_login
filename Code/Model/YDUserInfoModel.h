//
//  YDUserInfoModel.h
//  ydx_login
//
//  Created by maoziyue on 2017/11/5.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  YDUserInfoDataModel : NSObject

@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *password;
@property (nonatomic,copy)NSString *wsToken;
@property (nonatomic,copy)NSString *Id;
@property (nonatomic,copy)NSString *vcode;
@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy)NSString *name;


@end

@interface YDUserInfoModel : NSObject


@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *msg;
@property (nonatomic,strong)YDUserInfoDataModel *data;


@end
