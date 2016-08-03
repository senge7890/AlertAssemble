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

typedef void (^jk_block_fl)(CGFloat num);

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
    [self clearOldAlertShowNewAlertAction:@selector(alertContentsWithText:) object:text block:^{
        //设置文本标签样式
        UIFont *font = [UIFont systemFontOfSize:15];
        //实例化
        JK_M.textLabel = [[UILabel alloc] init];
        //文本
        JK_M.textLabel.text = text;
        //背景色
        JK_M.textLabel.backgroundColor = [UIColor clearColor];
        //文本色
        JK_M.textLabel.textColor = [UIColor whiteColor];
        //多行
        JK_M.textLabel.numberOfLines = 0;
        //字体
        JK_M.textLabel.font = font;
        //居中样式
        JK_M.textLabel.textAlignment = NSTextAlignmentLeft;
        //容器最大宽
        CGFloat containMaxWidth = SCREEN_WIDTH - 100;
        //文字最大宽
        CGFloat textMaxWidth = containMaxWidth - 30;
        //文字实际宽
        CGFloat textRealWidth = [text widthWithFont:font];
        //文字按最大宽取高
        CGFloat textRealHight = [text heightWithWidth:textMaxWidth font:font];
        //动态设置标签宽
        JK_M.textLabel.jk_width = textRealWidth <= textMaxWidth ? textRealWidth : textMaxWidth;
        //动态设置标签高
        JK_M.textLabel.jk_height = textRealWidth <= textMaxWidth ? font.lineHeight : textRealHight;
        //居中
        JK_M.textLabel.center = SCREEN_CENTER;
        //添加容器
        [self containSize:CGSizeMake(JK_M.textLabel.jk_width + 30, JK_M.textLabel.jk_height + 20) block:^(CGFloat num) {
            //添加标签
            [JK_M.mainWindow addSubview:JK_M.textLabel];
            //定时移除
            [self dismissDefault:JK_M.duration];
        }];
        //添加不可交互视图
        [self coverEnable:NO];
    }];
}
#pragma mark - 等待视图相关
+ (void)alertWaiting:(BOOL)isAlert {
    //判断是否要显示
    if (isAlert) {
        //判断是否有弹窗正在显示
        [self clearOldAlertShowNewAlertAction:@selector(alertWaiting:) object:[NSNumber numberWithBool:isAlert] block:^{
            //添加容器到主窗口
            [self containSide:SCREEN_WIDTH * 0.2 block:^(CGFloat num) {
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
            [self coverEnable:YES];
        }];
    }else {
        //判断是否有弹窗正在显示
        if (JK_M.isAlerted) {
            //清理所有弹窗
            [self dismissNormal];
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
/**
 *  根据类型判断显示哪一种提示
 *
 *  @param style 提示类型
 */
+ (void)alertInformWithStyle:(JKInformStyle)style{
    //判断是否有弹窗正在显示
    [self clearOldAlertShowNewAlertAction:@selector(alertInformWithStyle:) object:[NSNumber numberWithUnsignedInteger:style] block:^{
        //添加容器到主窗口
        [self containSide:SCREEN_WIDTH * 0.3 block:^(CGFloat num) {
            //内容宽高
            CGFloat iWH = num * 0.4;
            //创建内容并设置标识类型
            JK_M.informView = [[JKInformView alloc] initWithFrame:CGRectMake(0, 0, iWH, iWH) style:style];
            //内容居中
            JK_M.informView.center = SCREEN_CENTER;
            //添加内容到主窗口
            [JK_M.mainWindow addSubview:JK_M.informView];
            //定时移除
            [self dismissDefault:JK_M.duration];
        }];
        //创建不可交互视图
        [self coverEnable:NO];
    }];
}

#pragma mark - 移除视图相关
/**
 *  定时移除弹窗
 */
+ (void)dismissDefault:(NSTimeInterval)duration {
    //视图动画
    [UIView animateWithDuration:duration animations:^{
        //由于NSTimer的实时性，这里选择用视图动画，0.01透明度偏差肉眼看不出来，当作定时器
        JK_M.containView.alpha = 0.71;
        //定时器完成后执行
    } completion:^(BOOL finished) {
        //控件渐变消失动画
        [UIView animateWithDuration:.3 animations:^{
            //容器透明
            [JK_M hideAllAlertViews];
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
        [JK_M hideAllAlertViews];
        //动画完成后执行
    } completion:^(BOOL finished) {
        //主窗口移除所有弹出
        [JK_M clearAllAlertViews];
        //设置状态
        JK_M.isAlerted = NO;
    }];
}

#pragma mark - 按块创建
//交互视图
+ (void)coverEnable:(BOOL)enable {
    //设置状态
    JK_M.isAlerted = YES;
    //创建可交互视图
    JK_M.maskView = [[UIView alloc] initWithFrame:JK_M.mainWindow.bounds];
    //设置透明
    JK_M.maskView.backgroundColor = [UIColor clearColor];
    //设置是否可以交互
    if (enable) {
        [JK_M.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissNormal)]];
    }
    //主窗口添加可交互视图
    [JK_M.mainWindow addSubview:JK_M.maskView];
}
//容器
+ (void)containSide:(CGFloat)side block:(jk_block_fl)block {
    [self containSize:CGSizeMake(side, side) block:block];
}
+ (void)containSize:(CGSize)size block:(jk_block_fl)block {
    //创建容器
    JK_M.containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    //容器居中
    JK_M.containView.center = SCREEN_CENTER;
    //容器背景色
    JK_M.containView.backgroundColor = [UIColor blackColor];
    //容器圆角
    JK_M.containView.layer.shadowRadius = 5;
    //阴影尺寸位置
    CGRect shadowBounds = CGRectMake(-1, -1, JK_M.containView.jk_width + 2, JK_M.containView.jk_height + 2);
    //阴影圆角
    JK_M.containView.layer.cornerRadius = 5;
    //阴影底色
    JK_M.containView.layer.shadowColor = [UIColor blackColor].CGColor;
    //阴影范围
    JK_M.containView.layer.shadowPath = [UIBezierPath bezierPathWithRect:shadowBounds].CGPath;
    //阴影透明度
    JK_M.containView.layer.shadowOpacity = 0.5;
//    //容器裁剪超出父图层内容
//    JK_M.containView.layer.masksToBounds = YES;
    //容器半透明
    JK_M.containView.alpha = 0.7;
    //添加容器到主窗口
    [JK_M.mainWindow addSubview:JK_M.containView];
    //执行代码块
    if (block) block(size.width == size.height ? size.width : 0);
}
//清理旧视图显示新视图
+ (void)clearOldAlertShowNewAlertAction:(SEL)action object:(id)object block:(jk_block_t)block {
    //判断是否有弹窗正在显示
    if (JK_M.isAlerted) {
        //清理所有弹窗
        [JK_M clearAllAlertViews];
        //设置状态
        JK_M.isAlerted = NO;
        //延时执行（确保已经清理掉旧视图）
        [self performSelector:action withObject:object afterDelay:0.1];
    }else {
        if(block) block();
    }
}
@end
