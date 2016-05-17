//
//  EasingViewController.m
//  AnimationDemo
//
//  Created by 路贵斌 on 15/11/14.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "EasingViewController.h"

#import "YXEasing.h"

#import "CollisionView.h"

@interface EasingViewController ()<UICollisionBehaviorDelegate>

@end

@implementation EasingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dynamicAnimation];
    [self easingAnimation];

}


- (void)dynamicAnimation
{
    CollisionView * collisionView = [[CollisionView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:collisionView];

}

- (void)easingAnimation
{
    UIView * showView = [[UIView alloc]  initWithFrame:CGRectMake(100, 0, 100, 100)];
    showView.layer.cornerRadius = 50;
    showView.layer.masksToBounds = YES;
    showView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:showView];
    
    
    CAKeyframeAnimation * keyPathAnimation = [CAKeyframeAnimation animation];
    keyPathAnimation.duration = 1.0;
    keyPathAnimation.keyPath = @"position";
    
    keyPathAnimation.values = [YXEasing calculateFrameFromPoint:CGPointMake(100, 0) toPoint:CGPointMake(100, self.view.frame.size.height - 50) func:BounceEaseOut frameCount:60];
    keyPathAnimation.removedOnCompletion = NO;
    keyPathAnimation.fillMode = kCAFillModeBoth;
    [showView.layer addAnimation:keyPathAnimation forKey:nil];

}




@end
