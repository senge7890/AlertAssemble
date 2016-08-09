//
//  JKAdapterLabel.h
//  AlertAssemble
//
//  Created by 四威 on 2016/8/5.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKBaseView.h"

/**
 根据文字、最大宽、字体，自适应宽高的文本标签
 
 - returns: 返回一个带文本，宽高（无坐标）的Label
 */
@interface JKAdapterLabel : JKBaseView

/**
 *  初始化方法  (只能使用此方法初始化, 其他初始化方法无效)
 *
 *  @param text     文本
 *  @param font     字体
 *  @param maxWidth 最大宽
 *
 *  @return
 */
- (instancetype)initWithText:(NSString *)text font:(UIFont *)font maxWitdth:(CGFloat)maxWidth;



@end
