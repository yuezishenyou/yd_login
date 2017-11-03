//
//  YDNetworking.h
//  HH_Entity
//
//  Created by maoziyue on 17/6/2.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#import "YDLoginModel.h"
//#import "YDLoginOutModel.h"
//#import "YDMainModel.h"
//
//#import "YDDetailModel.h"
//#import "YDAdminMonthReportModel.h"
//
//#import "YDServicesModel.h"
//#import "YDServiceDetailModel.h"
//#import "YDDriverAllMonthsModel.h"
//#import "YDDriversModel.h"
//#import "YDDriverDetailModel.h"
//#import "YDSaleAllMonthsModel.h"
//#import "YDSalesModel.h"
//#import "YDSalesDetailModel.h"







@interface YDNetworking : NSObject

//// 登录
//+ (void)postGetLoginWithDictionary:(NSDictionary *)dict resultBlock:(void(^)(YDLoginModel *model,NSError *error))block;
//
//// 登出
//+ (void)postGetLoginOutWithDictionary:(NSDictionary *)dict resultBlock:(void(^)(YDLoginOutModel *model,NSError *error))block;
//
//
//
//
//
//
//// 悦道总计报表
//+ (void)postGetAdminReportWithDictionary:(NSDictionary *)dict resultBlock:(void(^)(YDMainModel *model,NSError *error))block;
//
//
//// 悦道总计月报
//+ (void)postGetAdminMonthReportWithDictionary:(NSDictionary *)dict resultBlock:(void(^)(YDAdminMonthReportModel*model,NSError *error))block;
//
//
////服务点
//+ (void)postGetReportForServiceWithDictionary:(NSDictionary *)dict resultBlock:(void(^)(YDServicesModel *model,NSError *error))block;
//
////服务点明细
//+ (void)postGetReportForServiceDetailWithDictionary:(NSDictionary *)dict resultBlock:(void(^)(YDServiceDetailModel *model,NSError *error))block;
//
////司机所有月
//+ (void)postGetReportForDriverAllMonthsWithDictionary:(NSDictionary *)dict resultBlock:(void(^)(YDDriverAllMonthsModel *model,NSError *error))block;
//
//
////司机某月
//+ (void)postGetReportForDriverWithDictionary:(NSDictionary *)dict resultBlock:(void(^)(YDDriversModel *model,NSError *error))block;
//
////司机明细
//+ (void)postGetReportForDriverDetailWithDictionary:(NSDictionary *)dict resultBlock:(void (^)(YDDriverDetailModel *model,NSError *error))block;
//
//
//+ (void)postGetReportForSaleAllMonthsWithDictionary:(NSDictionary *)dict resultBlock:(void(^)(YDSaleAllMonthsModel *model,NSError *error))block;
//
////大堂经历或专员某月
//+ (void)postGetReportForSalesWithDictionary:(NSDictionary *)dict resultBlock:(void (^)(YDSalesModel *model,NSError *error))block;
//
////大堂经理或专员
//+ (void)postGetReportForSalesDetailWithDictionary:(NSDictionary *)dict resultBlock:(void (^)(YDSalesDetailModel *model,NSError *error))block;






















//+ (void)postGetDetailWithDictionary:(NSDictionary *)dic resultBlock:(void(^)(YDDetailModel *model,NSError *error))block;
//
//
//
//+ (void)postGetDictionary:(NSDictionary *)dic resultBlock:(void(^)(YDDetailModel *model,NSError *error))block;







/**
 * 2008
 * 修改头像
 */
//+ (void)changHeaderImageWihtImage:(UIImage *)image dictionary:(NSDictionary *)dic resltBlock:(void (^)(YDUpLoadModel *model, NSError *error))block;












@end
