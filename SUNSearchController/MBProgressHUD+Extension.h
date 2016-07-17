//
//  MBProgressHUD+Extension.h
//
//  Created by 孙金帅 on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)

@property (nonatomic, strong) UIImageView *anmationImageView;

// 提示语
+ (void)showTipsMessage:(NSString *)text toView:(UIView *)view;
+ (void)showTipsMessage:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
