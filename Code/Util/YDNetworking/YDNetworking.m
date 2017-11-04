//
//  YDNetworking.m
//  HH_Entity
//
//  Created by maoziyue on 17/6/2.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "YDNetworking.h"
#import "MJExtension.h"
#import "YDNetWork.h"
#import "DejNetwork.h"


@implementation YDNetworking

+ (void)postGetVaildPhoneWithDictionary:(NSDictionary *)dict resultBlock:(void(^)(YDVaildPhoneModel *model,NSError *error))block;
{
    NSString *url = [NSString stringWithFormat:@"%@%@",GATEWAY,@"/user/isExist"];
    
    [YDNetWork POST:url parameters:dict success:^(id responseBody) {
        NSLog(@"---responseBody:%@---",responseBody);
        YDVaildPhoneModel *model = [YDVaildPhoneModel mj_objectWithKeyValues:responseBody];
        block(model,nil);
        
    } failure:^(NSError *error) {
        NSLog(@"---xxx---");
        block(nil,error);
    }];
}


































@end


























///**
// * 2008
// * 修改头像
// */
//+ (void)changHeaderImageWihtImage:(UIImage *)image dictionary:(NSDictionary *)dic resltBlock:(void (^)(YDUpLoadModel *model, NSError *error))block
//{
//    
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
//                                                         
//                                                         @"text/html",
//                                                         
//                                                         @"image/jpeg",
//                                                         
//                                                         @"image/png",
//                                                         
//                                                         @"application/octet-stream",
//                                                         
//                                                         @"text/json",
//                                                         
//                                                         nil];
//    
//    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
//    
//    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
//    
//    NSString *url = [NSString stringWithFormat:@"%@?sid=2008&token=%@", GATEWAY, dic[@"token"]];
//    
//    
//    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        NSData *picture = UIImageJPEGRepresentation(image, 0.5);
//        [formData appendPartWithFileData:picture name:@"photoPath" fileName:@"photo.jpg" mimeType:@"photo/jpg"];
//        
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        
//        NSLog(@"----%@----%@------",json[@"sid"],json);
//        
//        YDUpLoadModel *enti = [YDUpLoadModel mj_objectWithKeyValues:responseObject];
//        
//        if (block) {
//            block(enti,nil);
//        }
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        if (block) {
//            block(nil,error);
//        }
//        
//    }];
//    
//}




///**
// * 2004
// * 登录
// */
//+ (void)postGetLoginDataWithDictionary:(NSDictionary *)dic resultBlock:(void (^)(YDLoginModel *model,NSError *error))block
//{
//    
//    [YDNetWork POST:GATEWAY parameters:dic success:^(id responseBody) {
//        
//        
//        YDLoginModel *enti = [YDLoginModel mj_objectWithKeyValues:responseBody];
//        if (block) {
//            block(enti,nil);
//        }
//        
//    } failure:^(NSError *error) {
//        
//        if (block) {
//            block(nil,error);
//        }
//        
//    }];
//}







