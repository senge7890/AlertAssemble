//
//  JKAlertManager.h
//  AlertAssemble
//
//  Created by 四威 on 2016/8/1.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKInformView.h"
#import "JKWaitingView.h"
#import "JKAdapterLabel.h"
#import "NSObject+JKAlert.h"


extern NSString *const JKMaskCode; //交互视图标记
extern NSString *const JKInformCode; //标识视图标记
extern NSString *const JKWaitCode; //等待视图标记
extern NSString *const JKContainCode; //容器标记
extern NSString *const JKTextCode; //文本标签标记


typedef void (^jk_block_fl)(CGFloat num);

//快速引用单例
#define JK_M [JKAlertManager manager]
//默认持续时间
#define DURATION_DEFAULT 3.0

//弹窗管理器
@interface JKAlertManager : NSObject

//可交互视图
@property (nonatomic, strong) JKBaseView *maskView;
//标识视图
@property (nonatomic, strong) JKInformView *informView;
//容器视图
@property (nonatomic, strong) JKBaseView *containView;
//文本视图
@property (nonatomic, strong) JKAdapterLabel *textLabel;
//等待视图
@property (nonatomic, strong) JKWaitingView *waitView;
//主窗口是否存在弹窗
@property (nonatomic, assign) BOOL isAlerted;
//主窗口
@property (nonatomic, strong) UIWindow *mainWindow;
//持续时间
@property (nonatomic, assign) NSTimeInterval duration;

//快速创建
+ (instancetype)manager;
//弹性移除所有视图
- (void)dismissElast;
/**
 *  主窗口移除所有弹窗
 *
 *  @param markCodeInt 标记码
 */
- (void)cleanAllAlertViewsWithMarkCodeInt:(NSUInteger)markCodeInt;
/**
 *  隐藏所有弹窗
 *
 *  @param markCodeInt 标记码
 */
- (void)hideAllAlertViewsWithMarkCodeInt:(NSUInteger)markCodeInt;
//添加弹性
- (void)elastAllAlertViews;
/**
 *  普通移除
 *
 *  @param markCodeInt 标记码
 */
- (void)dismissNormalWithMarkCodeInt:(NSUInteger)markCodeInt;
/**
 *  定时移除
 *
 *  @param duration 持续时间
 */
- (void)dismissDuration:(NSTimeInterval)duration markCodeInt:(NSUInteger)markCodeInt;
/**
 *  添加交互视图
 *
 *  @param enable 是否可以交互
 */
- (void)coverEnable:(BOOL)enable;
/**
 *  添加方形容器
 *
 *  @param side  边长
 *  @param block handle
 */
- (void)containSide:(CGFloat)side block:(jk_block_fl)block;
/**
 *  添加矩形容器
 *
 *  @param size  宽高
 *  @param block handle
 */
- (void)containSize:(CGSize)size block:(jk_block_fl)block;
/**
 *  等待视图判断
 *
 *  @param isAlert 显示/隐藏
 *  @param block   handle
 */
- (void)waitingJudge:(BOOL)isAlert block:(jk_block_t)block;
/**
 *  所有弹窗设置标记码
 *
 *  @param markCode 标记码
 */
- (void)markCodeAllAlertViews:(NSUInteger)markCode;
/**
 *  时间戳转UInt
 *
 *  @return 
 */
- (NSUInteger)timestamp;
@end

