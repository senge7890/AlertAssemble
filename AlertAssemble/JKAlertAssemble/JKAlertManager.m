//
//  JKAlertManager.m
//  AlertAssemble
//
//  Created by 四威 on 2016/8/1.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKAlertManager.h"
#import "UIView+JKAlert.h"

/**
 *  容纳所有alertViews回调
 *
 *  @param maskView
 *  @param containView
 *  @param waitingView
 *  @param textLabel
 *  @param informView
 */
typedef void (^jk_block_views)(JKBaseView *maskView, JKBaseView *containView, JKWaitingView *waitingView, JKAdapterLabel *textLabel, JKInformView *informView);

NSString *const JKMaskCode = @"Mask";
NSString *const JKInformCode = @"Inform";
NSString *const JKWaitCode = @"Wait";
NSString *const JKContainCode = @"Contain";
NSString *const JKTextCode = @"Text";

@implementation JKAlertManager

//弹窗管理器为单例对象
+ (instancetype)manager {
    //创建空对象
    static JKAlertManager *m = nil;
    //创建GCD执行一次函数
    static dispatch_once_t onceToken;
    //创建管理器对象
    dispatch_once(&onceToken, ^{
        //实例化
        m = [[self alloc] init];
        //设置主窗口
        m.mainWindow = [UIApplication sharedApplication].keyWindow;
        //弹窗默认显示时间
        m.duration = DURATION_DEFAULT;
    });
    //返回对象
    return m;
}
#pragma mark - 移除视图相关
- (void)cleanAllAlertViewsWithMarkCodeInt:(NSUInteger)markCodeInt {
    
    [self alertViewsWithMarkCodeInt:markCodeInt block:^(JKBaseView *maskView, JKBaseView *containView, JKWaitingView *waitingView, JKAdapterLabel *textLabel, JKInformView *informView) {
        //移除标识视图
        [informView removeFromSuperview];
        //移除文本视图
        [textLabel removeFromSuperview];
        //移除容器视图
        [containView removeFromSuperview];
        //移除等待视图
        [waitingView removeFromSuperview];
        //移除可交互视图
        [maskView removeFromSuperview];
        //置空标识视图
        informView = nil;
        //置空文本视图
        textLabel = nil;
        //置空容器视图
        containView = nil;
        //置空等待视图
        waitingView = nil;
        //置空可交互视图
        maskView = nil;
    }];
}

- (void)hideAllAlertViewsWithMarkCodeInt:(NSUInteger)markCodeInt {
    
    [self alertViewsWithMarkCodeInt:markCodeInt block:^(JKBaseView *maskView, JKBaseView *containView, JKWaitingView *waitingView, JKAdapterLabel *textLabel, JKInformView *informView) {
        //隐藏标识视图
        informView.alpha = 0;
        //隐藏文本视图
        textLabel.alpha = 0;
        //隐藏容器视图
        containView.alpha = 0;
        //隐藏等待视图
        waitingView.alpha = 0;
        //隐藏可交互视图
        maskView.alpha = 0;
    }];
}
- (void)elastAllAlertViews {
    //标识视图添加弹性
    [self.informView elast];
    //文本视图添加弹性
    [self.textLabel elast];
    //容器视图添加弹性
    [self.containView elast];
    //等待视图添加弹性
    [self.waitView elast];
}
- (void)dismissNormalWithMarkCodeInt:(NSUInteger)markCodeInt {
    
    [self alertViewsWithMarkCodeInt:markCodeInt block:^(JKBaseView *maskView, JKBaseView *containView, JKWaitingView *waitingView, JKAdapterLabel *textLabel, JKInformView *informView) {
        //控件渐变消失动画
        [UIView animateWithDuration:.3 animations:^{
            //容器透明
            [JK_M hideAllAlertViewsWithMarkCodeInt:markCodeInt];
            //动画完成后执行
        } completion:^(BOOL finished) {
            //主窗口移除所有弹出
            [JK_M cleanAllAlertViewsWithMarkCodeInt:markCodeInt];
            //设置状态
            JK_M.isAlerted = NO;
        }];
    }];
}
- (void)dismissElastWithMarkCodeInt:(NSInteger)markCodeInt {
    
    [self alertViewsWithMarkCodeInt:markCodeInt block:^(JKBaseView *maskView, JKBaseView *containView, JKWaitingView *waitingView, JKAdapterLabel *textLabel, JKInformView *informView) {
        NSArray *values = @[@(1), @(1.1), @(0)];
        //标识视图添加弹性
        [informView elastValues:values];
        //文本视图添加弹性
        [textLabel elastValues:values];
        //容器视图添加弹性
        [containView elastValues:values];
        //等待视图添加弹性
        [waitingView elastValues:values];
        //控件渐变消失动画
        [UIView animateWithDuration:.2 animations:^{
            //容器透明
            [JK_M hideAllAlertViewsWithMarkCodeInt:markCodeInt];
            //动画完成后执行
        } completion:^(BOOL finished) {
            //主窗口移除所有弹出
            [JK_M cleanAllAlertViewsWithMarkCodeInt:markCodeInt];
            //设置状态
            JK_M.isAlerted = NO;
        }];
    }];
}
- (void)dismissElast {
    NSArray *values = @[@(1), @(1.1), @(0)];
    NSMutableArray *allAlertViews = [NSMutableArray array];
    for (JKBaseView *view in JK_M.mainWindow.subviews) {
        if ([view isKindOfClass:JKBaseView.self]) {
            [view elastValues:values];
            [allAlertViews addObject:view];
        }
    }
    for (JKBaseView *view in allAlertViews) {
        [UIView animateWithDuration:.2 animations:^{
            //容器透明
            view.alpha = 0;
            //动画完成后执行
        } completion:^(BOOL finished) {
            //主窗口移除所有弹出
            [view removeFromSuperview];
            //设置状态
            JK_M.isAlerted = NO;
        }];

    }
}

- (void)dismissDuration:(NSTimeInterval)duration markCodeInt:(NSUInteger)markCodeInt {
    
    [self alertViewsWithMarkCodeInt:markCodeInt block:^(JKBaseView *maskView, JKBaseView *containView, JKWaitingView *waitingView, JKAdapterLabel *textLabel, JKInformView *informView) {
        //视图动画
        [UIView animateWithDuration:duration animations:^{
            //由于NSTimer的实时性，这里选择用视图动画，0.01透明度偏差，当作定时器
            containView.alpha = 0.71;
            //定时器完成后执行
        } completion:^(BOOL finished) {
            //控件渐变消失动画
            [UIView animateWithDuration:.3 animations:^{
                //容器透明
                [JK_M hideAllAlertViewsWithMarkCodeInt:markCodeInt];
                //动画完成后执行
            } completion:^(BOOL finished) {
                //主窗口移除所有弹出
                [JK_M cleanAllAlertViewsWithMarkCodeInt:markCodeInt];
                //设置状态
                JK_M.isAlerted = NO;
            }];
        }];
    }];
}

#pragma mark - 按模块添加
- (void)coverEnable:(BOOL)enable {
    //设置状态
    JK_M.isAlerted = YES;
    //创建可交互视图
    JK_M.maskView = [[JKBaseView alloc] initWithFrame:JK_M.mainWindow.bounds];
    //设置透明
    JK_M.maskView.backgroundColor = [UIColor clearColor];
    //设置是否可以交互
    if (enable) {
        [JK_M.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissElast)]];
    }
    //主窗口添加可交互视图
    [JK_M.mainWindow addSubview:JK_M.maskView];
}

- (void)containSide:(CGFloat)side block:(jk_block_fl)block {
    
    [self containSize:CGSizeMake(side, side) block:block];
}
- (void)containSize:(CGSize)size block:(jk_block_fl)block {
    //创建容器
    JK_M.containView = [[JKBaseView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    //容器居中
    JK_M.containView.center = SCREEN_CENTER;
    //容器背景色
    JK_M.containView.backgroundColor = [UIColor blackColor];
    //添加四边阴影
    [JK_M.containView shadowRect];
    //容器半透明
    JK_M.containView.alpha = 0.7;
    //添加容器到主窗口
    [JK_M.mainWindow addSubview:JK_M.containView];
    //执行代码块
    if (block) block(size.width == size.height ? size.width : 0);
}
- (void)waitingJudge:(BOOL)isAlert block:(jk_block_t)block {
    //判断是否要显示
    if (isAlert) {
        //判断代码块
        if (block) {
            //执行代码块
            block();
        }
    }else {
        //判断是否有弹窗正在显示
        if (JK_M.isAlerted) {
            //清理所有弹窗
            [JK_M dismissElast];
        }
    }
}
#pragma mark - functions
- (NSString *)markCodeInt:(NSUInteger)markCodeInt asString:(NSString *)string {
    return [NSString stringWithFormat:@"%lu%@", markCodeInt, string];
}
- (void)markCodeAllAlertViews:(NSUInteger)markCodeInt {
    JK_M.maskView.markCode = [self markCodeInt:markCodeInt asString:JKMaskCode];
//    NSLog(@"maskView -> %@", JK_M.maskView.markCode);
    JK_M.containView.markCode = [self markCodeInt:markCodeInt asString:JKContainCode];
//    NSLog(@"containView -> %@", JK_M.containView.markCode);
    JK_M.informView.markCode = [self markCodeInt:markCodeInt asString:JKInformCode];
//    NSLog(@"informView -> %@", JK_M.informView.markCode);
    JK_M.textLabel.markCode = [self markCodeInt:markCodeInt asString:JKTextCode];
//    NSLog(@"textLabel -> %@", JK_M.textLabel.markCode);
    JK_M.waitView.markCode = [self markCodeInt:markCodeInt asString:JKWaitCode];
//    NSLog(@"waitView -> %@", JK_M.waitView.markCode);
}
- (NSUInteger)timestamp {
    return (NSInteger)(time(NULL));
}

- (void)alertViewsWithMarkCodeInt:(NSUInteger)markCodeInt block:(jk_block_views)block {
    JKInformView *informView = (JKInformView *)[JK_M.mainWindow viewWithMarkCode:[self markCodeInt:markCodeInt asString:JKInformCode]];
    JKAdapterLabel *textLabel = (JKAdapterLabel *)[JK_M.mainWindow viewWithMarkCode:[self markCodeInt:markCodeInt asString:JKTextCode]];
    JKBaseView *containView = [JK_M.mainWindow viewWithMarkCode:[self markCodeInt:markCodeInt asString:JKContainCode]];
    JKWaitingView *waitingView = (JKWaitingView *)[JK_M.mainWindow viewWithMarkCode:[self markCodeInt:markCodeInt asString:JKWaitCode]];
    JKBaseView *maskView = [JK_M.mainWindow viewWithMarkCode:[self markCodeInt:markCodeInt asString:JKMaskCode]];
    if (block) {
        block(maskView, containView, waitingView, textLabel, informView);
    }
}
@end
