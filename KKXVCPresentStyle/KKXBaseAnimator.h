//
//  KKXBaseAnimator.h
//  KKXVCPresentStyle
//
//  Created by MBPWL on 2017/9/20.
//  Copyright © 2017年 MBPWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KKXBaseAnimator : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@property (nonatomic) int type;//0 pop/dismiss  1 push/present

@property (nonatomic) NSTimeInterval  transitionDuration;//动画时间,默认1s

- (void)present;//推出

- (void)dismiss;//消失

@property (nonatomic, weak) UIViewController *fromViewController;//原vc

@property (nonatomic, weak) UIViewController *toViewController;//要推出的VC

@property (nonatomic, weak) UIView *containerView;

@property (nonatomic) id <UIViewControllerContextTransitioning> transitionContext;

- (void)completeTransition;



@end
