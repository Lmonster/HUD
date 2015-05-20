//
//  ASAKHUDStatus.m
//  ASAK
//
//  Created by WorkSpace_付国强 on 15/4/26.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import "ASAKHUDStatus.h"

#define MAIN_SCREEN_X           [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_Y           [UIScreen mainScreen].bounds.size.height
#define DEFAULT_INIT_FRAME      CGRectMake((MAIN_SCREEN_X - 128)/2,(MAIN_SCREEN_Y-128)/2,128,128)

@implementation ASAKHUDStatusView{
    UIImageView *statusImageView;
    UILabel *statusLabel;
    UIWindow *statusWindow;
    CGRect lastFrame;
}

#pragma mark --
#pragma 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:CGRectMake((MAIN_SCREEN_X-128)/2, (MAIN_SCREEN_X-128)/2, 0, 0)];
    self.layer.cornerRadius = 5.0;
    statusWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    statusWindow.backgroundColor = [UIColor clearColor];
    statusWindow.userInteractionEnabled = NO;
    
    self.frame = frame;                         //stastus的frame
    float height = frame.size.height;           //获取高度
    float width = frame.size.width;             //获取宽度
    float LAncherPoint = width*(1/3.)/2;        //左上角的定位原点
    float imageWidth = width*(2/3.);            //status图片的宽度（和label的宽度一样）
    float imageHeight = height*(2/3.);          //status图片的高度
    float labelHeight = height*(1/3.);          //status label的高度
    
    if(self){
        
        statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LAncherPoint, 5, imageWidth, imageHeight)];
        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(LAncherPoint, LAncherPoint + imageHeight/1.5, imageWidth, labelHeight)];
        if(statusLabel && statusImageView){
            [self addSubview:statusImageView];
            [self addSubview:statusLabel];
            self.alpha = 0.5;
            self.backgroundColor = [UIColor whiteColor];
        }
        [statusWindow addSubview:self];
        
    }
    return self;
}


- (instancetype)initWithImage:(UIImage *)image withString:(NSString *)string{
    if(!(statusLabel && statusLabel))
        self = [[ASAKHUDStatusView alloc] initWithFrame:DEFAULT_INIT_FRAME];
    statusImageView.image = image;
    statusLabel.text = string;
    return self;
}

- (void)ASAKHUDShowWithBlock:(HUDDidShow)showBlk Withduration:(float)duration dismissWithBlock:(HUDDidDismiss)dismissBlk{
    
    [self ASAKHUDShowWithBlock:showBlk];
    [self performSelector:@selector(ASAKHUDDismissWithBlock) withObject:dismissBlk afterDelay:duration];
    if(showBlk)
        showBlk();
}


#pragma mark --
#pragma showHUD
- (void)ASAKHUDShowWithBlock:(HUDDidShow)showBlock{
    [statusWindow makeKeyAndVisible];
    showBlock();
}

-(void)ASAKHUDDismissWithBlock:(HUDDidDismiss)dismissBlock{
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 0;
        [[[[UIApplication sharedApplication] windows] firstObject] makeKeyAndVisible];
    }];
    if(dismissBlk)
        dismissBlock();
}


@end
