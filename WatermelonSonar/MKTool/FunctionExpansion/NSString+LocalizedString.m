//
//  NSString+LocalizedString.m
//  Twideo
//
//  Created by 麻明康 on 2023/8/31.
//

#import "NSString+LocalizedString.h"

@implementation NSString (LocalizedString)
-(NSString *)localizedString{
    return NSLocalizedString(self,nil);
}

@end
