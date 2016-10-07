//
//  FAtabViewController.m
//  FindAgree
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "FAtabViewController.h"

@interface FAtabViewController ()

@end

@implementation FAtabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0];
    CALayer *TopBorder = [CALayer layer];
    TopBorder.frame = CGRectMake(0.0f, 0.0f, self.tabBar.frame.size.width, 0.4f);
    TopBorder.backgroundColor = [UIColor blackColor].CGColor;
    [self.tabBar.layer addSublayer:TopBorder];
    
    [self setHidesBottomBarWhenPushed:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
