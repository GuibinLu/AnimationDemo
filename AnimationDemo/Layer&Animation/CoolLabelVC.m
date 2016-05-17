//
//  CoolLabelVC.m
//  AnimationDemo
//
//  Created by 路贵斌 on 16/5/14.
//  Copyright © 2016年 Author. All rights reserved.
//

#import "CoolLabelVC.h"
#import "AnimationDemo-swift.h"
#import "CLabel.h"

@interface CoolLabelVC ()

@property (nonatomic, strong) NSArray   *dataSource;
@property (nonatomic, strong) CoolLabel *label;
@property (nonatomic, strong) CLabel    *cLabel;

@end

@implementation CoolLabelVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

- (void)initData
{
    self.dataSource = @[
                        @"What is design?",
                        @" 🐒 ❤️ 🍌 ",
                        @"and feels like.",
                        @"Hello,Swift",
                        @"is how it works.",
                        @"路贵斌-Author",
                        @"Older people",
                        @"sit down and ask！",
                        @"'What is it?'",
                        @"but the boy asks,",
                        @"希望大家都能成为大牛！",
                        @"Swift",
                        @"Objective-C"
                        ];
}

- (void)initUI
{
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"xingkong"].CGImage;
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.cLabel];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.label.text = self.dataSource[arc4random()%12];
    self.cLabel.text = self.dataSource[arc4random()%12];
}


/**
 *  swift-Label
 *
 *  @return CoolLabel
 */
- (CoolLabel *)label
{
    if (!_label) {
        _label = [[CoolLabel alloc]initWithFrame:CGRectMake(0, 100, DeviceSize.width, 40)];
        _label.font = [UIFont systemFontOfSize:30];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.text = @" 🐒 ❤️ 🍌 🐭 ❤️ 🌾 ";
    }
    return _label;
    
}

/**
 *  OC-Label
 *
 *  @return CLabel
 */
- (CLabel *)cLabel
{
    if (!_cLabel) {
        _cLabel = [[CLabel alloc]initWithFrame:CGRectMake(0, 300, DeviceSize.width, 40)];
        _cLabel.font = [UIFont systemFontOfSize:30];
        _cLabel.textAlignment = NSTextAlignmentCenter;
        _cLabel.textColor = [UIColor whiteColor];
        _cLabel.text = @" 🐒 ❤️ 🍌 🐭 ❤️ 🌾 ";
    }
    return _cLabel;
}

@end
