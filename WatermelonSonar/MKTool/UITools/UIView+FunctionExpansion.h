//
//  UIView+FunctionExpansion.h
//  Twideo
//
//  Created by 麻明康 on 2023/9/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FunctionExpansion)
//  Origin.
@property (assign, nonatomic) CGPoint frameOrigin;

@property (assign, nonatomic) CGFloat frameBottom;
@property (assign, nonatomic) CGFloat frameLeft;
@property (assign, nonatomic) CGFloat frameRight;
@property (assign, nonatomic) CGFloat frameTop;

//  Size.
@property (assign, nonatomic) CGSize frameSize;

@property (assign, nonatomic) CGFloat frameHeight;
@property (assign, nonatomic) CGFloat frameWidth;

- (void)setTapGestureRecognizerWithTarget:(id)target action:(SEL)selector;

- (void)removeAllSubviews;

-(void)setHalfRadius;

-(void)setDefaultShadow;
@end

NS_ASSUME_NONNULL_END
