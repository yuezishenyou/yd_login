//
//  DejFlickerView.h
//  ydx_login
//
//  Created by maoziyue on 2017/11/4.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import <UIKit/UIKit.h>


// ----------------------------------------------------------------------------------------
// MARK: - 小提示，自动消失
// ----------------------------------------------------------------------------------------



@interface DejFlickerView : UIView

@property (nonatomic, strong, readonly) UIView *borderView;

@property (nonatomic, strong, readonly) UILabel *activityLabel;

@property (nonatomic, assign) NSInteger  duration;

+ (DejFlickerView *)activityWithText:(NSString *)title;

+ (DejFlickerView *)activityViewForView:(UIView *)addToView withLabel:(NSString *)labelText;

+ (void)removeView;

@end
