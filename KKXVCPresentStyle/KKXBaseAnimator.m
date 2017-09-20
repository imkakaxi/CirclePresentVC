//
//  KKXBaseAnimator.m
//  KKXVCPresentStyle
//
//  Created by MBPWL on 2017/9/20.
//  Copyright © 2017年 MBPWL. All rights reserved.
//

#import "KKXBaseAnimator.h"

@implementation KKXBaseAnimator
#pragma mark - 初始化
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        // 默认参数设置
        [self deafultSet];
    }
    
    return self;
}

- (void)deafultSet {
    
    _transitionDuration = 1.f;
    
    
}

#pragma mark - 动画代理
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    return _transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView      = [transitionContext containerView];
    self.transitionContext  = transitionContext;
    
    [self animateTransitionEvent];
}

- (void)animateTransitionEvent {
    
    self.type ? [self present] : [self dismiss];
}

#pragma mark -
- (void)completeTransition {
    //    !self.transitionContext.transitionWasCancelled
    [self.transitionContext completeTransition:YES];

}

- (void)present
{
    
}

- (void)dismiss
{
    
}

@end
