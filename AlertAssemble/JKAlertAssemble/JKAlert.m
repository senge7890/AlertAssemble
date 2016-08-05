//
//  JKAlert.m
//  AlertAssemble
//
//  Created by 四威 on 2016/8/1.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKAlert.h"
#import "JKAlertManager.h"
#import "NSObject+JKAlert.h"
#import "NSString+JKAlert.h"

@implementation JKAlert

#pragma mark - 文字提示相关
+ (void)alertText:(NSString *)text {
    JK_M.duration = DURATION_DEFAULT;
    [self alertContentsWithText:text];
}
+ (void)alertText:(NSString *)text duration:(NSTimeInterval)duration {
    JK_M.duration = duration;
    [self alertContentsWithText:text];
}
+ (void)alertContentsWithText:(NSString *)text {
    //移除旧视图显示新视图
    [JK_M cleanOldAlertViews:^{
        //设置状态
        JK_M.isAlerted = YES;
        //设置文本标签样式
        UIFont *font = [UIFont systemFontOfSize:15];
        //容器最大宽
        CGFloat containMaxWidth = SCREEN_WIDTH - 100;
        //文字最大宽
        CGFloat textMaxWidth = containMaxWidth - 30;
        //实例化
        JK_M.textLabel = [[JKAdapterLabel alloc] initWithText:text font:font maxWitdth:textMaxWidth];
        //居中
        JK_M.textLabel.center = SCREEN_CENTER;
        //添加容器
        [JK_M containSize:CGSizeMake(JK_M.textLabel.jk_width + 30, JK_M.textLabel.jk_height + 20) block:^(CGFloat num) {
            //添加标签
            [JK_M.mainWindow addSubview:JK_M.textLabel];
            //定时移除
            [JK_M dismissDuration:JK_M.duration];
        }];
        //添加不可交互视图
        [JK_M coverEnable:NO];
        //添加弹性
        [JK_M elastAllAlertViews];
    }];
}
#pragma mark - 等待视图相关
+ (void)alertWaiting:(BOOL)isAlert {
    //判断是否要显示
    if (isAlert) {
        //判断是否有弹窗正在显示
        [JK_M cleanOldAlertViews:^{
            //设置状态
            JK_M.isAlerted = YES;
            //添加容器到主窗口
            [JK_M containSide:SCREEN_WIDTH * 0.2 block:^(CGFloat num) {
                //内容宽高
                CGFloat iWH = num * 0.7;
                //创建内容
                JK_M.waitView = [[JKWaitingView alloc] initWithFrame:CGRectMake(0, 0, iWH, iWH)];
                //内容居中
                JK_M.waitView.center = SCREEN_CENTER;
                //添加内容到主窗口
                [JK_M.mainWindow addSubview:JK_M.waitView];
            }];
            //创建可交互视图
            [JK_M coverEnable:YES];
            //添加弹性
            [JK_M elastAllAlertViews];
        }];
    }else {
        //判断是否有弹窗正在显示
        if (JK_M.isAlerted) {
            //清理所有弹窗
            [JK_M dismissNormal];
        }
    }
}
#pragma mark - 标识视图相关
+ (void)alertTick {
    JK_M.duration = DURATION_DEFAULT;
    [self alertInformWithStyle:JKInformStyleTick];
}
+ (void)alertTickDuration:(NSTimeInterval)duration {
    JK_M.duration = duration;
    [self alertInformWithStyle:JKInformStyleTick];
}
+ (void)alertCross {
    JK_M.duration = DURATION_DEFAULT;
    [self alertInformWithStyle:JKInformStyleCross];
}
+ (void)alertCrossDuration:(NSTimeInterval)duration {
    JK_M.duration = duration;
    [self alertInformWithStyle:JKInformStyleCross];
}
//根据类型判断显示哪一种提示
+ (void)alertInformWithStyle:(JKInformStyle)style{
    //判断是否有弹窗正在显示
    [JK_M cleanOldAlertViews:^{
        //设置状态
        JK_M.isAlerted = YES;
        //添加容器到主窗口
        [JK_M containSide:SCREEN_WIDTH * 0.3 block:^(CGFloat num) {
            //内容宽高
            CGFloat iWH = num * 0.4;
            //创建内容并设置标识类型
            JK_M.informView = [[JKInformView alloc] initWithFrame:CGRectMake(0, 0, iWH, iWH) style:style];
            //内容居中
            JK_M.informView.center = SCREEN_CENTER;
            //添加内容到主窗口
            [JK_M.mainWindow addSubview:JK_M.informView];
            //定时移除
            [JK_M dismissDuration:JK_M.duration];
        }];
        //创建不可交互视图
        [JK_M coverEnable:NO];
        //添加弹性
        [JK_M elastAllAlertViews];
    }];
}


@end
