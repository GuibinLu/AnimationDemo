//
//  ReplicatorLayerViewController.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/18.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "ReplicatorLayerViewController.h"

@implementation ReplicatorLayerViewController


- (void)viewDidLoad
{
    [self createReplicator];
    //self.view.layer.affineTransform = CGAffineTransformMakeShear(1, 0);//剪切变换
}

CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
    
}



- (void)createReplicator
{
    CAReplicatorLayer   * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.contentsScale = [UIScreen mainScreen].scale;
    replicatorLayer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:replicatorLayer];
    
    replicatorLayer.instanceCount = 10;//including source Layer
    
    replicatorLayer.instanceAlphaOffset = -0.1;
    
    //This transform matrix is applied to instance k-1 to produce instance k. The matrix is applied relative to the center of this layer.
    //即anchorPoint = center  暂时是这么理解的
    
    CATransform3D ct = CATransform3DIdentity;
    ct = CATransform3DRotate(ct, M_PI/5, 0, 0, 1);
    replicatorLayer.instanceTransform = ct;
    
    
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(self.view.center.x - 25, self.view.center.y +55 , 50, 50);
    
    layer.contents = (__bridge id)[UIImage imageNamed:@"qq"].CGImage;
    [replicatorLayer addSublayer:layer];
    
}

@end
