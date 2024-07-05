//
//  Common.m
//  Twideo
//
//  Created by 麻明康 on 2023/9/4.
//

#import "Common.h"

@implementation Common
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message makeSureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle aboveController:(UIViewController *)controller sureblock:(nullable void(^)(void))sureblock cancelblock:(nullable void(^)(void))cancelblock{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle!=nil&&![cancelTitle isEqualToString:@""]) {
        //1, 创建按钮  取消样式UIAlertActionStyleCancel
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelblock) {
                cancelblock();
            }
        }];
        [alertController addAction:action];
    }
    
    if ((sureTitle==nil||[sureTitle isEqualToString:@""])&&(cancelTitle==nil||[cancelTitle isEqualToString:@""])) {
        sureTitle = @"确定";
    }
    if (sureTitle!=nil&&![sureTitle isEqualToString:@""]) {
        //2，创建按钮 确认样式UIAlertActionStyleDefault
        [alertController addAction:({
            UIAlertAction *action = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (sureblock) {
                    sureblock();
                }
            }];
            action;
        })];
        
    }
    //3，模态视图 方式显示出来
    [controller presentViewController:alertController animated:YES completion:^{
        
    }];
}


+ (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    } else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    if ([nextResponder isKindOfClass:[UIWindow class]]){
        UIWindow *nextResponderWindow = (UIWindow *)nextResponder;
        nextResponder = nextResponderWindow.rootViewController;
    }
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    } else {
        result = nextResponder;
    }
    
    return result;
}

@end
