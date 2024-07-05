//
//  XTTimeTool.m
//  Twideo
//
//  Created by 麻明康 on 2023/8/22.
//

#import "XTTimeTool.h"
#import "NSString+Exist.h"
@implementation XTTimeTool

//获取时间戳（秒）
+ (NSString *)getTimestampSince1970{
    NSDate *datenow = [NSDate date];//现在时间
    NSTimeInterval interval = [datenow timeIntervalSince1970];//*1000;
    NSString *timeSp = [NSString stringWithFormat:@"%.0f",interval];
    return timeSp;
}

/** 获取当前日期 */
+ (NSString *)getCurrentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"]; //
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    return [formatter stringFromDate:datenow];
}



+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间
    NSString *currentDate = [formatter stringFromDate:datenow];
    return currentDate;
}

/// 当前时间增加minuteOffset分钟
/// @param minuteOffset  增加的分钟数，为负数则为减少
+(NSString *)getCurrentTimeMinuteOffset:(NSInteger)minuteOffset
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    components = [calendar components:unitFlags fromDate:datenow];
    [components setMinute:([components minute]+minuteOffset)];
    NSDate *resultDate = [calendar dateFromComponents:components];
    return [formatter stringFromDate:resultDate];
}

/// 判断当前时间是否大于禁止请求的时间
/// @return 默认返回NSOrderedAscending（tA小于B）；NSOrderedSame（A等于B）；NSOrderedDescending（A大于B）；
/// @param timeA 时间A
/// @param timeB 时间B
+(NSComparisonResult)compareTimeA:(NSString*)timeA withTimeB:(NSString*)timeB{
    NSComparisonResult result = NSOrderedAscending;
    if (!timeA.exist||!timeB.exist) {
        return result;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate*dt01 = [[NSDate alloc]init];
    NSDate*dt02 = [[NSDate alloc]init];
    
    dt01 = [formatter dateFromString:timeA];
    dt02 = [formatter dateFromString:timeB];
    
    return [dt01 compare:dt02];
}


@end
