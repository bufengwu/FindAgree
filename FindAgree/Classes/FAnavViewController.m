//
//  FANavViewController.m
//  FindAgree
//
//  Created by mac on 16/8/4.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "FAnavViewController.h"

@interface FAnavViewController ()

@end

@implementation FAnavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    [self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    

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
