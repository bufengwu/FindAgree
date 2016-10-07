//
//  FATableViewCell.h
//  FindAgree
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FATableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleView;
@property (nonatomic, strong) UILabel * detailView;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * authorLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView DataSource:(NSDictionary *) dataSource;

@end
