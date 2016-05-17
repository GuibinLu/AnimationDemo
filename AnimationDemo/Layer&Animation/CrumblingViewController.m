//
//  CrumblingViewController.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/27.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "CrumblingViewController.h"

#define width 8

@interface CrumblingViewController ()

@property (nonatomic,strong) UIView *containerView;

@end

@implementation CrumblingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self performSelector:@selector(animation) withObject:nil afterDelay:3.0];
}

- (void)initUI
{
    
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"xingkong.jpeg"].CGImage;
    self.containerView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    [self crumbling];
}

- (void)crumbling
{
    UIView * view = [self.view snapshotViewAfterScreenUpdates:YES];
    
    for (int i = 0; i < CGRectGetMaxY(self.view.frame)/width;i++) {
        for (int j = 0; j < CGRectGetMaxX(self.view.frame)/width;j++){
            CGRect snapshotRegion = CGRectMake(j*width, i*width, width, width);
           UIView * snapshot=  [view resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            snapshot.frame = snapshotRegion;
            [self.containerView addSubview:snapshot];
        }
    }
    [self.view addSubview:self.containerView];

    
}

- (void)animation
{
    [UIView animateWithDuration:4.0 animations:^{
        for (UIView * subView in self.containerView.subviews) {
            
            subView.center = CGPointMake(arc4random()%1125-375, CGRectGetMaxY(self.view.frame)+20);
        }
    }];
    
}

@end
