//
//  WJMarkAnimationView.m
//  WJMarkAnimationView
//  渐变颜色的打勾动画
//  Created by Lawrence on 2018/4/22.
//  Copyright © 2018年 Lawrence. All rights reserved.
//

#import "WJMarkAnimationView.h"

#define UIColorRGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBA(c, a) UIColorRGBA((((int)c) >> 16),((((int)c) >> 8) & 0xff),(((int)c) & 0xff),a)

static const CGFloat kDuration = 0.3f;
static const CGFloat kLineWidth = 6.0f;
static const CGFloat kStrokeStart = 0.0f;

static const CGFloat kStartAngle = -90.0f;
static const CGFloat kEndAngle = 270.0f;

@interface WJMarkAnimationView()

@property (nonatomic, strong) CAShapeLayer *markLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAGradientLayer *circleGradientLayer;
@property (nonatomic, strong) CAGradientLayer *markGradientLayer;

@end

@implementation WJMarkAnimationView

#pragma mark Initial
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    
    return self;
}

- (void)dealloc
{
    [self stopAnimation];
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self _layoutViews];
}

#pragma mark - setter
- (void)setDirection:(WJMarkAnimationViewGradientDirection)direction
{
    _direction = direction;
    CGPoint startPoint = CGPointMake(0.0f, 0.5f);
    CGPoint endPoint = CGPointMake(1.0f, 0.5f);
    if (direction == kMarkAnimationViewGradientDirectionTopToBottom) {
        startPoint = CGPointMake(0.5f, 0.0f);
        endPoint = CGPointMake(0.5f, 1.0f);
    }
    
    self.circleGradientLayer.startPoint = startPoint;
    self.circleGradientLayer.endPoint = endPoint;
    self.markGradientLayer.startPoint = startPoint;
    self.markGradientLayer.endPoint = endPoint;
}

- (void)setStartColor:(UIColor *)startColor
{
    _startColor = startColor;
    [self _updateMarkGradientLayer];
    [self _updateCircleGradientLayer];
}

- (void)setEndColor:(UIColor *)endColor
{
    _endColor = endColor;
    [self _updateMarkGradientLayer];
    [self _updateCircleGradientLayer];
}

#pragma mark - lazy loading
- (CAShapeLayer *)circleLayer
{
    if (_circleLayer == nil) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        [layer setFrame:self.bounds];
        layer.strokeColor = [UIColor whiteColor].CGColor;
        layer.fillColor =  [UIColor clearColor].CGColor;
        layer.lineCap = kCALineCapRound;
        layer.strokeStart = kStrokeStart;
        layer.strokeEnd = kStrokeStart;
        layer.lineWidth = _lineWidth;
        [self.layer addSublayer:layer];
        _circleLayer = layer;
    }
    
    return _circleLayer;
}

- (CAShapeLayer *)markLayer
{
    if (_markLayer == nil) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        [layer setFrame:self.bounds];
        layer.strokeColor = [UIColor whiteColor].CGColor;
        layer.fillColor =  [UIColor clearColor].CGColor;
        layer.strokeStart = kStrokeStart;
        layer.strokeEnd = kStrokeStart;
        layer.lineWidth = _lineWidth;
        layer.lineCap = kCALineCapRound;
        [self.layer addSublayer:layer];
        _markLayer = layer;
    }
    
    return _markLayer;
}

- (CAGradientLayer *)circleGradientLayer
{
    if (_circleGradientLayer == nil) {
        CAGradientLayer *layer = [CAGradientLayer layer];
        [layer setBounds:self.bounds];
        layer.colors = @[(id)self.startColor.CGColor,
                         (id)self.endColor.CGColor];
        layer.locations = @[@0.2f, @1.0f];
        layer.startPoint = CGPointMake(0.0f, 0.5f);
        layer.endPoint = CGPointMake(1.0f, 0.5f);
        [self.layer addSublayer:layer];
        _circleGradientLayer = layer;
    }
    
    return _circleGradientLayer;
}

- (CAGradientLayer *)markGradientLayer
{
    if (_markGradientLayer == nil) {
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.colors = @[(id)self.startColor.CGColor,
                         (id)self.endColor.CGColor];
        layer.locations = @[@0.2f, @1.0f];
        layer.startPoint = CGPointMake(0.0f, 0.5f);
        layer.endPoint = CGPointMake(1.0f, 0.5f);
        [self.layer addSublayer:layer];
        _markGradientLayer = layer;
    }
    
    return _markGradientLayer;
}

#pragma mark - public method
- (void)startAnimation
{
    [self stopAnimation];
    
    CABasicAnimation *circleAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    circleAni.fromValue = @0.0f;
    circleAni.toValue = @1.0f;
    circleAni.removedOnCompletion = NO;
    circleAni.fillMode = kCAFillModeForwards;
    circleAni.duration = self.duration;
    [self.circleLayer addAnimation:circleAni forKey:@"WJCircleAnimationkey"];
    
    CABasicAnimation *markAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    markAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    markAni.fromValue = @0.0f;
    markAni.toValue = @1.0f;
    markAni.removedOnCompletion = NO;
    markAni.fillMode = kCAFillModeForwards;
    markAni.duration = self.duration;
    [markAni setBeginTime:CACurrentMediaTime() + self.duration];
    [self.markLayer addAnimation:markAni forKey:@"WJMarkAnimationkey"];
}

- (void)stopAnimation
{
    [self.markLayer removeAnimationForKey:@"WJMarkAnimationkey"];
    [self.circleLayer removeAnimationForKey:@"WJCircleAnimationkey"];
}

#pragma mark - private method
- (void)_commonInit
{
    _clockwise = YES;
    _startAngle = kStartAngle;
    _endAngle = kEndAngle;
    _lineWidth = kLineWidth;
    _duration = kDuration;
    _startColor = RGBA(0x8590fb, 1.0f);
    _endColor = RGBA(0x4cc2d7, 1.0f);
    _direction = kMarkAnimationViewGradientDirectionLeftToRight;
    
    [self circleLayer];
    [self markLayer];
    [self circleGradientLayer];
    [self markGradientLayer];
}

- (void)_layoutViews
{
    [self.markLayer setFrame:self.bounds];
    [self.circleLayer setFrame:self.bounds];
    [self.circleGradientLayer setFrame:self.bounds];
    [self.markGradientLayer setFrame:self.bounds];
    [self _updateCircleLayer];
    [self _updateMarkLayer];
}

- (void)_updateCircleLayer
{
    [self.circleGradientLayer setMask:self.circleLayer];
    self.circleLayer.lineWidth = self.lineWidth;
    self.circleLayer.path = [self _circlePath].CGPath;
}

- (void)_updateMarkLayer
{
    [self.markGradientLayer setMask:self.markLayer];
    self.markLayer.lineWidth = self.lineWidth;
    self.markLayer.path = [self _markPath].CGPath;
}

- (void)_updateCircleGradientLayer
{
    self.circleGradientLayer.colors = @[(id)self.startColor.CGColor,
                                        (id)self.endColor.CGColor];
}

- (void)_updateMarkGradientLayer
{
    self.markGradientLayer.colors = @[(id)self.startColor.CGColor,
                                      (id)self.endColor.CGColor];
}

- (UIBezierPath *)_circlePath
{
    CGPoint arcCenter = CGPointMake(CGRectGetMidY(self.bounds), CGRectGetMidX(self.bounds));
    CGFloat radius = (CGRectGetWidth(self.bounds) - _lineWidth)/2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:_startAngle * (CGFloat) M_PI / 180.f endAngle:_endAngle * (CGFloat) M_PI / 180.f clockwise:_clockwise];
    
    return path;
}

- (UIBezierPath *)_markPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(CGRectGetMinX(self.bounds) + 0.26442 * CGRectGetWidth(self.bounds), CGRectGetMinY(self.bounds) + 0.55288 * CGRectGetHeight(self.bounds))];
    [path addLineToPoint: CGPointMake(CGRectGetMinX(self.bounds) + 0.31250 * CGRectGetWidth(self.bounds), CGRectGetMinY(self.bounds) + 0.60096 * CGRectGetHeight(self.bounds))];
    [path addQuadCurveToPoint:CGPointMake(CGRectGetMinX(self.bounds) + 0.49038 * CGRectGetWidth(self.bounds), CGRectGetMinY(self.bounds) + 0.60096 * CGRectGetHeight(self.bounds)) controlPoint:CGPointMake(CGRectGetMinX(self.bounds) + 0.40864 * CGRectGetWidth(self.bounds), CGRectGetMinY(self.bounds) + 0.68269 * CGRectGetHeight(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetMinX(self.bounds) + 0.73557 * CGRectGetWidth(self.bounds), CGRectGetMinY(self.bounds) + 0.36057 * CGRectGetHeight(self.bounds))];
    
    return path;
}

@end
