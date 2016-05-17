//
//  EmitterLayerVCViewController.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/23.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "EmitterLayerVCViewController.h"

@interface EmitterLayerVCViewController ()

@end

@implementation EmitterLayerVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor cyanColor];
    [self initEmitterLayer];

}

- (void)initEmitterLayer
{
    CAEmitterLayer * emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = self.view.bounds;
    emitterLayer.emitterPosition = CGPointMake(self.view.center.x, 64);
    emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    emitterLayer.emitterSize = CGSizeMake(self.view.frame.size.width, 20);
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    emitterLayer.preservesDepth = YES;
   // emitterLayer.birthRate = 2.f;
    [self.view.layer addSublayer:emitterLayer];
    CAEmitterCell * cell = [CAEmitterCell emitterCell];
    cell.contents = (__bridge id)[UIImage imageNamed:@"TwinkleImage"].CGImage;
    cell.birthRate = 3.f;
    cell.lifetime = 10.f;
    cell.yAcceleration = 10;
    //cell.velocity =10;
    cell.emissionRange = M_PI;
    emitterLayer.emitterCells = @[cell];
    
}

@end
