//
//  DrawTextView.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/30.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "DrawTextView.h"
#import <CoreText/CoreText.h>

#define PointNum 4
#define DrawTime 20.f
#define PointTime 20.f

@interface DrawTextView ()

@property (nonatomic,strong) NSMutableArray *pointsArray;
@property (nonatomic,strong) CAEmitterLayer *emitterLayer;

@end

@implementation DrawTextView

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (id)initWithFrame:(CGRect)frame String:(NSString *)string font:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initLayer];
        [self initUIWithString:string font:font];
        [self initEmitter];
        
        [self startAnimation];
    }
    return self;
}

- (void)initData
{
    self.pointsArray = [NSMutableArray array];
}

- (void)initLayer
{
    [self resetShapeLayer];
    [self initPoints];
}

- (void)resetShapeLayer
{
    self.layer.geometryFlipped = YES; // 坐标沿x翻转
    
    [(CAShapeLayer *)self.layer setLineWidth:2.f];
    [(CAShapeLayer *)self.layer setStrokeColor:[UIColor cyanColor].CGColor];
    [(CAShapeLayer *)self.layer setLineJoin:kCALineJoinRound];
    [(CAShapeLayer *)self.layer setLineCap:kCALineCapRound];
}

- (void)initPoints
{
    for (int i = 0; i < PointNum; i++) {
        CALayer *pointLayer = [CALayer layer];
        pointLayer.contentsScale = [UIScreen mainScreen].scale;
        pointLayer.bounds = CGRectMake(0, 0, 6, 6);
        pointLayer.contents = (__bridge id)[UIImage imageNamed:@"point2"].CGImage;
        [self.layer addSublayer:pointLayer];
        [self.pointsArray addObject:pointLayer];
    }

}

- (void)initUIWithString:(NSString *)string font:(UIFont *)uiFont
{
    //先拿到字体
    CTFontRef font  = CTFontCreateWithName((CFStringRef )uiFont.fontName, uiFont.pointSize, NULL);
    //创建一个可变字符串 拿到对应区间的字符路径
    NSAttributedString * attrString = [[NSAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:uiFont}];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef )attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    CGMutablePathRef paths = CGPathCreateMutable();
    for (CFIndex i = 0; i < CFArrayGetCount(runArray);i++ ) {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, i);
        for (CFIndex j = 0; j<CTRunGetGlyphCount(run); j++) {
            CFRange range = CFRangeMake(j, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, range, &glyph);
            CTRunGetPositions(run, range, &position);
            CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
            CGPathRef path = CTFontCreatePathForGlyph(font, glyph, NULL);
            CGPathAddPath(paths, &t, path);
            CGPathRelease(path);
        }
    }
    CFRelease(font);

    [(CAShapeLayer *)self.layer setPath:paths];
    [(CAShapeLayer *)self.layer setBounds:CGPathGetBoundingBox(paths)];
    CGPathRelease(paths);
    
    
    
}

- (void)initEmitter
{
    self.emitterLayer = [CAEmitterLayer layer];
    self.emitterLayer.emitterPosition = CGPointMake(-100, 0);
    self.emitterLayer.emitterSize = CGSizeMake(2, 2);
    self.emitterLayer.renderMode = kCAEmitterLayerAdditive;
    self.emitterLayer.emitterShape = kCAEmitterLayerPoint;
    self.emitterLayer.emitterMode = kCAEmitterLayerPoints;
    
    CAEmitterCell* stars = [[CAEmitterCell alloc]init];
    stars.contentsScale  = [UIScreen mainScreen].scale;
    stars.contents       = (__bridge id)[UIImage imageNamed:@"TwinkleImage"].CGImage;
    stars.birthRate      = 6;
    stars.lifetime       = 40;
    stars.name           = @"stars";
    
    stars.xAcceleration  = -5.f;
    stars.yAcceleration  = 5.f;// self.layer 已经沿着x轴翻转

    self.emitterLayer.emitterCells = @[stars];
    
    [self.layer addSublayer:self.emitterLayer];
    
}


- (void)startAnimation
{
    [self strokeAnimation];
    [self pointsAnimaiton];
    [self emitterPositionAnimation];
}


- (void)strokeAnimation
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = DrawTime;
    [self.layer addAnimation:animation forKey:@"StrokeEnd"];
}

- (void)pointsAnimaiton
{
    [self.pointsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CALayer * pointLayer               = (CALayer *)obj;

        CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        keyAnimation.timeOffset              = idx * 0.1f;
        keyAnimation.path                  = [(CAShapeLayer *)self.layer path];
        keyAnimation.duration              = PointTime;
        keyAnimation.calculationMode       = kCAAnimationCubicPaced;
        keyAnimation.repeatCount           = HUGE_VAL;
        keyAnimation.autoreverses          = YES;

        [pointLayer addAnimation:keyAnimation forKey:@"Point"];
    }];

}

- (void)emitterPositionAnimation
{
    CAKeyframeAnimation * keyAnimation3 = [CAKeyframeAnimation animationWithKeyPath:@"emitterPosition"];
    keyAnimation3.path = [(CAShapeLayer *)self.layer path];
    keyAnimation3.duration = PointTime;
    keyAnimation3.calculationMode = kCAAnimationCubicPaced;
    [self.emitterLayer addAnimation:keyAnimation3 forKey:@"Emitter"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([self.emitterLayer valueForKey:@"Emitter"] == anim) {
        [self.emitterLayer removeFromSuperlayer];
    }
}

- (void)crumbling
{
    //[(CAEmitterCell *)self.emitterLayer.emitterCells[0] setEnabled: YES];
}






@end
