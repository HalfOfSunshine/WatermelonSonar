//
//  UIWindow+MKWindowTool.m
//  DSPDemo
//
//  Created by 麻明康 on 2024/1/9.
//

#import "UIWindow+MKWindowTool.h"

@implementation UIWindow (MKWindowTool)
+(UIWindow *)currentWindow{
    
    if([[[UIApplication sharedApplication] delegate] window]){
        return [[[UIApplication sharedApplication] delegate] window];
    }else {
        if (@available(iOS 13.0,*)) {
            NSArray *arr = [[[UIApplication sharedApplication] connectedScenes] allObjects];
            UIWindowScene *windowScene =  (UIWindowScene *)arr[0];
            //如果是普通APP开发，可以使用
            //SceneDelegate *delegate = (SceneDelegate *)windowScene.delegate;
            //UIWindow *mainWindow = delegate.window;
            
            //  由于在sdk开发中，引入不了SceneDelegate的头文件，所以需要使用kvc获取宿主的app的window
            UIWindow *mainWindow = [windowScene valueForKeyPath:@"delegate.window"];
            if(mainWindow){
                return mainWindow;
            }else{
                return [UIApplication sharedApplication].windows.lastObject;
            }
        }else {
            return [UIApplication sharedApplication].keyWindow;
        }
        
    }
}

@end
