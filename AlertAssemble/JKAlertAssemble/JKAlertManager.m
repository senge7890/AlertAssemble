//
//  JKAlertManager.m
//  AlertAssemble
//
//  Created by 四威 on 2016/8/1.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKAlertManager.h"


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
        m.duration = DURATION_DEFAULT;
    });
    //返回对象
    return m;
}

- (void)clearAllAlertViews {
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
@end
