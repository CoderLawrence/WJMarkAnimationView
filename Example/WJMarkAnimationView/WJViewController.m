//
//  WJViewController.m
//  WJMarkAnimationView
//
//  Created by CoderLawrence on 11/19/2018.
//  Copyright (c) 2018 CoderLawrence. All rights reserved.
//

#import "WJViewController.h"
#import <WJMarkAnimationView/WJMarkAnimationView.h>

static const CGFloat kMarkAnimationViewWidth = 134.0f;
static const CGFloat kMarkAniamtionViewHeight = kMarkAnimationViewWidth;

#define UIColorRGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBA(c, a) UIColorRGBA((((int)c) >> 16),((((int)c) >> 8) & 0xff),(((int)c) & 0xff),a)

@interface WJViewController ()

@end

@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WJMarkAnimationView *markView = [[WJMarkAnimationView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - kMarkAnimationViewWidth/2, 100, kMarkAnimationViewWidth, kMarkAniamtionViewHeight)];
    [self.view addSubview:markView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [markView startAnimation];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [markView setStartColor:RGBA(0xa18cd1, 1)];
        [markView setEndColor:RGBA(0xfbc2eb, 1)];
        [markView setDirection:kMarkAnimationViewGradientDirectionTopToBottom];
        [markView startAnimation];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
