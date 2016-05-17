//
//  Transform3DViewController.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/3.
//  Copyright © 2015年 Author. All rights reserved.
//

/**
 *  尝试研究一下 3D动画 特别是旋转那一块 并尝试用keyPath 实现同样的3D效果 ，并研究下图层
 *
 *
 *
 *
 */

#import "Transform3DViewController.h"

#define WINSIZE [UIScreen mainScreen].bounds.size
#define PerspectiveNum 400

@interface Transform3DViewController ()

@property (nonatomic ,weak) IBOutlet UIImageView    *qqImageView;
@property (nonatomic ,weak) IBOutlet UIImageView    *luffyImageView;
@property (nonatomic ,weak) IBOutlet UIView         *bgView;

@property (nonnull, strong) CALayer                 *rootLayer;


- (IBAction)animationAction:(UIButton *)button;


@end

@implementation Transform3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"xingkong.jpeg"].CGImage;
    [self create3DCubeWithCoordinate:0 isPerspective:YES];
    [self addCubeWithTransform];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self roateTheCube];
    
}

#pragma mark - CATransformLayer 3D变换时 子图层 层级化 可以方便的做对应某个图层的3D变换  TransformLayer本身不存在，当子图层发生渲染变换的时候 才会存在  它能够组织独立元素


- (void)addCubeWithTransform
{
    /**
     *CATransformLayer 专门用来做3D变换用的  是有层级结构的 Layer
     */
    
    CATransformLayer *tl1 = [CATransformLayer layer];
    tl1.contentsScale = [UIScreen mainScreen].scale;
    tl1.bounds = self.view.layer.bounds;
    tl1.position = CGPointMake(WINSIZE.width/2.f, 100);
    [self.rootLayer addSublayer:tl1];
    
    //前
    [tl1 addSublayer:[self addSublayersWithParams:@[@0, @(0), @50, @0, @0, @0, @0]]];
    //后
    [tl1 addSublayer:[self addSublayersWithParams:@[@0, @(0) , @(-50), @(M_PI), @0, @0, @0]]];
    //左
    [tl1 addSublayer:[self addSublayersWithParams:@[@(-50), @(0), @0, @(-M_PI_2), @0, @1, @0]]];
    //右
    [tl1 addSublayer:[self addSublayersWithParams:@[@50, @(0), @0, @(M_PI_2), @0, @1, @0]]];
    //上
    [tl1 addSublayer:[self addSublayersWithParams:@[@0, @(-50), @0, @(-M_PI_2), @1, @0, @0]]];
    //下
    [tl1 addSublayer:[self addSublayersWithParams:@[@0, @(50), @0, @(M_PI_2), @1, @0, @0]]];
    
    CATransform3D ct1 = CATransform3DIdentity;
    
    CATransformLayer *tl2 = [CATransformLayer layer];
    tl2.contentsScale = [UIScreen mainScreen].scale;
    tl2.bounds = self.rootLayer.bounds;
    tl2.position = CGPointMake(WINSIZE.width/2.f - 200, self.rootLayer.position.y);
    [self.rootLayer addSublayer:tl2];
    
    //前
    [tl2 addSublayer:[self addSublayersWithParams:@[@0, @(0), @50, @0, @0, @0, @0]]];
    //后
    [tl2 addSublayer:[self addSublayersWithParams:@[@0, @(0) , @(-50), @(M_PI), @0, @0, @0]]];
    //左
    [tl2 addSublayer:[self addSublayersWithParams:@[@(-50), @(0), @0, @(-M_PI_2), @0, @1, @0]]];
    //右
    [tl2 addSublayer:[self addSublayersWithParams:@[@50, @(0), @0, @(M_PI_2), @0, @1, @0]]];
    //上
    [tl2 addSublayer:[self addSublayersWithParams:@[@0, @(-50), @0, @(-M_PI_2), @1, @0, @0]]];
    //下
    [tl2 addSublayer:[self addSublayersWithParams:@[@0, @(50), @0, @(M_PI_2), @1, @0, @0]]];
    
    CATransform3D ct2 = CATransform3DIdentity;
    ct2 = CATransform3DTranslate(ct2, 50, 0, 0);
    ct2 = CATransform3DRotate(ct1, M_PI_4, 0, 1, 0);
    tl2.transform = ct2;
    
}




#pragma mark - CALayer 的3D旋转   将所有子图层平面化到一个场景中 没有层级
- (void)roateTheCube
{
    //第一种 正交投影的
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.rotation.y"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.duration = 3.0;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [_rootLayer addAnimation:animation forKey:@"rotation"];
}

- (void)create3DCubeWithCoordinate:(CGFloat )y isPerspective:(BOOL)perspective
{
    self.rootLayer = [CALayer layer];
    self.rootLayer.contentsScale = [UIScreen mainScreen].scale;
    self.rootLayer.frame = self.view.bounds;
    self.rootLayer.position =self.view.layer.position;
    [self.view.layer addSublayer:self.rootLayer];

    //前
    [self.rootLayer addSublayer:[self addSublayersWithParams:@[@0, @(0+y), @50, @0, @0, @0, @0]]];
    //后
    [self.rootLayer addSublayer:[self addSublayersWithParams:@[@0, @(0+y) , @(-50), @(M_PI), @0, @0, @0]]];
    //左
    [self.rootLayer addSublayer:[self addSublayersWithParams:@[@(-50), @(0+y), @0, @(-M_PI_2), @0, @1, @0]]];
    //右
    [self.rootLayer addSublayer:[self addSublayersWithParams:@[@50, @(0+y), @0, @(M_PI_2), @0, @1, @0]]];
    //上
    [self.rootLayer addSublayer:[self addSublayersWithParams:@[@0, @(-50 + y), @0, @(-M_PI_2), @1, @0, @0]]];
    //下
    [self.rootLayer addSublayer:[self addSublayersWithParams:@[@0, @(50+y), @0, @(M_PI_2), @1, @0, @0]]];
    
    CATransform3D tranform = CATransform3DIdentity;
    
    tranform.m34 = perspective ? -1.0/PerspectiveNum : 0;// 0 的话就相当于观察点在负无穷 跟正交一样
    
    self.rootLayer.sublayerTransform = CATransform3DRotate(tranform, -M_PI/3, 1, 0, 0);
    self.rootLayer.sublayerTransform = tranform;
}

//就是用6个面组装成一个立方体

- (CAGradientLayer *)addSublayersWithParams:(NSArray *)params
{
    CAGradientLayer * layer = [CAGradientLayer layer];
    layer.contentsScale = [UIScreen mainScreen].scale;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(WINSIZE.width/2., WINSIZE.height/2);
    layer.colors = @[(id)[UIColor cyanColor].CGColor,(id)[UIColor yellowColor].CGColor];
    layer.locations = @[@0,@1];
    layer.startPoint = CGPointMake(0,0);
    layer.endPoint = CGPointMake(0, 1);
    
    //设置6个面
    
    CATransform3D transform = CATransform3DMakeTranslation([params[0] floatValue], [params[1] floatValue], [params[2] floatValue]);
    transform = CATransform3DRotate(transform, [params[3] floatValue], [params[4] floatValue], [params[5] floatValue], [params[6] floatValue]);
   
    layer.transform = transform;
    
    return layer;
    
}


// 类似淘宝商品详情页的截屏3D旋转
- (void)rotate3D
{
    UIView * view = [self createMaskView];
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 = -1.0/600;//透视投影  改变z轴的透视点 -1/z dangz 无限大  即m34 = 0 时就没有效果了
    
    UIView * imageView = [view viewWithTag:111];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        imageView.layer.transform =  CATransform3DRotate(transform,M_PI * 0.3 , 1, 0, 0);
        
    }completion:^(BOOL finished) {
        
    }];

}

- (UIView *)createMaskView
{
    UIView * bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.tag = 101;
    
    [bgView addSubview:[self captureScreenContext]];
    
    [self.navigationController.view addSubview:bgView];
    
    //AddGs
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [bgView addGestureRecognizer:tap];
    return bgView;
}


- (UIView *)captureScreenContext
{
    UIGraphicsBeginImageContextWithOptions([UIApplication sharedApplication].keyWindow.frame.size, NO, 0.0f);
    
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = image;
    imageView.tag = 111;
    
    return imageView;
}


#pragma mark - Action

- (void)tapAction:(id)sender
{
    UIView * bgView = [self.navigationController.view viewWithTag:101];
    [UIView animateWithDuration:0.4 animations:^{
        
        [bgView viewWithTag:111].layer.transform = CATransform3DIdentity;
        
    }completion:^(BOOL finished) {
        [bgView removeFromSuperview];
    }];
}


- (IBAction)animationAction:(UIButton *)button
{

    [self rotate3D];
}
@end
