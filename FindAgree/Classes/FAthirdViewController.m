//
//  FAthirdViewController.m
//  FindAgree
//
//  Created by mac on 16/8/5.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "FAthirdViewController.h"

@interface FAthirdViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray * imgArr;
@property (nonatomic, strong) NSArray * labelArr;
@property (nonatomic, strong) NSDictionary * userMsg;
@end

@implementation FAthirdViewController
- (instancetype) init {
    self = [super init];
    self.navigationItem.title = [FAUtils getLabelByName:@"personal center"];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView * tableveiw = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    
    [self.view addSubview:tableveiw];
    tableveiw.dataSource = self;
    tableveiw.delegate =self;
    tableveiw.scrollEnabled = NO;
    tableveiw.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.imgArr = @[@"income",@"like",@"setting"];
    self.labelArr = @[@"我的赏金",@"我的光荣榜",@"设置"];
    
    self.userMsg = @{@"userFace":@"face", @"userName":@"王硌碧", @"signature":@"请设置签名"};
}

#pragma mark tableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) {
        return 150;
    }
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [self.imgArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        if (indexPath.section == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TableSampleIdentifier];
            cell.imageView.image = [FAUtils getImageByName:self.userMsg[@"userFace"]];
            cell.imageView.backgroundColor = [UIColor grayColor];
            cell.textLabel.text = self.userMsg[@"userName"];
            cell.detailTextLabel.text = self.userMsg[@"signature"];
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
            NSUInteger row = [indexPath row];
            cell.imageView.image = [FAUtils getImageByName:self.imgArr[row]];
            cell.textLabel.text = self.labelArr[row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else {
        while ([cell.contentView.subviews lastObject ]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%ld",(long)indexPath] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录" message:@"请输入用户名密码" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"用户名";
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"密码";
            textField.secureTextEntry = YES;
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *login = alertController.textFields.firstObject;
            UITextField *password = alertController.textFields.lastObject;
            NSLog(@"%@,%@",login.text,password.text);
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
