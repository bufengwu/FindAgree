//
//  FAsortBoxViewController.m
//  FindAgree
//
//  Created by mac on 16/8/8.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "FAsortBoxViewController.h"

@interface FAsortBoxViewController()

@property (nonatomic, strong) UIView * view;
@property (nonatomic, strong) UIView * trayView;
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIButton * closeBtn;

@end

@implementation FAsortBoxViewController
+ (instancetype)sharedInstance {
    static FAsortBoxViewController *sharedBoxVC = nil;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        sharedBoxVC = [[super allocWithZone:NULL] init];
        CGPoint center = [UIApplication sharedApplication].keyWindow.center;
        
        sharedBoxVC.view = [[UIView alloc]initWithFrame:CGRectMake(50,-100, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        sharedBoxVC.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
        sharedBoxVC.bgView.center = center;
        sharedBoxVC.bgView.backgroundColor = RGBA(20, 155, 213, 1);
        sharedBoxVC.bgView.layer.cornerRadius = 25;
        sharedBoxVC.bgView.layer.borderWidth = 2;
        
        sharedBoxVC.bgView.alpha = 0;
        
        [sharedBoxVC.view addSubview:sharedBoxVC.bgView];
        
        sharedBoxVC.closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,  44, 44)];
        sharedBoxVC.closeBtn.center = CGPointMake(center.x, center.y - 230);
        [sharedBoxVC.closeBtn setBackgroundImage:[FAUtils getImageByName:@"close"] forState:UIControlStateNormal];
        [sharedBoxVC.closeBtn addTarget:sharedBoxVC action:@selector(closeBox) forControlEvents:UIControlEventTouchUpInside];
        sharedBoxVC.closeBtn.alpha = 0;
        [sharedBoxVC.view addSubview:sharedBoxVC.closeBtn];
        
        UIButton * gotoMyAnswer = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        gotoMyAnswer.center = CGPointMake(center.x, center.y - 60);
        [gotoMyAnswer setTitle:[FAUtils getLabelByName:@"my answer"] forState:UIControlStateNormal];
        [gotoMyAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [gotoMyAnswer setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [gotoMyAnswer setBackgroundColor:[UIColor whiteColor]];
        [gotoMyAnswer addTarget:sharedBoxVC action:@selector(goMyAnswer) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * gotoMyQuestion = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        gotoMyQuestion.center = CGPointMake(center.x, center.y + 60);
        [gotoMyQuestion setTitle:[FAUtils getLabelByName:@"my question"] forState:UIControlStateNormal];
        [gotoMyQuestion setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [gotoMyQuestion setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [gotoMyQuestion setBackgroundColor:[UIColor whiteColor]];
        [gotoMyQuestion addTarget:sharedBoxVC action:@selector(goMyQuestion) forControlEvents:UIControlEventTouchUpInside];
        
        [sharedBoxVC.view addSubview:gotoMyAnswer];
        [sharedBoxVC.view addSubview:gotoMyQuestion];
        
        
    });
    return sharedBoxVC;
}

+ (id) allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id) copyWithZone:(struct _NSZone *)zone {
    return self;
}

- (void) showView {
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = SCREEN_RECT;
        self.bgView.alpha = 1;
        self.closeBtn.alpha =1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.backgroundColor = RGBA(1, 1, 1, 0.5);
        } completion:^(BOOL finished) {
            ;
        }];
    }];
}

- (void) closeBox {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(50,-100, SCREEN_WIDTH, SCREEN_HEIGHT);
            self.bgView.alpha = 0;
            self.closeBtn.alpha = 0;
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
        }];
    }];
    
}

- (void) goMyAnswer {
    self.view.backgroundColor = [UIColor clearColor];
    self.view.frame = CGRectMake(50,-100, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.bgView.alpha = 0;
    self.closeBtn.alpha = 0;
    [self.view removeFromSuperview];
    [self.delegate goMyAnswer];
}

- (void) goMyQuestion {
    self.view.backgroundColor = [UIColor clearColor];
    self.view.frame = CGRectMake(50,-100, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.bgView.alpha = 0;
    self.closeBtn.alpha = 0;
    [self.view removeFromSuperview];
    [self.delegate goMyQuestion];
}

@end
