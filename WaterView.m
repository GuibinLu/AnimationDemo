//
//  WaterView.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/3.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "WaterView.h"

@interface WaterView () {
    
    
    float _currentLinePointY;
    
    float a;
    //波浪速度
    float b;
    //循环波动
    BOOL jia;
}
@end


@implementation WaterView

+(Class)layerClass
{
    return [CAShapeLayer class];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
        [self initUIWithFrame:frame];
        [self initTimer];
 
    }
    return self;
}

- (void)initTimer
{
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)initData
{
    a = 1.5;
    b = 0;
    jia = NO;
}

- (void)initUIWithFrame:(CGRect)frame
{
    [self setBackgroundColor:[UIColor clearColor]];
    CAShapeLayer * shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.fillColor = [UIColor colorWithRed:213/255.0f green:157/255.0f blue:20/255.0f alpha:1].CGColor;
    shapeLayer.lineWidth = 1.0;
    shapeLayer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
    shapeLayer.fillMode = kCAFillModeForwards;
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:shapeLayer.bounds].CGPath;
    
    shapeLayer.mask = maskLayer ;

}

-(void)setPercentum:(float)percentum {
    _percentum = percentum;
    _currentLinePointY = self.frame.size.height * (1.0f - _percentum);
}
-(void)animateWave {
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    
    if (a<=1) {
        jia = YES;
    }
    
    if (a>=1.5) {
        jia = NO;
    }
    
    
    b+=0.07;
    [self updateShapLayer];
}

- (void)updateShapLayer
{
    float y=_currentLinePointY;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x=0;x<=self.frame.size.width;x++){
        y= a * sin( x/90*M_PI + 4*b/M_PI ) * 5 + _currentLinePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, self.frame.size.width, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, _currentLinePointY);
    [(CAShapeLayer *)self.layer setPath:path];
    CGPathRelease(path);
}


@end
