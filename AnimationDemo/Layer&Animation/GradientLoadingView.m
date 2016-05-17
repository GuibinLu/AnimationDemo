
//
//  GradientLoadingView.m
//  AnimationDemo
//
//  Created by 路贵斌 on 15/11/12.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "GradientLoadingView.h"
#import "ShapLoadingView.h"

@interface GradientLoadingView ()

@property (nonatomic, strong) CAGradientLayer   *gradientLayer;
@property (nonatomic, strong) CAShapeLayer      *shapeLayer;

@end

@implementation GradientLoadingView

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
    //self.layer.contents = (__bridge id)[UIImage imageNamed:@"bottom"].CGImage;
    
    self.gradientLayer = [CAGradientLayer layer];
    
    self.gradientLayer.frame = self.bounds;
    self.gradientLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:self.gradientLayer];
    
    NSMutableArray * hsbColors = [NSMutableArray array];
    for (int hue = 10; hue < 360; hue ++) {
        UIColor * color = [UIColor colorWithHue:hue /360.0 saturation:1. brightness:1. alpha:1];
        [hsbColors addObject:(__bridge id)color.CGColor];
    }
    
    self.gradientLayer.colors = hsbColors;
    //self.gradientLayer.contents = (__bridge id)[UIImage imageNamed:@"bottom_light"].CGImage;
    
    
    [self initShapeLayer];
    
    self.gradientLayer.mask = self.shapeLayer;

    [NSTimer scheduledTimerWithTimeInterval:3. target:self selector:@selector(loadingAnimation) userInfo:nil repeats:YES];
    [self startAnimation];
    
}

- (void)startAnimation
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1.5;
    animation.toValue = @(M_PI * 2);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = HUGE_VAL;
    [self.gradientLayer addAnimation:animation forKey:@"rotation"];
    
    
}

-(void )initShapeLayer
{
    //shapLayer  一定要有形状  一般跟 bezierPath 配合
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.bounds;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.fillMode = kCAFillModeForwards;
    self.shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    self.shapeLayer.lineWidth = 10.;
    
    self.shapeLayer.lineCap = kCALineCapRound;
    //如果开启了线边缘的圆帽 kCALineCapRound 效果 或者 squre效果  ， 就会在两个边缘额外绘制对应的效果图形 ，造成你的 间隔 距离 看起来变小很多
    
    [self.layer addSublayer:self.shapeLayer];
    CGFloat width = self.shapeLayer.lineWidth;
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(width, width, self.bounds.size.width -width *2, self.bounds.size.width - width *2)];
    
    self.shapeLayer.path = path.CGPath;
    
    self.shapeLayer.strokeStart = 0.0;

}

- (void)loadingAnimation
{
    CGFloat end = self.shapeLayer.strokeEnd <= 0.9? self.shapeLayer.strokeEnd : 0.0 ;
    self.shapeLayer.strokeEnd = end + 0.1;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if (self.gradientLayer.speed == 0) {
        [self resumeAnimation];
    }else{
        [self pauseAnimation];
    }
}

- (void)resumeAnimation
{
    self.gradientLayer.beginTime = 0.0;
    NSLog(@"-----------currentTime:%lf",CACurrentMediaTime());
    CFTimeInterval beginTime = CACurrentMediaTime() - self.gradientLayer.timeOffset;
    self.gradientLayer.beginTime = beginTime;
    self.gradientLayer.speed = 1.0f;

    NSLog(@"-----------gradientLayer.beginTime:%lf \n-----timeoffset:%lf",self.gradientLayer.beginTime,self.gradientLayer.timeOffset);
    self.gradientLayer.timeOffset = 0.0;
    
}
- (void)pauseAnimation
{
    //double 取的指定图层的媒体时间 （现对于马赫 - 绝对时间的 currentTime)
    CFTimeInterval  interval = [self.gradientLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    //例如他走10秒 那么就先让他在时间轴上 往前移动十秒 （相对于绝对时间往前移动）
    self.gradientLayer.timeOffset = interval;
    self.gradientLayer.speed = 0;
}


@end
