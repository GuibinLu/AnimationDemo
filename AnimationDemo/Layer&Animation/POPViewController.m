//
//  POPViewController.m
//  AnimationDemo
//
//  Created by 路贵斌 on 15/11/13.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "POPViewController.h"
#import "POP.h"
#import "AnimationDemo-swift.h"

@interface POPViewController ()

@property (nonatomic,strong) CALayer    *normalLayer;
@property (nonatomic,strong) CALayer    *popLayer;

@end

@implementation POPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPOPLayer];
    [self performSelector:@selector(addPOPSpringAnimation) withObject:nil afterDelay:1.f];
    [self initFlodImageView];

    
}

- (void)initFlodImageView
{
    FlodImageView *imageView = [[FlodImageView alloc]initWithFrame:CGRectMake((DeviceSize.width - 200)/2.0 , 150, 200, 200)];
    imageView.image = [UIImage imageNamed:@"luffy"];
    [self.view addSubview:imageView];
}

- (void)initPOPLayer
{
    self.popLayer = [CALayer layer];
    self.popLayer.frame = CGRectMake(100, 500, 100, 100);
    self.popLayer.backgroundColor = [ UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.popLayer];
    
}

- (void)addPOPSpringAnimation
{
    POPSpringAnimation * sizeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    sizeAnimation.springSpeed = 0.f;
    sizeAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    [self.popLayer pop_addAnimation:sizeAnimation forKey:nil];

}


- (void)addBasePOPAnimation
{
    POPBasicAnimation *popAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    popAnimation.duration = 5;
    popAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 400)];
    
    popAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.popLayer pop_addAnimation:popAnimation forKey:nil];
}




- (void)initNormalLayer
{
    self.normalLayer = [CALayer layer];
    self.normalLayer.frame = CGRectMake(100, 100, 100, 100);
    self.normalLayer.backgroundColor = [ UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.normalLayer];
}

- (void)animation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 5;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 400)];
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.normalLayer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(removeAnimation) withObject:nil afterDelay:1.5];
    
}

- (void)removeAnimation
{
    NSLog(@"%@\n --- %@ \n ----%@",NSStringFromCGRect(self.normalLayer.frame),NSStringFromCGRect([self.normalLayer.presentationLayer frame]),NSStringFromCGRect([self.normalLayer.modelLayer frame]));
    
}


@end
