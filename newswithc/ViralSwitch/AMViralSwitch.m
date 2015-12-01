//
//  AMViralSwitch.m
//  ViralSwitchDemo
//
//  Created by Andrea Mazzini on 06/10/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "AMViralSwitch.h"

NSString *const AMElementView = @"AMElementView";
NSString *const AMElementKeyPath = @"AMElementKeyPath";
NSString *const AMElementFromValue = @"AMElementFromValue";
NSString *const AMElementToValue = @"AMElementToValue";

#define kDURATION   0.35

@interface AMViralSwitch ()

@property (nonatomic, strong) CAShapeLayer *shape;
@property (nonatomic, assign) CGFloat radius;

@end

@implementation AMViralSwitch

- (void)layoutSubviews
{
    // Yay for math!
    CGFloat x = MAX(CGRectGetMidX(self.frame), self.superview.frame.size.width - CGRectGetMidX(self.frame));
    CGFloat y = MAX(CGRectGetMidY(self.frame), self.superview.frame.size.height - CGRectGetMidY(self.frame));
    self.radius = sqrt(x*x + y*y);
    
    self.shape.frame = (CGRect){CGRectGetMidX(self.frame) - self.radius,
                                 CGRectGetMidY(self.frame) - self.radius, self.radius * 2, self.radius * 2};
    self.shape.anchorPoint = CGPointMake(0.5, 0.5);
    self.shape.path = [UIBezierPath bezierPathWithOvalInRect:(CGRect){0, 0, self.radius * 2, self.radius * 2}].CGPath;
}

- (void)awakeFromNib
{
    self.shape = [CAShapeLayer layer];
    self.shape.fillColor = self.onTintColor.CGColor;
    self.shape.transform = CATransform3DMakeScale(0.0001, 0.0001, 0.0001);
    
    [self.superview.layer insertSublayer:self.shape below:self.layer];
    
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = self.frame.size.height / 2;
    
    [self addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)switchChanged:(UISwitch *)sender
{
    if (sender.on) {
        // Reset
        [self.shape removeAnimationForKey:@"scaleDown"];
        [self.shape removeAnimationForKey:@"borderDown"];
        self.shape.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
        self.layer.borderWidth = 0;
        
        CABasicAnimation *scaleAnimation = [self animateKeyPath:@"transform.scale"
                                                      fromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)]
                                                        toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                                                         timing:kCAMediaTimingFunctionEaseIn];
        [self.shape addAnimation:scaleAnimation forKey:@"scaleUp"];
        
        CABasicAnimation *borderAnimation = [self animateKeyPath:@"borderWidth" fromValue:@0 toValue:@1 timing:kCAMediaTimingFunctionEaseIn];
        [self.layer addAnimation:borderAnimation forKey:@"borderUp"];
        
        for (NSDictionary *element in self.animationElementsOn) {
            CABasicAnimation *elementAnimation = [self animateKeyPath:element[AMElementKeyPath]
                                                            fromValue:element[AMElementFromValue]
                                                              toValue:element[AMElementToValue]
                                                               timing:kCAMediaTimingFunctionEaseIn];
            [element[AMElementView] addAnimation:elementAnimation forKey:element[AMElementKeyPath]];
        }
        
    } else {
        // Reset
        [self.shape removeAnimationForKey:@"scaleUp"];
        [self.shape removeAnimationForKey:@"borderUp"];
        self.layer.borderWidth = 1;
        self.shape.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);

        CABasicAnimation *scaleAnimation = [self animateKeyPath:@"transform.scale"
                                                      fromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                                                        toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)]
                                                         timing:kCAMediaTimingFunctionEaseOut];
        [self.shape addAnimation:scaleAnimation forKey:@"scaleDown"];
        
        CABasicAnimation *borderAnimation = [self animateKeyPath:@"borderWidth" fromValue:@1 toValue:@0 timing:kCAMediaTimingFunctionEaseOut];
        [self.layer addAnimation:borderAnimation forKey:@"borderDown"];
        
        for (NSDictionary *element in self.animationElementsOff) {
            CABasicAnimation *elementAnimation = [self animateKeyPath:element[AMElementKeyPath]
                                                            fromValue:element[AMElementFromValue]
                                                              toValue:element[AMElementToValue]
                                                               timing:kCAMediaTimingFunctionEaseIn];
            [element[AMElementView] addAnimation:elementAnimation forKey:element[AMElementKeyPath]];
        }

    }
}

- (CABasicAnimation *)animateKeyPath:(NSString *)keyPath fromValue:(id)from toValue:(id)to timing:(NSString *)timing
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = from;
    animation.toValue = to;
    animation.repeatCount = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timing];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = kDURATION;
    return animation;
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
