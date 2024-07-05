//
//  UILabel+FunctionExpansion.m
//  Twideo
//
//  Created by 麻明康 on 2023/9/1.
//

#import "UILabel+FunctionExpansion.h"

@implementation UILabel (FunctionExpansion)
+ (UILabel *)labelWithFrame:(CGRect)frame backgroundColor:(nullable UIColor *)backgroundColor text:(nullable NSString *)text font:(nullable UIFont *)font textColor:(nullable UIColor*)textColor textAligment:(NSTextAlignment)textAlignment
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    if (backgroundColor) label.backgroundColor = backgroundColor;
    if (text) label.text = text;
    if (font) label.font = font;
    if (textColor) label.textColor = textColor;
    label.textAlignment = textAlignment;
    return label;
}

@end
