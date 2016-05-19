//
//  UIView+IBDesignable.h
//  TaiZhouRoad
//
//  Created by 路贵斌 on 16/2/20.
//  Copyright © 2016年 huazi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IBDesignable)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;

@end
