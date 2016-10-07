//
//  FAsecondViewController.m
//  FindAgree
//
//  Created by mac on 16/8/4.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "FAsecondViewController.h"
#import "OfferPostViewController.h"
#import "OfferTableViewCell.h"
#import "FAdataSource.h"

#import "AFNetworking.h"
#import "MJRefresh.h"

@interface FAsecondViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView * questionListView;
@property (nonatomic, strong) UITableView * answerListView;
@property (nonatomic, strong) NSArray * questionArr;
@property (nonatomic, strong) NSArray * answerArr;

@property (nonatomic, strong) UISegmentedControl * segmentControl;
@end

@implementation FAsecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithTitle:[FAUtils getLabelByName:@"sort"] style:UIBarButtonItemStyleDone target:self action:@selector(sort)];
    leftButton.tintColor = [UIColor whiteColor];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithTitle:[FAUtils getLabelByName:@"ask like"] style:UIBarButtonItemStyleDone target:self action:@selector(gotoPost)];
    rightButton.tintColor = [UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem: leftButton];
    [self.navigationItem setRightBarButtonItem:rightButton];
    NSArray * segmentArr = @[[FAUtils getLabelByName:@"answer reward list"], [FAUtils getLabelByName:@"question reward list"]];
    
    self.segmentControl = [[UISegmentedControl alloc]initWithItems:segmentArr];
    [self.segmentControl addTarget:self action:@selector(segmentControlPressed:) forControlEvents:UIControlEventValueChanged];
    self.segmentControl.layer.borderColor = [UIColor whiteColor].CGColor;
    self.segmentControl.layer.borderWidth = 2;
    self.segmentControl.tintColor = [UIColor whiteColor];
    self.segmentControl.backgroundColor = [UIColor clearColor];
    self.segmentControl.layer.cornerRadius = 10;
    self.segmentControl.layer.masksToBounds = YES;
    self.segmentControl.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = self.segmentControl;
    
    self.questionListView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.questionListView.delegate = self;
    self.questionListView.dataSource = self;
    self.questionListView.estimatedRowHeight = 80;
    self.questionListView.rowHeight = UITableViewAutomaticDimension;
    
    self.answerListView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.answerListView.delegate = self;
    self.answerListView.dataSource = self;
    self.answerListView.estimatedRowHeight = 80;
    self.answerListView.rowHeight = UITableViewAutomaticDimension;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview: self.questionListView];
    [self.view addSubview: self.answerListView];
    
    
    [self setupRefreshWithTableView:self.questionListView];
    [self setupRefreshWithTableView:self.answerListView];
    self.questionArr = [FAdataSource sharedInstance].offerQuestion;
    self.answerArr = [FAdataSource sharedInstance].offerAnswer;
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

#pragma mark 切换展示问题悬赏榜和答案悬赏榜
- (void) segmentControlPressed:(UISegmentedControl *)sender {
    switch ((long)sender.selectedSegmentIndex) {
            case 0:
            self.answerListView.alpha = 1;
            self.questionListView.alpha =0;
            self.navigationItem.rightBarButtonItem.title = [FAUtils getLabelByName:@"ask like"];
            break;
            case 1:
            self.answerListView.alpha = 0;
            self.questionListView.alpha = 1;
            self.navigationItem.rightBarButtonItem.title = [FAUtils getLabelByName:@"ask answer"];
        default:
            break;
    }
}

#pragma mark 去往“我的问题求回答”/“我的回答求点赞”页面
- (void) gotoPost {
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:[[OfferPostViewController alloc] initWithSeg:self.segmentControl.selectedSegmentIndex] animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

#pragma mark 给当前显示的表格排序


- (void) updateTable {
    if (self.segmentControl.selectedSegmentIndex == 0) {
        //self.answerArr= resArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.answerListView reloadData];
        });
    } else {
        //self.questionArr= resArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.questionListView reloadData];
        });
    }
}

#pragma mark 下拉刷新、下拉加载更多
-(void) setupRefreshWithTableView :(UITableView *) tableview {
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self dropdownWithTableView:tableview];
    }];
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self dropupWithTableView:tableview];
    }];
}

-(void) dropdownWithTableView :(UITableView *) tableview  {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://pm.yunhan-china.com/index.php/Api_sale/sales_get" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"start get");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"get succ");
        [tableview reloadData];
        [tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [tableview.mj_header endRefreshing];
    }];
}

-(void) dropupWithTableView :(UITableView *) tableview  {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://pm.yunhan-china.com/index.php/Api_sale/sales_get" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"start get");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"get succ");
        [tableview reloadData];
        [tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [tableview.mj_footer endRefreshing];
    }];
}

#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfferTableViewCell * cell;
    if (tableView == self.questionListView) {
        cell = [OfferTableViewCell cellWithTableView:tableView DataSource:[self.questionArr objectAtIndex:indexPath.section]];
    } else {
        cell = [OfferTableViewCell cellWithTableView:tableView DataSource:[self.answerArr objectAtIndex:indexPath.section]];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.questionListView) {
        return [self.questionArr count];
    } else {
        return [self.answerArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

@end
