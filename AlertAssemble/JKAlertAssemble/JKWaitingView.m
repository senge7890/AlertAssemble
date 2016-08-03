//
//  JKWaitingView.m
//  AlertAssemble
//
//  Created by 四威 on 2016/8/3.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "JKWaitingView.h"
#import "NSObject+JKAlert.h"

@interface JKWaitingView (){
    //全局图层对象
    CAShapeLayer *layer;
    //全局角度变量
    CGFloat angle;
}
@end

@implementation JKWaitingView

//自定义构造
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        //初始化角度
        angle = 1;
        //画圆
        [self drawRound];
    }
    return self;
}
//画圆动画
- (void)drawRound {
    //创建路径对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    //添加弧形路径(0~320度“一个缺角的圆形”)
    [path addArcWithCenter:CGPointMake(half(self.jk_width), half(self.jk_height)) radius:half(self.jk_width) * 0.7 startAngle:0 endAngle:angleMake(-320) clockwise:NO];
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
}


- (void)drawLineAnimation{
    //创建动画
    CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //开始值
    bas.fromValue = [NSNumber numberWithInteger:1];
    //结束值
    bas.toValue = [NSNumber numberWithInteger:1];
    //图层添加动画
    [layer addAnimation:bas forKey:@"key"];
    //滚动
    [self startAnimation];
}
- (void)startAnimation {
    //创建动画
    [UIView beginAnimations:nil context:nil];
    //设置持续时间
    [UIView setAnimationDuration:0.02];
    //设置代理
    [UIView setAnimationDelegate:self];
    //代理事件(动画完毕后执行)
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    //动画内容
    self.transform = CGAffineTransformMakeRotation(angleMake(angle));
    //提交动画
    [UIView commitAnimations];
}

- (void)endAnimation {
    //角度加十
    angle += 10;
    //再次执行动画
    [self startAnimation];
}
@end
