//
//  UITextField+FunctionExpansion.m
//  Twideo
//
//  Created by 麻明康 on 2023/9/1.
//

#import "UITextField+FunctionExpansion.h"

@implementation UITextField (FunctionExpansion)
+(UITextField *)textFieldWithFrame:(CGRect)rect textColor:(nullable UIColor *)textColor placeholder:(nullable NSString *)placeholder placeholderColor:(nullable UIColor *)placeholderColor placeholderFont:(nullable UIFont *)font{
    //账号输入框
    UITextField *TF = [[UITextField alloc] initWithFrame:rect];
    TF.clearButtonMode = UITextFieldViewModeWhileEditing;
    if(textColor) TF.textColor = textColor;
    //更改占位符字体颜色和大小
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置富文本对象的颜色
    if(placeholderColor) attributes[NSForegroundColorAttributeName] = placeholderColor;
    //设置占位符字体大小
    if(font) attributes[NSFontAttributeName] = font;
    if(placeholder){
        if(placeholderColor||font){
            TF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
        }else{
            TF.placeholder = placeholder;
        }
    
    }
    return TF;
}
@end
