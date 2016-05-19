//
//  UIView+IBDesignable.m
//  TaiZhouRoad
//
//  Created by 路贵斌 on 16/2/20.
//  Copyright © 2016年 huazi. All rights reserved.
//

#import "UIView+IBDesignable.h"

@implementation UIView (IBDesignable)

/**
 *  对IB画板的扩展
 */

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}


@end
