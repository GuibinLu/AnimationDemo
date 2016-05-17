//
//  CLabel.m
//  AnimationDemo
//
//  Created by 路贵斌 on 16/5/14.
//  Copyright © 2016年 Author. All rights reserved.
//

#import "CLabel.h"

@interface CLabel ()<NSLayoutManagerDelegate>

@property (nonatomic, strong) NSTextStorage     *textStorage;
@property (nonatomic, strong) NSLayoutManager   *textLayoutManager;
@property (nonatomic, strong) NSTextContainer   *textContainer;

@property (nonatomic, strong) NSMutableArray    *oldLayers;
@property (nonatomic, strong) NSMutableArray    *newlayers;

@end

@implementation CLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initStorage];
    }
    return self;
}

- (void)initStorage
{
    self.textContainer = [[NSTextContainer alloc]initWithSize:self.bounds.size];
    self.textContainer.lineBreakMode = self.lineBreakMode;
    self.textContainer.maximumNumberOfLines = self.numberOfLines;
    self.textLayoutManager = [[NSLayoutManager alloc]init];
    [self.textLayoutManager addTextContainer:self.textContainer];
    self.textLayoutManager.delegate =self;
    self.textStorage = [[NSTextStorage alloc]init];
    [self.textStorage addLayoutManager:self.textLayoutManager];
}

- (NSMutableArray *)newlayers
{
    if (!_newlayers) {
        _newlayers = @[].mutableCopy;
    }
    return _newlayers;
}

- (NSMutableArray *)oldLayers
{
    if (!_oldLayers) {
        _oldLayers = @[].mutableCopy;
    }
    return _oldLayers;
}

- (NSString *)text
{
    return self.textStorage.string;
}

- (void)setText:(NSString *)text
{
    if (text) {
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        style.alignment = self.textAlignment;
        [attributedText addAttributes:@{NSFontAttributeName : self.font,NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:self.textColor} range:NSMakeRange(0, text.length)];
        self.attributedText = attributedText;
    }
}

- (NSAttributedString *)attributedText
{
    return (NSAttributedString *)self.textStorage;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    for (CALayer *subLayer in self.oldLayers) {
        [subLayer removeFromSuperlayer];
    }
    
    self.oldLayers = [NSMutableArray arrayWithArray:self.newlayers];
    [self.textStorage setAttributedString:attributedText];
    [self startOldLayersAnimation];
    [self startNewLayersAnimation];
}

- (void)layoutManager:(NSLayoutManager *)layoutManager didCompleteLayoutForTextContainer:(NSTextContainer *)textContainer atEnd:(BOOL)layoutFinishedFlag
{
    [self setTextLayers];
}

- (void)setTextLayers
{
    [self.newlayers  removeAllObjects];
    NSRange wordRange = NSMakeRange(0, self.textStorage.string.length);
    CGRect layoutRect = [self.textLayoutManager usedRectForTextContainer:self.textContainer];
    
    NSUInteger index = 0;
    NSUInteger totalLength = NSMaxRange(wordRange);
    
    while (index < totalLength) {
        NSRange glyphRange = NSMakeRange(index, 1);
        NSRange characterRange = [self.textLayoutManager characterRangeForGlyphRange:glyphRange actualGlyphRange:nil];
        NSTextContainer *textCon = [self.textLayoutManager textContainerForGlyphAtIndex:index effectiveRange:nil];
        CGRect glyphRect = [self.textLayoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textCon];
        NSRange keringRange = [self.textLayoutManager rangeOfNominallySpacedGlyphsContainingIndex:index];
        
        if (keringRange.location == index && keringRange.length > 1) {
            if (self.newlayers.count > 1) {
                CALayer *preLayer = self.newlayers[self.newlayers.count -1];
                CGRect frame = preLayer.frame;
                frame.size.width += fabs(frame.size.width - glyphRect.size.width);
                preLayer.frame = frame;
            }
        }
        
        glyphRect.origin.y += (self.bounds.size.height - layoutRect.size.height)/2.0;
        CATextLayer * textLayer = [[CATextLayer alloc]init];
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.frame = glyphRect;
        textLayer.string = [self.attributedText attributedSubstringFromRange:characterRange];
        textLayer.opacity = 0.0;
        [self.layer addSublayer:textLayer];
        [self.newlayers addObject:textLayer];
        index += characterRange.length;
    }
    
}


- (void)startOldLayersAnimation
{
    
    for (CATextLayer * textLayer in self.oldLayers) {
        double duration = arc4random()%100/125.0 + 0.35;
        double delay = arc4random_uniform(100)/500;
        
        CGFloat distance = arc4random()%50 + 25.0;
        CGFloat angle = (arc4random())/M_PI_2-M_PI_4;
        CATransform3D transform = CATransform3DMakeTranslation(0, distance, 0);
        transform = CATransform3DRotate(transform, angle, 0, 0, 1);
        
        CABasicAnimation * animation =  [CABasicAnimation animationWithKeyPath:@"transform"];
        
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.beginTime = delay;
        animation.duration = duration;
        
        CABasicAnimation * animationO = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animationO.toValue = @(0.0);
        animationO.beginTime = delay;
        animationO.duration = duration;
        
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        
        animationGroup.animations = @[animation,animationO];
        
        animationGroup.fillMode = kCAFillModeForwards;
        animationGroup.removedOnCompletion = false;
        animationGroup.duration = delay + duration;
        animationGroup.delegate = self;
        [animationGroup setValue:textLayer forKey:@"textLayer"];
        animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [textLayer addAnimation:animationGroup forKey:@"transform"];
    }
}

- (void)startNewLayersAnimation
{
    for (CATextLayer *textLayer in self.newlayers) {
        double duration = arc4random()%100/125.0 + 0.35;
        double delay = arc4random_uniform(100)/500 + 0.07;
        
        CABasicAnimation * animationO = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animationO.toValue = @(1.0);
        animationO.beginTime = delay;
        animationO.duration = duration;
        
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        
        animationGroup.animations = @[animationO];
        
        animationGroup.fillMode = kCAFillModeForwards;
        animationGroup.removedOnCompletion = false;
        animationGroup.duration = delay + duration;
        animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [textLayer addAnimation:animationGroup forKey:nil];
        
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CATextLayer *textLayer = [anim valueForKey:@"textLayer"];
    if (textLayer) {
        [textLayer removeFromSuperlayer];
    }
}

@end
