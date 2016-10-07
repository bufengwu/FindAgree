//
//  FAfirstViewController.m
//  FindAgree
//
//  Created by mac on 16/8/4.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "FAfirstViewController.h"
#import "FAdataSource.h"
#import "FATableViewCell.h"
#import "DeailViewController.h"

#import "FAsortBoxViewController.h"
#import "OfferPostViewController.h"

@interface FAfirstViewController () <UITableViewDelegate, UITableViewDataSource, GoPushedViewDelegate>

@property (nonatomic,strong) NSArray * dataArr;

@end

@implementation FAfirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[FAUtils getImageByName:@"sort"] style:UIBarButtonItemStyleDone target:self action:@selector(sort)];
    leftButton.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(showbox)];
    rightButton.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setLeftBarButtonItem: leftButton];
    [self.navigationItem setRightBarButtonItem:rightButton];
    self.navigationItem.title = [FAUtils getLabelByName:@"Discover new content"];
    
    self.dataArr = [FAdataSource sharedInstance].findArr;
    
    UITableView * table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.delegate addPan];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.delegate removePan];
}

- (void) sort {
    [self.delegate changeLeftSlider];
}

- (void) showbox {
    [[FAsortBoxViewController sharedInstance]showView];
    [FAsortBoxViewController sharedInstance].delegate = self;
}

#pragma mark GoPushedViewDelegate

- (void) goMyAnswer {
    [self gotoPost:0];
}

- (void) goMyQuestion {
    [self gotoPost:1];
}

#pragma mark 去往“我的问题求回答”/“我的回答求点赞”页面
- (void) gotoPost:(int)seg {
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:[[OfferPostViewController alloc] initWithSeg:seg] animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}


#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FATableViewCell * cell = [FATableViewCell cellWithTableView:tableView DataSource:[[FAdataSource sharedInstance].findArr objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DeailViewController * vc = [DeailViewController new];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

@end
