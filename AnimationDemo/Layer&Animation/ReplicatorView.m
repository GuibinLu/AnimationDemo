//
//  ReplicatorView.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/18.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "ReplicatorView.h"

@implementation ReplicatorView


 +(Class)layerClass
{
    return [CAReplicatorLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}


- (void)awakeFromNib
{
    [self initUI];
    //[self setUp];
}

- (void)initUI
{
    CAReplicatorLayer * layer = (CAReplicatorLayer *)self.layer;
    layer.instanceCount = 2;
    
    CATransform3D ct = CATransform3DIdentity;
    ct = CATransform3DTranslate(ct, 0, self.frame.size.height + 2, 0);
    ct = CATransform3DScale(ct, 1, -1, 0);
//    ct.m34 = -1.0/500;
//    ct = CATransform3DRotate(ct, -M_PI/10.0, 1, 0, 0);
    layer.instanceTransform = ct;
    layer.instanceAlphaOffset = -0.6;

    
}




@end
