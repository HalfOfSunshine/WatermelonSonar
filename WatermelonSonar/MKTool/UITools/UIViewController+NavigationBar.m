//
//  UIViewController+NavigationBar.m
//  Twideo
//
//  Created by ma  on 23-09-01.
//

#import "UIViewController+NavigationBar.h"
#import "sys/utsname.h"

@implementation UIViewController (NavigationBar)

- (void)setBarColor:(UIColor*)color
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 150000
    
 if (@available(iOS 15.0, *))  {
     UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
     barApp.backgroundColor = color;
     barApp.backgroundEffect = nil;
     barApp.shadowColor = [UIColor clearColor];
     self.navigationController.navigationBar.scrollEdgeAppearance = barApp;
     self.navigationController.navigationBar.standardAppearance = barApp;
 }else
   #endif
       {
   #if __IPHONE_OS_VERSION_MIN_REQUIRED < 150000
           [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
           [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
           [self.navigationController.navigationBar setBarTintColor:color];
   #endif
    }
}



- (void)setNavBar{
    [self setBarColor:MainColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    
}

- (void)setWhiteNavBar{
    
    [self setBarColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)setLightBar
{
    [self setBarColor:[UIColor colorWithWhite:0.990 alpha:1.0]];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)setWeCatchBar
{
    [self setBarColor:nil];
}

-(void)setDefaultBarLine{
    //清除上一次加的线条
    for (UIView *v in self.navigationController.navigationBar.subviews) {
        if (v.tag == 211) {
            [v removeFromSuperview];
        }
    }
    //        清除系统线条
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        for (NSObject *obj in self.navigationController.navigationBar.subviews) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                for (NSObject *obj2 in imageView.subviews) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=NO;
                    }
                }
            }
        }
    }
}


// 找到这个黑线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setNavSeparatorLineHidden:(BOOL)hidden{
    UIView *separatorLine = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    separatorLine.hidden = hidden;
}

- (void)setWhiteBackButton
{
    [self setBackButton:0];
}

- (void)setBackButton:(NSInteger)style
{
    //返回按钮
    UIButton *backButton  =  [[UIButton alloc] init];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    //[backButton setImage: [UIImage imageNamed:@"back_btn_g.png"] forState: UIControlStateNormal];
    backButton.userInteractionEnabled = YES;
    switch (style) {
        case 0:{
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
                backButton.frame  =  CGRectMake(2.5, 0, 22, 22);
            } else {
                backButton.frame  =  CGRectMake(12.5, 0, 22, 22);
            }
            backButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
            [backButton setImage:[UIImage imageNamed:@"shaitu_return"] forState:UIControlStateNormal];
            [backButton setImage:[UIImage imageNamed:@"shaitu_return_h"] forState:UIControlStateHighlighted];
            
            [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [backButton.titleLabel setNumberOfLines:1];
            backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
            [backButton.titleLabel sizeToFit];
            [backButton sizeToFit];
            
            break;
        }
        default:
            break;
    }
    [backButton addTarget: self action:@selector(closeView) forControlEvents: UIControlEventTouchUpInside];
    
    UIView *leftview = [[UIView alloc] init];
    // iOS 11 适配
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
        leftview.frame = CGRectMake(0, 0, 40, 22);
    } else {
        leftview.frame = CGRectMake(0, 0, 40, 22);
    }
    [leftview setTapGestureRecognizerWithTarget:(id)self action:@selector(closeView)];
    //    leftview.backgroundColor = [UIColor redColor];
    [leftview addSubview:backButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftview];
}

- (void)closeView
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setNavTitle:(NSString *)navTitle{
    
    UILabel *label = [[UILabel alloc]init];
    label.text = navTitle;
    label.frame = CGRectMake(0, 0, 100, 40);
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    self.navigationItem.titleView = label;
}
- (IBAction) handleLongpressGesture:(UIGestureRecognizer *) sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end


