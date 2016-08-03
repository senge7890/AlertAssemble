//
//  JKInformView.h
//  AlertAssemble
//
//  Created by 四威 on 2016/8/1.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import <UIKit/UIKit.h>


//标识视图
@interface JKInformView : UIView

/**
 *  自定义构造方法
 *
 *  @param frame 位置、尺寸
 *  @param style 标识类型
 *
 *  @return 
 */
- (instancetype)initWithFrame:(CGRect)frame style:(JKInformStyle)style;

@end
