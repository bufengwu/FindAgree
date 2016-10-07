//
//  ViewController.h
//  FindAgree
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FASliderDelegate.h"

@interface rootViewController : UIViewController<SliderDelegate>

- (instancetype) initWithLeftSliderVC:(UIViewController *) leftSliderVC andMainVC:(UITabBarController *) mainVC;
@end

