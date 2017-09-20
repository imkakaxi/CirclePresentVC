//
//  ViewController.m
//  KKXVCPresentStyle
//
//  Created by MBPWL on 2017/9/20.
//  Copyright © 2017年 MBPWL. All rights reserved.
//

#import "ViewController.h"
#import "PresentViewController.h"
#import "KKXCircleSpeadAnimator.h"
#import "PresentViewController1.h"

@interface ViewController ()

@end

@implementation ViewController{
    PresentViewController *presentVC;
    KKXCircleSpeadAnimator *circleSpeadAnimator;
    
    PresentViewController1 *presentVC1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    presentVC = [[PresentViewController alloc]initWithNibName:@"PersentViewController" bundle:nil];
    self.navigationController.navigationBar.translucent = NO;
    
    
    presentVC1 = [[PresentViewController1 alloc]init];

}
- (IBAction)presentStyle1:(id)sender {
    self.navigationController.delegate = nil;
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;            //改变视图控制器出现的方式
    transition.subtype = kCATransitionFromRight;     //出现的位置
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:presentVC1 animated:NO];
    
    /*
     视图控制器出现的方式
     CA_EXTERN NSString * const kCATransitionFade
     CA_EXTERN NSString * const kCATransitionMoveIn
     CA_EXTERN NSString * const kCATransitionPush
     CA_EXTERN NSString * const kCATransitionReveal
     
     出现的位置
     CA_EXTERN NSString * const kCATransitionFromRight
     CA_EXTERN NSString * const kCATransitionFromLeft
     CA_EXTERN NSString * const kCATransitionFromTop
     CA_EXTERN NSString * const kCATransitionFromBottom

     */
}

- (IBAction)presentStyle2:(UIButton *)sender {
    
    circleSpeadAnimator = [KKXCircleSpeadAnimator new];
    circleSpeadAnimator.circleFrame = [self.view convertRect:sender.frame toView:[UIApplication sharedApplication].keyWindow];
    self.navigationController.delegate = circleSpeadAnimator;
    [self.navigationController pushViewController:presentVC animated:YES];
}

- (IBAction)presentStyle3:(id)sender {
}

- (IBAction)presentStyle4:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
