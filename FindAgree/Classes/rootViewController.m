//
//  ViewController.m
//  FindAgree
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 罗辑. All rights reserved.
//


#import "rootViewController.h"
#import "FAleftSliderViewController.h"
#import "FAtabViewController.h"

#import "FAdataSource.h"

@interface rootViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIViewController * leftSliderVC;
@property (nonatomic, strong) UITabBarController * tabVC;
@property (nonatomic, strong) UIPanGestureRecognizer * pan;
@property (nonatomic, strong) UITapGestureRecognizer * tap;
@end

@implementation rootViewController

static bool leftIsOpen = NO;

- (instancetype) initWithLeftSliderVC:(UIViewController *) leftSliderVC andMainVC:(UITabBarController *) mainVC {
    self = [super init];
    
    [[FAdataSource sharedInstance] initData];
    
    [self addChildViewController:leftSliderVC];
    [self addChildViewController:mainVC];
    [self.view addSubview:leftSliderVC.view];
    [self.view addSubview:mainVC.view];
    
    self.leftSliderVC = leftSliderVC;
    self.tabVC = mainVC;
    self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.tabVC.view addGestureRecognizer:self.pan];
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    
    return self;
}

#pragma mark - 滑动手势
- (void) addPan {
    [self.tabVC.view addGestureRecognizer:self.pan];
}

- (void) removePan {
    [self.tabVC.view removeGestureRecognizer:self.pan];
}


/**
 *  触摸手势事件
 *  移动过程中，手势向右，且抽屉未打开状态，两个视图向右移动手势距离;手势向左，抽屉已打开状态，两个视图向左
 *  移动结束时，手势距离小于屏幕宽一半，动画回复原状；大于一半，动画置为2/3屏幕的位置
 *  @param rec 手势句柄
 */
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    CGPoint point = [rec translationInView:self.view];
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (point.x > SCREEN_WIDTH/2) {
            [self openLeftSlider];
        } else {
            [self closeLeftSlider];
        }
    }
    if (rec.state == UIGestureRecognizerStateChanged) {
        if (!leftIsOpen && point.x > 0 && point.x < SCREEN_WIDTH/3*2+1) {
            self.tabVC.view.frame = CGRectMake(point.x, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            self.leftSliderVC.view.frame = CGRectMake(point.x-SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3*2, SCREEN_HEIGHT);
        }
        if (leftIsOpen && point.x < 0 && point.x > -SCREEN_WIDTH/3*2) {
            self.tabVC.view.frame = CGRectMake(point.x + SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            self.leftSliderVC.view.frame = CGRectMake(point.x, 0, SCREEN_WIDTH/3*2, SCREEN_HEIGHT);
        }
    }
}

- (void) handleTap: (UITapGestureRecognizer *)rec{
    [self closeLeftSlider];
}

- (void) changeLeftSlider {
    if (leftIsOpen) {
        [self closeLeftSlider];
    } else {
        [self openLeftSlider];
    }
}

- (void) openLeftSlider {
    leftIsOpen = YES;
    [self.tabVC.view addGestureRecognizer:self.tap];
    [UIView animateWithDuration:0.2 animations:^{
        self.leftSliderVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH/3*2, SCREEN_HEIGHT);
        self.tabVC.view.frame = CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}
- (void) closeLeftSlider {
    leftIsOpen = NO;
    [self.tabVC.view removeGestureRecognizer:self.tap];
    [UIView animateWithDuration:0.2 animations:^{
        self.tabVC.view.frame = SCREEN_RECT;
        self.leftSliderVC.view.frame = CGRectMake(-SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3*2, SCREEN_HEIGHT);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
