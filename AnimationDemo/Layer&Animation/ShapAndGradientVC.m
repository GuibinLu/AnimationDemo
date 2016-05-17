//
//  ShapAndGradientVC.m
//  AnimationDemo
//
//  Created by 路贵斌 on 15/11/11.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "ShapAndGradientVC.h"

#import "ShapLoadingView.h"
#import "GradientLoadingView.h"

@interface ShapAndGradientVC ()

@end

@implementation ShapAndGradientVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    ShapLoadingView * view = [[ShapLoadingView alloc]initWithFrame:CGRectMake(DeviceSize.width/2-100,80 , 200 , 200)];
    [self.view addSubview:view];
    
    GradientLoadingView * gradientView = [[GradientLoadingView alloc]initWithFrame:CGRectMake(DeviceSize.width/2-100, 400, 200,200)];
    [self.view addSubview:gradientView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
