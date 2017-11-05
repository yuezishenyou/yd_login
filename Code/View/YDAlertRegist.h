//
//  YDAlertRegist.h
//  ydx_login
//
//  Created by maoziyue on 2017/11/5.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDAlertRegist : UIView

@property (nonatomic,copy)void(^registBlock)(NSDictionary *dict);

@property (nonatomic,copy)void(^getCodeBlock)(NSString *phone);

- (void)runTimer;

- (void)stopTimer;


@end
