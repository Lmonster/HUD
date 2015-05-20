//
//  ASAKHUDStatus.h
//  ASAK
//
//  Created by WorkSpace_付国强 on 15/4/26.
//  Copyright (c) 2015年 付国强. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ASAKHUDStatusView : UIView

typedef void(^HUDDidShow)();

typedef void(^HUDDidDismiss)();

- (instancetype)initWithImage:(UIImage *)image withString:(NSString *)string;

- (void)ASAKHUDShowWithBlock:(HUDDidShow)showBlock;

- (void)ASAKHUDDismissWithBlock:(HUDDidDismiss)dismissBlock;

- (void)ASAKHUDShowWithBlock:(HUDDidShow)showBlk Withduration:(float)duration dismissWithBlock:(HUDDidDismiss)dismissBlk;


@end
