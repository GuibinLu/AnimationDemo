//
//  CollisionView.m
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "CollisionView.h"

@interface CollisionView() <UICollisionBehaviorDelegate>

@end

@implementation CollisionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 150, 20)];
        redView.backgroundColor = [UIColor redColor];
        [self addSubview:redView];
        
        UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(110, 120, 100, 100)];
        blueView.backgroundColor = [UIColor blueColor];
        [self addSubview:blueView];
        
        // 增加碰撞检测
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[blueView]];
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        // Boundary是即参与碰撞，又不会发生位移的静态物体的边界
        CGFloat toX = redView.frame.size.width;
        CGFloat toY = redView.frame.origin.y + redView.frame.size.height;
        
        [collision addBoundaryWithIdentifier:@"lalala" fromPoint:redView.frame.origin toPoint:CGPointMake(toX, toY)];
        
        // 设置碰撞行为的代理
        collision.collisionDelegate = self;
        
        [self.animator addBehavior:collision];
        
        // 重力
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[blueView]];
        [self.animator addBehavior:gravity];
        
        // 物体属性行为
        UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:@[blueView]];
        
        // 弹力系数，0~1，0是最不弹，1是最弹
        item.elasticity = 0.8;
        
        [self.animator addBehavior:item];
        
        // 此方法可以用于碰撞实际情况的跟踪
//        collision.action = ^ {
//            NSLog(@"%@", NSStringFromCGRect(self.box.frame));
//        };
        
        
        [self gravityAnimation];
        
    }
    
    return self;
}

- (void)gravityAnimation
{
//    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(200, 100, 100, 100)];
    view2.layer.cornerRadius = 50;
    view2.layer.masksToBounds = YES;
    view2.backgroundColor = [UIColor cyanColor];
    [self addSubview:view2];
    

    
    UICollisionBehavior * collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[view2]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
    
    UIGravityBehavior * gravity = [[UIGravityBehavior alloc]initWithItems:@[view2]];
    //[gravity setAngle:M_PI  magnitude:1.0];
    [self.animator addBehavior:gravity];
    
    UIDynamicItemBehavior * itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[view2]];
    itemBehavior.elasticity = 0.8;
        //itemBehavior.friction = 0.2;
    [self.animator addBehavior:itemBehavior];
    
    
}


#pragma mark - 碰撞的代理方法
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSLog(@"%@", identifier);
    NSString *ID = [NSString stringWithFormat:@"%@", identifier];
    UIView *blue = (UIView *)item;
    
    // 根板子相撞，变换颜色
    if ([ID isEqualToString:@"lalala"]) {
        blue.backgroundColor = [UIColor greenColor];
        
        // 结束后恢复颜色
        [UIView animateWithDuration:0.3f animations:^{
            blue.backgroundColor = [UIColor blueColor];
        }];
    }
}

@end
