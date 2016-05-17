//
//  DrawView.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/26.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "DrawView.h"

#define Width 20

@interface DrawView ()

@property (nonatomic,strong) NSMutableArray     *points;

@end

@implementation DrawView



- (void)clean
{

    [self.points removeAllObjects];
    [self setNeedsDisplay];
}

- (NSMutableArray *)points
{
    if (!_points) {
        _points = [NSMutableArray array];
    }
    return _points;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [touches.anyObject locationInView:self];
    [self.points addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplayInRect:[self rectFromPoint:point]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [touches.anyObject locationInView:self];
    [self.points addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplayInRect:[self rectFromPoint:point]];
}

- (CGRect )rectFromPoint:(CGPoint)point
{
    return CGRectMake(point.x- Width/2.0, point.y- Width/2.0, Width, Width);
}

- (void)drawRect:(CGRect)rect
{
    if (self.points.count ==0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClearRect(context, self.bounds);
        return;
    }
    
    for (NSValue *value in self.points) {
        if (CGRectIntersectsRect(rect, [self rectFromPoint:[value CGPointValue]])) {
            [[UIImage imageNamed:@"TwinkleImage"]drawInRect:rect];
        }
    }
}

@end
