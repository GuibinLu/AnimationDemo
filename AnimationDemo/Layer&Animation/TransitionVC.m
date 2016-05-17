//
//  TransitionVC.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/23.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "TransitionVC.h"

@interface TransitionVC ()

@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) NSArray       *imageNames;

@end

@implementation TransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI
{
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    self.imageView.frame = self.view.bounds;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int a = 0;

//    [UIView transitionWithView:self.imageView duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//        
    //    self.imageView.image = [UIImage imageNamed:self.imageNames[a++%3]];

//    } completion:nil];

    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.f;
    transition.type = @"rippleEffect";
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    self.imageView.image = [UIImage imageNamed:self.imageNames[a++%3]];


//    [CATransaction begin];//开启一个新的事物项 必须每次都要开启这么一个新的动画行为 否则会影响到转场动画
//    [CATransaction setDisableActions:YES];//关闭隐式动画
//    [CAAnimation code];
//    [CATransaction commit]; //一般事物项的处理  runloop
    
}

- (NSArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = @[@"qq",
                        @"luffy.jpg",
                        @"cat.jpg"
                        ];
    }
    return _imageNames;
}

@end
