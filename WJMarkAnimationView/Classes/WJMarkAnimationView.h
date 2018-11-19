//
//  WJMarkAnimationView.h
//  WJMarkAnimationView
//  渐变颜色的打勾动画
//  Created by Lawrence on 2018/4/22.
//  Copyright © 2018年 Lawrence. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 渐变颜色方向

 - kMarkAnimationViewGradientDirectionTopToBottom: 上到下
 - kMarkAnimationViewGradientDirectionLeftToRight: 左到右
 */
typedef NS_ENUM(NSInteger, WJMarkAnimationViewGradientDirection) {
    kMarkAnimationViewGradientDirectionTopToBottom = 0,
    kMarkAnimationViewGradientDirectionLeftToRight = 1,
};

@interface WJMarkAnimationView : UIView

/**
 是否设置为逆时针动画（默认为YES）
 */
@property (nonatomic, assign) BOOL clockwise;

/**
 开始角度
 */
@property (nonatomic, assign) CGFloat startAngle;

/**
 结束角度
 */
@property (nonatomic, assign) CGFloat endAngle;

/**
 动画时长
 */
@property (nonatomic, assign) CGFloat duration;

/**
 线条宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 渐变的开始颜色
 */
@property (nonatomic, strong) UIColor *startColor;

/**
 渐变的结束颜色
 */
@property (nonatomic, strong) UIColor *endColor;

/**
 渐变颜色方向
 */
@property (nonatomic, assign) WJMarkAnimationViewGradientDirection direction;

/**
 开始动画
 */
- (void)startAnimation;

/**
 结束动画
 */
- (void)stopAnimation;

@end
