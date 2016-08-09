//
//  JKAdapterLabel.m
//  AlertAssemble
//
//  Created by 四威 on 2016/8/5.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKAdapterLabel.h"
#import "UIView+JKAlert.h"
#import "NSString+JKAlert.h"

@implementation JKAdapterLabel

- (instancetype)initWithText:(NSString *)text font:(UIFont *)font maxWitdth:(CGFloat)maxWidth {
    if (self = [super init]) {
        //背景色
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] init];
        
        label.text = text;
        //背景色
        label.backgroundColor = [UIColor clearColor];
        //文本色
        label.textColor = [UIColor whiteColor];
        //多行
        label.numberOfLines = 0;
        //字体
        label.font = font;
        //居中样式
        label.textAlignment = NSTextAlignmentLeft;
        //文字实际宽
        CGFloat textRealWidth = [text widthWithFont:font];
        //文字按最大宽取高
        CGFloat textRealHight = [text heightWithWidth:maxWidth font:font];
        //动态设置标签宽
        label.jk_width = textRealWidth <= maxWidth ? textRealWidth : maxWidth;
        //动态设置标签高
        label.jk_height = textRealWidth <= maxWidth ? font.lineHeight : textRealHight;
        
        self.jk_size = label.jk_size;
        
        [self addSubview:label];
    }
    return self;
}

@end
