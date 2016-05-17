//
//  DrawTextView.h
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/30.
//  Copyright © 2015年 Author. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawTextView : UIView

- (id)initWithFrame:(CGRect)frame String:(NSString *)string font:(UIFont *)font;

- (void)crumbling;

@end
