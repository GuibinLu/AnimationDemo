//
//  DrawRectVC.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/26.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "DrawRectVC.h"

#import "DrawView.h"
#import "WaterView.h"

@interface DrawRectVC ()

@property (nonatomic,weak)   IBOutlet DrawView   *drawView;
@property (nonatomic,strong) WaterView           *waterView;

-(IBAction)cleanTheDrawView:(UIButton *)button;

@end

@implementation DrawRectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"xingkong.jpeg"].CGImage;
    self.waterView = [[WaterView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.waterView.percentum = 0.5;
    self.waterView.alpha = 0.5;
    [self.view addSubview:self.waterView];
    
}


#pragma mark - ButtonAction

-(IBAction)cleanTheDrawView:(UIButton *)button
{
    [self.drawView clean];
}


@end
