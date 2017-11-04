//
//  DejFlickerView.m
//  ydx_login
//
//  Created by maoziyue on 2017/11/4.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "DejFlickerView.h"


#define kBorderHeight (50)
#define kFontSize     (17)
#define kDuration     (1.25)

@interface DejFlickerView()

@property (nonatomic, weak)   UIView *originalView;
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UILabel *activityLabel;

@end

static DejFlickerView *dejFlickerView = nil;
@implementation DejFlickerView
{
    CGFloat width;
    CGFloat height;
}
@synthesize originalView;
@synthesize borderView;
@synthesize activityLabel;



#pragma mark ------------Util----------------
- (void)setupBackground
{
    self.opaque = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}
- (CGRect)enclosingFrame;
{
    return [[UIScreen mainScreen]bounds];
}

- (UIView *)makeBorderView;
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.opaque = NO;
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    view.layer.cornerRadius = 3;
    view.layer.masksToBounds = YES;
    return view;
}



- (UILabel *)makeActivityLabelWithText:(NSString *)labelText;
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label.font = [UIFont systemFontOfSize:kFontSize];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.text = labelText;
    
    return label;
}

- (UIView *)viewForView:(UIView *)view;
{
    return view;
}



// ----------------------------------------------------------------------------------------
// MARK: - 基础方法
// ----------------------------------------------------------------------------------------

- (void)layoutSubviews
{
    //NSLog(@"layoutSubviews:%ld",self.dejActivityStyle);
    
    /**
     * 这里要布局
     * borderView 在布局，居中
     */
    
    self.frame = [self enclosingFrame];
    
    if (!CGAffineTransformIsIdentity(self.borderView.transform))
        return;
    
    
    NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:kFontSize]};
    CGSize size = [self.activityLabel.text sizeWithAttributes:att];
    
    
    CGFloat borderWidth;
    CGFloat borderHeight;

        borderWidth = size.width + 50 +10;
        borderHeight = kBorderHeight;
    
    
    
    
    CGRect borderFrame = CGRectZero;
    borderFrame.size.width = borderWidth;
    borderFrame.size.height = borderHeight;
    self.borderView.frame = borderFrame;
    self.borderView.center = CGPointMake(width / 2, height /2);
    
    
    
    //activityIndicator
//    CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);//40px
//    self.activityIndicator.transform = transform;
//    self.activityIndicator.color = [UIColor orangeColor];
    
    
    //activityLabel
    CGRect activityLabelFrame = CGRectZero;
    activityLabelFrame.size.width = borderWidth;
    activityLabelFrame.size.height = 20;
    self.activityLabel.frame = activityLabelFrame;
    
    

        self.activityLabel.center = CGPointMake(borderWidth / 2 + 30, borderHeight / 2 );
        self.activityLabel.textAlignment = NSTextAlignmentLeft;

    
    
}


- (DejFlickerView *)initForView:(UIView *)addToView withLabel:(NSString *)labelText duration:(NSInteger)duration
{
    
    if (self = [super initWithFrame:CGRectZero])
    {
        
        //NSLog(@"-----init-------");
        width = [[UIScreen mainScreen]bounds].size.width;
        height = [[UIScreen mainScreen]bounds].size.height;
        [self setupBackground];
        
        self.originalView = addToView;
        
        self.duration = duration;
        
        self.borderView = [self makeBorderView];
        
        self.activityLabel = [self makeActivityLabelWithText:labelText];
        

        
        [addToView addSubview:self];
        [self addSubview:self.borderView];
        [self.borderView addSubview:self.activityLabel];
        
        
        
        //[self animateShow];//显示动画 不好看
        
    }
    return self;
}








+ (void)removeView
{
    if (!dejFlickerView) {
        return;
    }

    [dejFlickerView removeFromSuperview];
    dejFlickerView = nil;
}

+ (void)removeViewAnimated:(BOOL)animated
{
    if (!dejFlickerView) {
        return;
    }
    if (animated){
        [dejFlickerView animationRemove];
    }else{
        [self removeView];
    }
}


- (void)animationRemove
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeAnimationDidStop:finished:context:)];
    
    self.alpha = 0.0;
    
    [UIView commitAnimations];
    
}

- (void)removeAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
{
    [[self class] removeView];
}

- (void)animateShow;
{
    self.alpha = 0.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.alpha = 1.0;
    
    [UIView commitAnimations];
}











+ (DejFlickerView *)activityViewForView:(UIView *)addToView withLabel:(NSString *)labelText duration:(NSInteger)duration
{
    if (dejFlickerView)
    {
        [self removeView];
    }
    dejFlickerView = [[self alloc]initForView:addToView withLabel:labelText duration:duration];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dejFlickerView.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[dejFlickerView class] removeViewAnimated:YES];
    });
   
    
    return dejFlickerView;
}



// ----------------------------------------------------------------------------------------
// MARK: - 自定义方法
// ----------------------------------------------------------------------------------------

+ (DejFlickerView *)activityViewForView:(UIView *)addToView withLabel:(NSString *)labelText
{
    return [self activityViewForView:addToView withLabel:labelText duration:kDuration];
}

+ (DejFlickerView *)activityWithText:(NSString *)title
{
    UIWindow *w = [UIApplication sharedApplication].keyWindow;
    return [self activityViewForView:w withLabel:title duration:kDuration];
}










- (void)dealloc;
{
    if ([dejFlickerView isEqual:self])
    {
        dejFlickerView = nil;
    }
    NSLog(@"--提示框释放---");
}

@end
