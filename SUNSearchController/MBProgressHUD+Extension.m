//
//  MBProgressHUD+Extension.m
//
//  Created by 孙金帅 on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

#pragma mark 提示语
+ (void)showTipsMessage:(NSString *)text toView:(UIView *)view
{
    return [self showTipsMessage:text icon:nil view:view];
}

+ (void)showTipsMessage:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if ((text == nil || [text isEqualToString:@""]) && icon == nil) {
        return;
    }

    if (view == nil) {
        view = [[UIApplication sharedApplication].windows firstObject];
    }
    [self hideAllHUDsForView:view animated:YES];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.userInteractionEnabled = NO;
    // 设置图片
    if (icon) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]];
        hud.customView = [[UIImageView alloc] initWithImage:image];
    }
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    // N秒之后再消失
    [hud hide:YES afterDelay:1.5];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows firstObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}


+ (void)hideHUDForView:(UIView *)view
{
    [self hideAllHUDsForView:view animated:NO];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

@end
