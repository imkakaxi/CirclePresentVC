//
//  KKXCircleSpeadAnimator.m
//  KKXVCPresentStyle
//
//  Created by MBPWL on 2017/9/20.
//  Copyright © 2017年 MBPWL. All rights reserved.
//

#import "KKXCircleSpeadAnimator.h"

@implementation KKXCircleSpeadAnimator

- (void)present
{
    [self.containerView addSubview:self.toViewController.view];
    self.containerView.backgroundColor = [UIColor whiteColor];
    //画两个圆路径
    
    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:_circleFrame];
    CGFloat x = MAX(CGRectGetMidX(_circleFrame), self.containerView.frame.size.width - CGRectGetMidX(_circleFrame));
    CGFloat y = MAX(CGRectGetMidY(_circleFrame), self.containerView.frame.size.height - CGRectGetMidY(_circleFrame));
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    
    
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:self.containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    //将maskLayer作为self.toViewController.View的遮盖
    
    //    UIView * v = [UIApplication sharedApplication].keyWindow;
    //    UIGraphicsBeginImageContextWithOptions([UIApplication sharedApplication].keyWindow.bounds.size, NO, [UIScreen mainScreen].scale);
    //    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    UIImageView *imgV = [[UIImageView alloc] initWithImage:viewImage];
    //    [self.containerView insertSubview:imgV atIndex:1];
    
    self.toViewController.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = self.transitionDuration;
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:self.transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)dismiss
{
    [self.containerView addSubview:self.toViewController.view];
    [self.containerView sendSubviewToBack:self.toViewController.view];

    //画两个圆路径
    CGFloat radius = sqrtf(self.containerView.frame.size.height * self.containerView.frame.size.height + self.containerView.frame.size.width * self.containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:self.containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //圆圈缩小，kan'qi'lia
    CGRect newFrame = CGRectMake(CGRectGetMidX(_circleFrame) - 1,CGRectGetMidY(_circleFrame) - 1, 2, 2);
    NSLog(@"%@",NSStringFromCGRect(newFrame));
    
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:newFrame];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    self.fromViewController.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = self.transitionDuration;
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:self.transitionContext forKey:@"transitionContext"];
    
    //    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    //    alphaAnimation.fromValue = (@1);
    //    alphaAnimation.toValue = @0;
    //    alphaAnimation.duration = self.transitionDuration;
    //    alphaAnimation.delegate = self;
    //    alphaAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    CAAnimationGroup *group = [CAAnimationGroup animation];
    //    group.delegate = self;
    //    group.duration = self.transitionDuration;
    //    group.animations = @[maskLayerAnimation,alphaAnimation];
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
    
    }

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self completeTransition];
    //    [self.containerView removeFromSuperview];
    //    [self.thisMaskLayer removeFromSuperlayer];
    
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    self.type = UINavigationControllerOperationPush == operation;
    return self;
}


@end
