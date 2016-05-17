//
//  ShapLoadingView.m
//  AnimationDemo
//
//  Created by 路贵斌 on 15/11/11.
//  Copyright © 2015年 Author. All rights reserved.
//



#import "ShapLoadingView.h"

@interface ShapLoadingView ()

@property (nonatomic ,strong) CAShapeLayer  *loadLayer;
@property (nonatomic ,strong) UILabel       *progressLabel;

@end

@implementation ShapLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.loadLayer = [self createShapeLayer];
    [self initProgressLabel];
    
    [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(loading) userInfo:nil repeats:YES];
    
}

- (void)initProgressLabel
{
    self.progressLabel = [[UILabel alloc]initWithFrame:self.bounds];
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel.font = [UIFont boldSystemFontOfSize:30];
    self.progressLabel.textColor = [UIColor blackColor];
    [self addSubview:self.progressLabel];
}



-(CAShapeLayer *)createShapeLayer
{
    //shapLayer  一定要有形状  一般跟 bezierPath 配合
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.fillMode = kCAFillModeForwards;
    shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    shapeLayer.lineWidth = 20.0f;
    
    shapeLayer.lineCap = kCALineCapRound;
    //如果开启了线边缘的圆帽 kCALineCapRound 效果 或者 squre效果  ， 就会在两个边缘额外绘制对应的效果图形 ，造成你的 间隔 距离 看起来变小很多
    
    shapeLayer.lineDashPattern = @[@20.0,@40.0f];
    [self.layer addSublayer:shapeLayer];
    
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    shapeLayer.path = path.CGPath;
    
    shapeLayer.strokeStart = 0.0;

    return shapeLayer;

}

- (void)loading
{
    CGFloat end = self.loadLayer.strokeEnd <= 0.9 ? self.loadLayer.strokeEnd: 0.0;
    self.loadLayer.strokeEnd = end + 0.1;
    self.progressLabel.text = [NSString stringWithFormat:@"%.2f%@",self.loadLayer.strokeEnd*100.0,@"%"];

}




@end
