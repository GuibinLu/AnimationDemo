//
//  PresentLayerVC.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/23.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "PresentLayerVC.h"

@interface PresentLayerVC ()

@property (nonatomic,strong) UILabel *cycleView;

@end

@implementation PresentLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.cycleView = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame), 100, 100)];
    self.cycleView.layer.masksToBounds = YES;
    self.cycleView.layer.cornerRadius = 50;
    self.cycleView.font = [UIFont boldSystemFontOfSize:50];
    self.cycleView.textAlignment = NSTextAlignmentCenter;
    self.cycleView.text = @"0";
    self.cycleView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.cycleView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInView:self.view];
    static int num = 0;
    
    if ([self.cycleView.layer.presentationLayer hitTest:location]) {
        self.cycleView.text = @(num++).stringValue;
    }else{

        [UIView animateWithDuration:3.f animations:^{
            self.cycleView.center = location;
        }];
    }
    
}

@end
