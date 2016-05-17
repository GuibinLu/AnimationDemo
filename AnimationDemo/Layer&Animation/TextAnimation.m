//
//  TextAnimation.m
//  AnimationDemo
//
//  Created by 贵斌 on 15/11/30.
//  Copyright © 2015年 Author. All rights reserved.
//

#import "TextAnimation.h"
#import "DrawTextView.h"

@interface TextAnimation ()

@property (nonatomic,strong) DrawTextView   *textView;

@end

@implementation TextAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI
{
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"xingkong.jpeg"].CGImage;

    self.textView = [[DrawTextView alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)- 100, 100, 200, 200) String:@"A12312312" font:[UIFont fontWithName:@"DBLCDTempBlack" size:60]];
    [self.view addSubview:self.textView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textView  crumbling];

}

@end
