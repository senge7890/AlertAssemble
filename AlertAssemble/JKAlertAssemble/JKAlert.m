//
//  JKAlert.m
//  AlertAssemble
//
//  Created by 四威 on 2016/8/1.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKAlert.h"
#import "JKAlertManager.h"


@implementation JKAlert

+ (void)alertWaiting:(BOOL)isAlert {
    //判断是否要显示
    if (isAlert) {
        //判断是否有弹窗正在显示
        if (JK_M.isAlerted) {
            //清理所有弹窗
            [JK_M clearAllAlertViews];
            //设置状态
            JK_M.isAlerted = NO;
            //bool转对象
            NSNumber *boolNum = [NSNumber numberWithBool:isAlert];
            //延时执行（确保已经清理掉旧视图）
            [self performSelector:@selector(alertWaiting:) withObject:boolNum afterDelay:0.1];
        }else {
            //设置状态
            JK_M.isAlerted = YES;
            //创建可交互视图
            JK_M.maskView = [[UIView alloc] initWithFrame:JK_M.mainWindow.bounds];
            //设置透明
            JK_M.maskView.backgroundColor = [UIColor clearColor];
            //添加点击事件
            [JK_M.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissNormal)]];
            //主窗口添加可交互视图
            [JK_M.mainWindow addSubview:JK_M.maskView];
            //设置弹窗容器和内容宽高
            CGFloat cWH = SCREEN_WIDTH * 0.14, iWH = cWH * 0.98;
            //屏幕中心点
            CGPoint screenCenter = CGPointMake(half(SCREEN_WIDTH), half(SCREEN_HEIGHT));
            //创建容器
            JK_M.containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cWH, cWH)];
            //容器居中
            JK_M.containView.center = screenCenter;
            //容器背景色
            JK_M.containView.backgroundColor = [UIColor blackColor];
            //容器圆角
            JK_M.containView.layer.cornerRadius = 5;
            //容器裁剪超出父图层内容
            JK_M.containView.layer.masksToBounds = YES;
            //容器半透明
            JK_M.containView.alpha = 0.7;
            //添加容器到主窗口
            [JK_M.mainWindow addSubview:JK_M.containView];
            //创建内容
            JK_M.waitView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, iWH, iWH)];
            //内容居中
            JK_M.waitView.center = screenCenter;
            //设置样式
            JK_M.waitView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            //开始动画
            [JK_M.waitView startAnimating];
            //添加内容到主窗口
            [JK_M.mainWindow addSubview:JK_M.waitView];
        }
    }else {
        //判断是否有弹窗正在显示
        if (JK_M.isAlerted) {
            //清理所有弹窗
            [self dismissNormal];
        }
    }
}


+ (void)alertTick {
    //弹出正确提示
    [self alertInformWithStyle:JKInformStyleTick];
}


+ (void)alertCross {
    //弹出错误提示
    [self alertInformWithStyle:JKInformStyleCross];
}

/**
 *  根据类型判断显示哪一种提示
 *
 *  @param style 提示类型
 */
+ (void)alertInformWithStyle:(JKInformStyle)style {
    //判断是否有弹窗正在显示
    if (JK_M.isAlerted) {
        //清理所有弹窗
        [JK_M clearAllAlertViews];
        //设置状态
        JK_M.isAlerted = NO;
        //枚举转对象
        NSNumber *enumNum = [NSNumber numberWithUnsignedInteger:style];
        //延时执行（确保已经清理掉旧视图）
        [self performSelector:@selector(alertInformWithStyle:) withObject:enumNum afterDelay:0.1];
    }else {
        //设置状态
        JK_M.isAlerted = YES;
        //设置弹窗容器和内容宽高
        CGFloat cWH = SCREEN_WIDTH * 0.3, iWH = cWH * 0.4;
        //屏幕中心点
        CGPoint screenCenter = CGPointMake(half(SCREEN_WIDTH), half(SCREEN_HEIGHT));
        //创建容器
        JK_M.containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cWH, cWH)];
        //容器居中
        JK_M.containView.center = screenCenter;
        //容器背景色
        JK_M.containView.backgroundColor = [UIColor blackColor];
        //容器圆角
        JK_M.containView.layer.cornerRadius = 5;
        //容器裁剪超出父图层内容
        JK_M.containView.layer.masksToBounds = YES;
        //容器半透明
        JK_M.containView.alpha = 0.7;
        //添加容器到主窗口
        [JK_M.mainWindow addSubview:JK_M.containView];
        //创建内容并设置标识类型
        JK_M.informView = [[JKInformView alloc] initWithFrame:CGRectMake(0, 0, iWH, iWH) style:style];
        //内容居中
        JK_M.informView.center = screenCenter;
        //添加内容到主窗口
        [JK_M.mainWindow addSubview:JK_M.informView];
        //定时移除
        [self dismissDefault];
    }
}

/**
 *  定时移除弹窗
 */
+ (void)dismissDefault {
    //视图动画
    [UIView animateWithDuration:3 animations:^{
        //由于NSTimer的实时性，这里选择用视图动画，0.1透明度偏差肉眼看不出来，当作定时器
        JK_M.containView.alpha = 0.8;
        //定时器完成后执行
    } completion:^(BOOL finished) {
        //控件渐变消失动画
        [UIView animateWithDuration:.3 animations:^{
            //容器透明
            JK_M.containView.alpha = 0;
            //内容透明
            JK_M.informView.alpha = 0;
            //动画完成后执行
        } completion:^(BOOL finished) {
            //主窗口移除所有弹出
            [JK_M clearAllAlertViews];
            //设置状态
            JK_M.isAlerted = NO;
            
        }];
    }];
}
/**
 *  普通移除
 */
+ (void)dismissNormal {
    //控件渐变消失动画
    [UIView animateWithDuration:.3 animations:^{
        //容器透明
        JK_M.containView.alpha = 0;
        //内容透明
        JK_M.informView.alpha = 0;
        //动画完成后执行
    } completion:^(BOOL finished) {
        //主窗口移除所有弹出
        [JK_M clearAllAlertViews];
        //设置状态
        JK_M.isAlerted = NO;
    }];
}
@end
