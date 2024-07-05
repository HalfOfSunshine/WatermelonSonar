//
//  XTTimeTool.h
//  Twideo
//
//  Created by 麻明康 on 2023/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTTimeTool : NSObject
//获取时间戳（秒）
+ (NSString *)getTimestampSince1970;
/** 获取当前日期 */
+ (NSString *)getCurrentDate;
+ (NSString *)getCurrentTime;

/// 当前时间增加minuteOffset分钟
/// @param minuteOffset  增加的分钟数，为负数则为减少
+(NSString *)getCurrentTimeMinuteOffset:(NSInteger)minuteOffset;

/// 判断当前时间是否大于禁止请求的时间
/// @return 默认返回NSOrderedAscending（tA小于B）；NSOrderedSame（A等于B）；NSOrderedDescending（A大于B）；
/// @param timeA 时间A
/// @param timeB 时间B
+(NSComparisonResult)compareTimeA:(NSString*)timeA withTimeB:(NSString*)timeB;
@end

NS_ASSUME_NONNULL_END
