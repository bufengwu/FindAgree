//
//  DeailViewController.m
//  FindAgree
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "DeailViewController.h"

@interface DeailViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@end

@implementation DeailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.scrollView setDelegate:self];
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2);
    
    UILabel * titleView = [[UILabel alloc]init];
    UILabel * detailView = [[UILabel alloc]init];
    //[self.scrollView addSubview:titleView];
    
    
    titleView.font = [UIFont systemFontOfSize:20];
    titleView.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    titleView.numberOfLines = 2;
    
    detailView.font = [UIFont systemFontOfSize:15];
    detailView.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    detailView.numberOfLines = 3;
    
    //问题名称
    titleView.text = @"question1";
    //[cell.titleView sizeToFit];
    [titleView setFont:[UIFont systemFontOfSize:25]];
    CGSize size3 = [@"question1" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-10, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : titleView.font} context:nil].size;
    titleView.backgroundColor = RGB(20, 160, 190);
    if (size3.width < SCREEN_WIDTH) {
        titleView.frame = CGRectMake(5, 7, SCREEN_WIDTH-10, size3.height);
    } else {
        titleView.frame = CGRectMake(5, 7, size3.width, size3.height);
    }
    //待点赞的回答
    detailView.text = @"answer test1";
    [detailView setFont:[UIFont systemFontOfSize:20]];
    CGSize size4 = [@"answer test1" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : detailView.font} context:nil].size;
    detailView.backgroundColor = RGB(222, 210, 152);
    if (size4.width < SCREEN_WIDTH) {
        detailView.frame = CGRectMake(10, size3.height, SCREEN_WIDTH - 20, size4.height+20);
    } else {
        detailView.frame = CGRectMake(5, size3.height, size4.width, size4.height);
    }
    [self.scrollView addSubview:detailView];
    [self.scrollView addSubview:titleView];
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, detailView.frame.origin.y + detailView.frame.size.height);
    self.scrollView.backgroundColor= RGB(121, 106, 84);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
