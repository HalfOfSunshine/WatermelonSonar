//
//  UILabel+FunctionExpansion.h
//  Twideo
//
//  Created by 麻明康 on 2023/9/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FunctionExpansion)
+ (UILabel *)labelWithFrame:(CGRect)frame
            backgroundColor:(nullable UIColor *)backgroundColor
                       text:(nullable NSString *)text
                       font:(nullable UIFont *)font
                  textColor:(nullable UIColor*)textColor
               textAligment:(NSTextAlignment)textAlignment;


@end

NS_ASSUME_NONNULL_END
