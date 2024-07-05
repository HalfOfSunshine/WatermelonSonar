//
//  CommonHeader.h
//  Twideo
//
//  Created by 麻明康 on 2023/8/31.
//

#ifndef CommonHeader_h
#define CommonHeader_h

#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//程序版本号
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//获取APP build版本
#define APP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

#define isIOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

//屏幕的宽度
#define KScreenSize [UIScreen mainScreen].bounds.size
//屏幕边距
#define SCREEN_PD 15
//导航栏的高
#define NavigationBar_H  self.navigationController.navigationBar.frame.size.height

//状态栏的高
#define StatusBar_H \
({float statusBarHeight = 20;\
if(@available(iOS 15.0,*)) {\
    NSSet *set = [[UIApplication sharedApplication] connectedScenes];\
    UIWindowScene *windowScene = [set anyObject];\
    UIStatusBarManager *statusBarManager2 =  windowScene.statusBarManager;\
    statusBarHeight = statusBarManager2.statusBarFrame.size.height;\
}else if (@available(iOS 13.0, *)) {\
    UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;\
    statusBarHeight = statusBarManager.statusBarFrame.size.height;\
}else {\
    statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;\
}\
(statusBarHeight);})

#define TopBar_H      (NavigationBar_H+StatusBar_H)

//标签栏的高
#define TabBar_H     self.tabBarController.tabBar.frame.size.height
//屏幕底部安全距离
#define SafeAreaBottomHeight ({\
    CGFloat result = 0.;\
    if (@available(iOS 11.0, *)) {\
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;\
        result = (safeAreaInsets.bottom != 0)?safeAreaInsets.bottom:0;\
    }\
    (result);\
})

#define SafeAreaStatusHeight  ({\
    CGFloat result = 20.;\
    if (@available(iOS 11.0, *)) {\
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;\
        result = (safeAreaInsets.top != 0)?safeAreaInsets.top:20;\
    }\
    (result);\
})

#define TarBar_Height (SafeAreaBottomHeight + 50.f)
#define SafeAreaContentHeight(__viewController) (SCREENH - (__viewController.hidesBottomBarWhenPushed?0.f:TarBar_Height) - NavigationBar_Height)

//颜
#define RGBA(__r, __g, __b, __a) [UIColor colorWithRed:(1.0*(__r)/255)\
green:(1.0*(__g)/255)\
blue:(1.0*(__b)/255)\
alpha:(1.0*(__a)/255)]
#define RGB(__r, __g, __b)  RGBA(__r, __g, __b, 255.0)
#define ColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define ColorFromAlphaHex(a,s) [UIColor colorWithRed:((float)((s & 0xFF0000) >> 16))/255.0 green:((float)((s & 0xFF00) >> 8))/255.0 blue:((float)(s & 0xFF))/255.0 alpha:a]
#define MainColor ColorFromHex(0x51B56C)


//weakify & strongify
#define MKweakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__attribute__((objc_ownership(weak))) __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#define MKstrongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__attribute__((objc_ownership(strong))) __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")


#import "NSString+Size.h"
#import "UIColor+MKRGB.h"
#import "Common.h"
#endif /* CommonHeader_h */
