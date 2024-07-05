//
//  UIColor+MKRGB.m
//  YKXQ
//
//  Created by 麻明康 on 2020/10/22.
//  Copyright © 2020 YiYa. All rights reserved.
//

#import "UIColor+MKRGB.h"

@implementation UIColor (MKRGB)
+ (UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

#pragma mark === Some wonderful color
+ (UIColor *)tiffanyBlue{
    return ColorRGBA(129.,216.,207.,1);
}
+ (UIColor *)avocadoGreen{
    return ColorRGBA(102.,153.,51.,1);
}
+ (UIColor *)JesterRed{
    return ColorHEX(0x9E1030);
}
+ (UIColor *)LipstickRed{
    return ColorHEX(0xB31A38);
}
+ (UIColor *)NFBlue{
    return ColorHEX(0x40c2c2);
}
+ (UIColor *)NFPink{
    return ColorHEX(0xff8070);
}
+ (UIColor *)lakerBlue{
    return ColorHEX(0x1E90FF);
}

@end
