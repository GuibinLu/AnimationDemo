//
//  MaskViewController.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/3.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "MaskViewController.h"

@interface MaskViewController ()

@property (nonatomic, strong) CALayer   *imageLayer;
@property (nonatomic, strong) CALayer   *maskLayer;

@property (nonatomic, strong) UIImage   *imageContents;
@property (nonatomic, strong) UIImage   *maskContents;

@end

@implementation MaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initImageLayer];
    [self animationMaskLayer];
}

- (void)initImageLayer
{
    self.imageContents = [UIImage imageNamed:@"cat.jpg"];
    self.maskContents = [UIImage imageNamed:@"mask"];
    
    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = CGRectMake(0, 0, 400, 450);
    self.imageLayer.contents = (__bridge id)self.imageContents.CGImage;
    [self.view.layer addSublayer:self.imageLayer];
    
    //创建出遮罩layer
    self.maskLayer = [CALayer layer];
    self.maskLayer.frame = CGRectMake(0, 0, 300, 300);
    self.maskLayer.contents = (__bridge id)self.maskContents.CGImage;
    
    //self.maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    //An optional layer whose alpha channel is used to mask the layer’s content.
    // 给图片layer 提供这招的layer
    /*
     alpha channel
     像素透明通道 一般为 32 位  前面的 24 位 分别为 红 蓝 绿 各8位 后8位 为阿尔法通道值
     
     要想更清楚的 理解，可以去问下 百度百科  或者 问下 设计 他们抠图 用的就是 蒙版 对阿尔法通道进行了更改
     **/
    
    self.imageLayer.mask = self.maskLayer;
    
}

- (void)animationMaskLayer
{
    NSTimer * timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(moveMaskView) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)moveMaskView
{
    self.maskLayer.frame = CGRectMake(rand()%200, rand()%200, 300,300 );
}

















@end
