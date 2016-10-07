//
//  XZUtils.m
//  XZ
//
//  Created by mac on 16/7/11.
//  Copyright © 2016年 罗辑. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FAUtils.h"
#import "MBProgressHUD.h"
@implementation FAUtils

+ (NSBundle *)getLocalBundle:(NSString *) name {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:name ofType:@"bundle"];
    return [NSBundle bundleWithPath:bundlePath];
}

+(NSString *) getLabelByName:(NSString *) name {
    NSBundle * xzBundle = [FAUtils getLocalBundle:@"XZ"];
    return [xzBundle localizedStringForKey:name value:nil table:@"Localizable"];
}

+ (UIImage *) getImageByName:(NSString *) name {
    NSBundle * xzBundle = [FAUtils getLocalBundle:@"XZ"];
    NSString *imgpath = [xzBundle pathForResource:name ofType:@"png"];
    return [[UIImage alloc] initWithContentsOfFile:imgpath];
}

+ (void) showAllTextDialog:(NSString *)str {
    __block MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:[[[UIApplication sharedApplication].keyWindow subviews] objectAtIndex:0]];
    [[[[UIApplication sharedApplication].keyWindow subviews] objectAtIndex:0] addSubview:HUD];
    HUD.label.text = str;
    HUD.mode = MBProgressHUDModeText;
    //指定距离中心点的X轴和Y轴的位置，不指定则在屏幕中间显示
    //    HUD.yOffset = 100.0f;
    //    HUD.xOffset = 100.0f;
    [HUD showAnimated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [HUD hideAnimated:YES];
            [HUD removeFromSuperview];
            HUD = nil;
        });
    });
}

@end
