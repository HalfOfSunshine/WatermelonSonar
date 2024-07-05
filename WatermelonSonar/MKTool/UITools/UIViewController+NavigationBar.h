//
//  UIViewController+NavigationBar.h
//  Twideo
//
//  Created by ma  on 23-09-01.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationBar)

- (void)setBarColor:(UIColor*)color;
/**
 *  如果有self.navigationController.navigationBarHidden = NO;加在self.navigationController.navigationBarHidden = NO;之后，不然会造成视图堆积；
 */

//- (void)setBarWithoutLineInColor:(UIColor *)color;

- (void)setNavBar;
- (void)setLightBar;
- (void)setWhiteNavBar;
- (void)setWeCatchBar;
- (void)setDefaultBarLine;
//- (void)setBarLineColor:(UIColor *)color;
- (void)setWhiteBackButton;
- (void)setNavTitle:(NSString *)navTitle;
- (void)closeView;
- (void)setNavSeparatorLineHidden:(BOOL)hidden;
@end


