//
//  DemoView.h
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoView : UIView

// 小方块视图对外的定义，子视图通过此属性可以直接操作方块图像
@property (nonatomic, weak) UIImageView *box;

// 仿真者
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end
