//
//  YDAuthCodeModel.h
//  ydx_login
//
//  Created by maoziyue on 2017/11/5.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDAuthCodeModel : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *data;

@end
