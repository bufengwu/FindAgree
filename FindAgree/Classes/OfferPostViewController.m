//
//  OfferPostViewController.m
//  XZ
//
//  Created by mac on 16/7/18.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "OfferPostViewController.h"
#import "FAUtils.h"
#import "FAdataSource.h"
#import "OfferTableViewCell.h"
#import "DeailViewController.h"
@interface OfferPostViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) NSArray * dataSource;
@property (nonatomic,assign) NSInteger segmentindex;

@property (nonatomic, strong) UITableView * tableView;
@end

@implementation OfferPostViewController

static NSIndexPath * lastSelectIndex;

- (instancetype)initWithSeg:(NSInteger) segmentIndex {
    self = [super init];
    self.segmentindex = segmentIndex;
    switch (segmentIndex) {
        case 0:
            self.navigationItem.title = [FAUtils getLabelByName:@"my answer"];
            self.dataSource = [FAdataSource sharedInstance].myAnswer;
            break;
        case 1:
            self.navigationItem.title = [FAUtils getLabelByName:@"my question"];
            self.dataSource = [FAdataSource sharedInstance].myQuestion;
            break;
            
        default:
            break;
    }
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithTitle:[FAUtils getLabelByName:@"offer"] style:UIBarButtonItemStyleDone target:self action:@selector(reward)];
    rightButton.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}


- (void) reward {
    if (lastSelectIndex == nil || (lastSelectIndex.row == 9 && lastSelectIndex.section == 9) ) {
        [FAUtils showAllTextDialog:@"请选择要悬赏的问题"];
    } else {
        NSLog(@"悬赏%ld",(long)lastSelectIndex.section);
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"resuable"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"resuable"];
    }
    switch (self.segmentindex) {
        case 0:
            cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"question"];
            cell.detailTextLabel.text = [[self.dataSource objectAtIndex:indexPath.section] objectForKey:@"answer"];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:20];
            break;
        case 1:
            cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"question"];
            cell.detailTextLabel.text = [[self.dataSource objectAtIndex:indexPath.section] objectForKey:@"description"];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:20];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //选中某一个时会显示选中辅助按钮
    UITableViewCell *cell = [ self.tableView cellForRowAtIndexPath: indexPath ];
    if (indexPath == lastSelectIndex) {
        if (cell.accessoryType == UITableViewCellAccessoryNone) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            lastSelectIndex = indexPath;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            lastSelectIndex = [NSIndexPath indexPathForRow:9 inSection:9];
        }
    } else {
        [self.tableView cellForRowAtIndexPath: lastSelectIndex].accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        lastSelectIndex = indexPath;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
