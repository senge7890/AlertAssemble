//
//  JKAlertManager.m
//  AlertAssemble
//
//  Created by 四威 on 2016/8/1.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKAlertManager.h"
#import "UIView+JKAlert.h"

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

- (void)cleanAllAlertViews {
    //移除标识视图
    [self.informView removeFromSuperview];
    //移除文本视图
    [self.textLabel removeFromSuperview];
    //移除容器视图
    [self.containView removeFromSuperview];
    //移除等待视图
    [self.waitView removeFromSuperview];
    //移除可交互视图
    [self.maskView removeFromSuperview];
    //置空标识视图
    self.informView = nil;
    //置空文本视图
    self.textLabel = nil;
    //置空容器视图
    self.containView = nil;
    //置空等待视图
    self.waitView = nil;
    //置空可交互视图
    self.maskView = nil;
}
- (void)hideAllAlertViews {
    //隐藏标识视图
    self.informView.alpha = 0;
    //隐藏文本视图
    self.textLabel.alpha = 0;
    //隐藏容器视图
    self.containView.alpha = 0;
    //隐藏等待视图
    self.waitView.alpha = 0;
    //隐藏可交互视图
    self.maskView.alpha = 0;
}
- (void)cleanOldAlertViews:(jk_block_t)block {
    
    [JK_M cleanAllAlertViews];
    
    if(block) block();
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
- (void)dismissNormal {
    //控件渐变消失动画
    [UIView animateWithDuration:.3 animations:^{
        //容器透明
        [JK_M hideAllAlertViews];
        //动画完成后执行
    } completion:^(BOOL finished) {
        //主窗口移除所有弹出
        [JK_M cleanAllAlertViews];
        //设置状态
        JK_M.isAlerted = NO;
    }];
}
- (void)dismissElast {
    NSArray *values = @[@(1), @(1.1), @(0)];
    //标识视图添加弹性
    [self.informView elastValues:values];
    //文本视图添加弹性
    [self.textLabel elastValues:values];
    //容器视图添加弹性
    [self.containView elastValues:values];
    //等待视图添加弹性
    [self.waitView elastValues:values];
    //控件渐变消失动画
    [UIView animateWithDuration:.2 animations:^{
        //容器透明
        [JK_M hideAllAlertViews];
        //动画完成后执行
    } completion:^(BOOL finished) {
        //主窗口移除所有弹出
        [JK_M cleanAllAlertViews];
        //设置状态
        JK_M.isAlerted = NO;
    }];
}
- (void)dismissDuration:(NSTimeInterval)duration {
    //视图动画
    [UIView animateWithDuration:duration animations:^{
        //由于NSTimer的实时性，这里选择用视图动画，0.01透明度偏差，当作定时器
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
            [JK_M cleanAllAlertViews];
            //设置状态
            JK_M.isAlerted = NO;
        }];
    }];
}

- (void)coverEnable:(BOOL)enable {
    //设置状态
    JK_M.isAlerted = YES;
    //创建可交互视图
    JK_M.maskView = [[UIView alloc] initWithFrame:JK_M.mainWindow.bounds];
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
    JK_M.containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
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
@end
