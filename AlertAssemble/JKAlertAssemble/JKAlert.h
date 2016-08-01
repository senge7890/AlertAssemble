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
 *  错误提示
 */
+ (void)alertCross;
/**
 *  等待提示
 *
 *  @param isWaiting 控制弹出/移除
 */
+ (void)alertWaiting:(BOOL)isAlert;


@end
