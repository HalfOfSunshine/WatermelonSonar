//
//  Common.h
//  Twideo
//
//  Created by 麻明康 on 2023/9/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Common : NSObject
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message makeSureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle aboveController:(UIViewController *)controller sureblock:(nullable void(^)(void))sureblock cancelblock:(nullable void(^)(void))cancelblock;
+ (UIViewController *)getCurrentVC;
@end

NS_ASSUME_NONNULL_END
