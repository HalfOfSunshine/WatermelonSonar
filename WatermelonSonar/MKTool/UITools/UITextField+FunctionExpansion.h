//
//  UITextField+FunctionExpansion.h
//  Twideo
//
//  Created by 麻明康 on 2023/9/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (FunctionExpansion)
+(UITextField *)textFieldWithFrame:(CGRect)rect
                         textColor:(nullable UIColor *)textColor
                       placeholder:(nullable NSString *)placeholder
                  placeholderColor:(nullable UIColor *)placeholderColor
                   placeholderFont:(nullable UIFont *)font;
@end

NS_ASSUME_NONNULL_END
