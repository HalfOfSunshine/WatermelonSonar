//
//  NSNull+Exist.m
//
//  Created by 麻明康 on 2023/1/8.
//

#import "NSNull+Exist.h"

@implementation NSNull (Exist)
-(BOOL)exist{
    return NO;
}
///// 判断是否存在（是否为空，YES为非空）
//-(BOOL)exist{
//    //self 为nil 时候不会进方法 会返回nil，不用处理；
//    if ([self isEqual:[NSNull null]]) {
//        return NO;
//    }
//    NSString *compStr = [NSString stringWithFormat:@"%@", self];
//
//    if ( compStr == nil || [compStr isEqualToString:@""] || [compStr isEqualToString:@"(null)"] ||[compStr isEqualToString:@"<null>"]) {
//        return NO;
//    }
//
//    if([compStr length] == 0) {
//        return YES;
//    } else if([[compStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] == YES) {
//        return NO;
//    }
//    return YES;
//}
@end
