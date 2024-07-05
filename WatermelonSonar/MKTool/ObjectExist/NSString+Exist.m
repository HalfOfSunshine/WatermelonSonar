//
//  NSString+Exist.m
//
//  Created by Mountain King on 2022/5/18.
//

#import "NSString+Exist.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Exist)
/// 返回一个sha256加密后的字符串
- (NSString *)sha256String{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes,(unsigned int)data.length,digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH];
    
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",digest[i]];
    
        
    return [output lowercaseString];
}

/// 返回一个md5加密后的字符串
-(NSString *)md5String{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}


/// 判断字符串是否存在（是否为空，YES为非空）
-(BOOL)exist{
    //self 为nil 时候不会进方法 会返回nil，不用处理；
    if ([self isEqual:[NSNull null]]) {
        return NO;
    }
    NSString *compStr = [NSString stringWithFormat:@"%@", self];
    
    if ( compStr == nil || [compStr isEqualToString:@""] || [compStr isEqualToString:@"(null)"] ||[compStr isEqualToString:@"<null>"]) {
        return NO;
    }
    
    if([compStr length] == 0) {
        return YES;
    } else if([[compStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] == YES) {
        return NO;
    }
    return YES;
}
@end
