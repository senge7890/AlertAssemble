//
//  JKInformView.m
//  AlertAssemble
//
//  Created by 四威 on 2016/8/1.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKInformView.h"

//比例1/7
#define ONE_SEVENTH 0.14

@interface JKInformView () {
    //全局动画图层
    CAShapeLayer *layer;
}
//标识类型
@property (nonatomic, assign) JKInformStyle stylePrivate;

@end

@implementation JKInformView

- (instancetype)initWithFrame:(CGRect)frame style:(JKInformStyle)style {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        //赋值私有成员变量
        _stylePrivate = style;
        //画圆动画
        [self drawRound];
    }
    return self;
}

//画圆动画
- (void)drawRound {
    //创建路径对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    //添加原型路径
    [path addArcWithCenter:CGPointMake(half(self.jk_width), half(self.jk_height)) radius:half(self.jk_width) startAngle:0 endAngle:2 * M_PI clockwise:NO];
    //初始化图层
    layer = [CAShapeLayer layer];
    //赋值图层绘图路径
    layer.path = path.CGPath;
    //图层填充色
    layer.fillColor = [UIColor clearColor].CGColor;
    //图层线条色
    layer.strokeColor = [UIColor whiteColor].CGColor;
    //线条粗度
    layer.lineWidth = LINE_WIDTH;
    //图层位置、尺寸
    layer.frame = self.bounds;
    //视图添加子图层
    [self.layer addSublayer:layer];
    //开始绘图
    [self drawLineAnimation];
    //根据标识类型判断执行哪个绘图方法 (判断所有可能, 尽量不用三目)
    SEL drawAction;
    switch (_stylePrivate) {
        case JKInformStyleTick:
            drawAction = @selector(drawInformTick);
            break;
        case JKInformStyleCross:
            drawAction = @selector(drawInfromCross);
            break;
    }
    //延时执行
    [self performSelector:drawAction withObject:nil afterDelay:ANIMATE_DURATION];
}

//画钩
- (void)drawInformTick {
    //视图对角线一半
    double cl = half(self.jk_height * sqrt(2.0));
    //对角线一半减去圆形半径获取偏差对角线
    double scl = cl - half(self.jk_height);
    //根据偏差对角线算出宽高
    double cwh = scl / sqrt(2.0);
    //视图1/7 作为偏移量
    CGFloat offset = self.jk_width * ONE_SEVENTH;
    //创建路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(cwh, cwh + 2 * offset, 0, 0)];
    //钩左半部分
    [path addLineToPoint:CGPointMake(half(self.jk_width), half(self.jk_height) + 2 * offset)];
    //钩右半部分
    [path addLineToPoint:CGPointMake(self.jk_width - cwh, cwh + offset)];
    //初始化图层
    layer = [CAShapeLayer layer];
    //赋值路径
    layer.path = path.CGPath;
    //填充色
    layer.fillColor = [UIColor clearColor].CGColor;
    //线条色
    layer.strokeColor = [UIColor whiteColor].CGColor;
    //线粗
    layer.lineWidth = LINE_WIDTH;
    //位置尺寸
    layer.frame = self.bounds;
    //添加子图层
    [self.layer addSublayer:layer];
    //绘图
    [self drawLineAnimation];
}

- (void)drawInfromCross {
    
    double cl = half(self.jk_height * sqrt(2.0));
    
    double scl = cl - half(self.jk_height);
    
    double cwh = scl / sqrt(2.0) + (self.jk_width * ONE_SEVENTH);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(cwh, cwh, 0, 0)];
    
    [path addLineToPoint:CGPointMake(self.jk_width - cwh, self.jk_height - cwh)];
    
    [path moveToPoint:CGPointMake(self.jk_width - cwh, cwh)];
    
    [path addLineToPoint:CGPointMake(cwh, self.jk_height - cwh)];
    
    layer = [CAShapeLayer layer];
    
    layer.path = path.CGPath;
    
    layer.fillColor = [UIColor clearColor].CGColor;
    
    layer.strokeColor = [UIColor whiteColor].CGColor;
    
    layer.lineWidth = LINE_WIDTH;
    
    layer.frame = self.bounds;
    
    [self.layer addSublayer:layer];
    
    [self drawLineAnimation];
}

- (void)drawLineAnimation{
    //创建动画
    CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //设置持续时间
    bas.duration = ANIMATE_DURATION;
    //设置代理
//    bas.delegate = self;
    //开始值
    bas.fromValue = [NSNumber numberWithInteger:0];
    //结束值
    bas.toValue = [NSNumber numberWithInteger:1];
    //图层添加动画
    [layer addAnimation:bas forKey:@"key"];
}
@end
