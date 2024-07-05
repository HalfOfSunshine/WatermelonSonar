//
//  UIView+FunctionExpansion.m
//  Twideo
//
//  Created by 麻明康 on 2023/9/1.
//

#import "UIView+FunctionExpansion.h"

@implementation UIView (FunctionExpansion)
#pragma mark - Accessor methods

- (CGPoint)frameOrigin
{
    return self.frame.origin;
}


- (void)setFrameOrigin:(CGPoint)frameOrigin
{
    CGRect frame = self.frame;
    frame.origin = frameOrigin;
    self.frame = frame;
}


- (CGFloat)frameBottom
{
    return self.frameTop + self.frameHeight;
}


- (void)setFrameBottom:(CGFloat)frameBottom
{
    self.frameTop = frameBottom - self.frameHeight;
}


- (CGFloat)frameLeft
{
    return self.frameOrigin.x;
}


- (void)setFrameLeft:(CGFloat)frameLeft
{
    self.frameOrigin = CGPointMake(frameLeft, self.frameTop);
}


- (CGFloat)frameRight
{
    return self.frameLeft + self.frameWidth;
}


- (void)setFrameRight:(CGFloat)frameRight
{
    self.frameLeft = frameRight - self.frameWidth;
}


- (CGFloat)frameTop
{
    return self.frameOrigin.y;
}


- (void)setFrameTop:(CGFloat)frameTop
{
    self.frameOrigin = CGPointMake(self.frameLeft, frameTop);
}


- (CGSize)frameSize
{
    return self.frame.size;
}


- (void)setFrameSize:(CGSize)frameSize
{
    CGRect frame = self.frame;
    frame.size = frameSize;
    self.frame = frame;
}


- (CGFloat)frameHeight
{
    return self.frameSize.height;
}


- (void)setFrameHeight:(CGFloat)frameHeight
{
    self.frameSize = CGSizeMake(self.frameWidth, frameHeight);
}


- (CGFloat)frameWidth
{
    return self.frameSize.width;
}

- (void)setFrameWidth:(CGFloat)frameWidth
{
    self.frameSize = CGSizeMake(frameWidth, self.frameHeight);
}


- (void)setTapGestureRecognizerWithTarget:(id)target action:(SEL)selector
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)removeAllSubviews
{
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
}

-(void)setHalfRadius{
    self.layer.cornerRadius = self.frame.size.height/2;
}

-(void)setDefaultShadow{
    self.layer.shadowColor = [UIColor colorWithRed:4/255.0 green:32/255.0 blue:40/255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius = 4;
}
@end
