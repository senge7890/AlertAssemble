//
//  JKAlert.h
//  AlertAssemble
//
//  Created by 四威 on 2016/8/1.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+JKAlert.h"

@interface JKAlert : NSObject

/**
 *  正确提示
 */
+ (void)alertTick;
/**
 *  正确提示
 *
 *  @param duration 持续时间(秒)
 */
+ (void)alertTickDuration:(NSTimeInterval)duration;
/**
 *  错误提示
 */
+ (void)alertCross;
/**
 *  错误提示
 *
 *  @param duration 持续时间(秒)
 */
+ (void)alertCrossDuration:(NSTimeInterval)duration;
/**
 *  等待提示
 *
 *  @param isWaiting 控制弹出/移除
 */
+ (void)alertWaiting:(BOOL)isAlert;
/**
 *  文本提示
 *
 *  @param text 提示内容
 */
+ (void)alertText:(NSString *)text;
/**
 *  文本提示
 *
 *  @param text     提示内容
 *  @param duration 持续时间
 */
+ (void)alertText:(NSString *)text duration:(NSTimeInterval)duration;


@end
