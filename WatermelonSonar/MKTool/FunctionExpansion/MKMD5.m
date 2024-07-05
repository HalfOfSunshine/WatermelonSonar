//
//  MKMD5.m
//  Twideo
//
//  Created by 麻明康 on 2023/9/6.
//

#import "MKMD5.h"

#import <CommonCrypto/CommonDigest.h>
@implementation MKMD5
//+ (NSString *)md5EncryptWithString:(NSString *)string{
//    return [self md5:[NSString stringWithFormat:@"%@%@", encryptionKey, string]];
//}
NSString * md5 (NSString *string,...){
    NSString *finalString;
    va_list stringList;//创建一个参数指针
    va_start(stringList, string);//第一个参数为参数指针，第二参数是参数中的第一个
    
    id string2;//va_arg 第一个参数是指针，第二个参数为数据类型，所有的参数建议是id类型
    if (string) {
        finalString = string;
        while ((string2 = va_arg(stringList, id))) {
            finalString = [finalString stringByAppendingString:string2];
            NSLog(@"otherString:%@",string2);
        }
    }
    va_end(stringList);
    return [MKMD5 md5:finalString];
}

+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}
@end

