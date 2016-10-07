//
//  FAleftSliderViewController.m
//  FindAgree
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "FAleftSliderViewController.h"

@interface FAleftSliderViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * labelArr;
@end

@implementation FAleftSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3*2, SCREEN_HEIGHT)];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.view.frame = CGRectMake(-SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3*2, SCREEN_HEIGHT);
    self.labelArr = @[@"选择排序方式",@"按赏金排序",@"按时间排序",@"按热度排序"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    }
    return 80;
}

#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.labelArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"sortBox"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sortBox"];
        cell.textLabel.text = self.labelArr[indexPath.row];
        if (indexPath.row == 0) {
            cell.backgroundColor = RGB(80, 98, 107);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;
}

@end
