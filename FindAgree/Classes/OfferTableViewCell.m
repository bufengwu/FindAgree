//
//  OfferTableViewCell.m
//  FindAgree
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "OfferTableViewCell.h"

@implementation OfferTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView DataSource:(NSDictionary *) dataSource {
    OfferTableViewCell * cell;
    bool answerOrQuestion = [dataSource objectForKey:@"answer"] != nil;
    NSString * reusableCellID = answerOrQuestion ? @"offerAnswerID" : @"offerQuestionID";
    cell = [tableView dequeueReusableCellWithIdentifier:reusableCellID];
    if (cell == nil) {
        if (answerOrQuestion) {
            cell = [[OfferTableViewCell alloc] setupAnswerCellwithQuestion:[dataSource objectForKey:@"question"] Answer:[dataSource objectForKey:@"answer"] Author:[dataSource objectForKey:@"author"] Price:[dataSource objectForKey:@"price"]];
        } else {
            cell = [[OfferTableViewCell alloc] setupQuestionCellwithQuestion:[dataSource objectForKey:@"question"] Description:[dataSource objectForKey:@"description"] Author:[dataSource objectForKey:@"author"] Price:[dataSource objectForKey:@"price"]];
        }
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.titleView = [[UILabel alloc]init];
    self.detailView = [[UILabel alloc]init];
    self.priceLabel = [UILabel new];
    self.authorLabel = [UILabel new];
    [self.contentView addSubview:self.titleView];
    [self.contentView addSubview:self.detailView];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.authorLabel];
    
    self.priceLabel.font = [UIFont systemFontOfSize:15];
    
    self.titleView.font = [UIFont systemFontOfSize:20];
    self.titleView.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    self.titleView.numberOfLines = 2;
    
    self.detailView.font = [UIFont systemFontOfSize:15];
    self.detailView.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    self.detailView.numberOfLines = 3;
    return self;
}

- (OfferTableViewCell*) setupAnswerCellwithQuestion:(NSString *)question Answer:(NSString *) answer Author:(NSString *) author Price:(NSString *) price {
    OfferTableViewCell * cell = [[OfferTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"offerAnswerID"];
    if (author == nil) {
        author = @"";
    }
    if (price == nil) {
        price = @"";
    }
    
    //发布者名字
    NSMutableAttributedString *authorStr = [[NSMutableAttributedString alloc] initWithString:author];
    [authorStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,authorStr.length)];
    [authorStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15] range:NSMakeRange(0, authorStr.length)];
    NSMutableAttributedString *tipStr = [[NSMutableAttributedString alloc] initWithString:@" 回答了问题，求赞"];
    [tipStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,tipStr.length)];
    [tipStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15] range:NSMakeRange(0, tipStr.length)];
    [authorStr appendAttributedString:tipStr];
    cell.authorLabel.attributedText = authorStr;
    CGSize size1 = [authorStr size];
    cell.authorLabel.frame = CGRectMake(5, 5, size1.width, size1.height);
    //悬赏额度
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:@"赏金："];
    [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,priceStr.length)];
    [priceStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15] range:NSMakeRange(0, priceStr.length)];
    NSMutableAttributedString * numStr = [[NSMutableAttributedString alloc] initWithString:price];
    [numStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,numStr.length)];
    [numStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15] range:NSMakeRange(0, numStr.length)];
    [priceStr appendAttributedString:numStr];
    cell.priceLabel.attributedText = priceStr;
    CGSize size2 = [priceStr size];
    cell.priceLabel.frame = CGRectMake(SCREEN_WIDTH - size2.width - 5, 5, size2.width, size2.height);
    //问题名称
    cell.titleView.text = question;
    //[cell.titleView sizeToFit];
    CGSize size3 = [question boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} context:nil].size;
    //CGSize size3 = cell.titleView.frame.size;
    cell.titleView.frame = CGRectMake(5, size1.height+7, size3.width, size3.height);
    //待点赞的回答
    cell.detailView.text = answer;
    CGSize size4 = [answer boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    cell.detailView.frame = CGRectMake(5, size1.height + size3.height+9, size4.width, size4.height);
    
    cell.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, cell.detailView.frame.origin.y + size4.height+5);
    cell.frame = cell.contentView.frame;
    return cell;
}

- (OfferTableViewCell*) setupQuestionCellwithQuestion:(NSString *)question Description:(NSString *) description Author:(NSString *) author Price:(NSString *) price {
    OfferTableViewCell * cell = [[OfferTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"offerQuestionID"];
    if (author == nil) {
        author = @"";
    }
    if (price == nil) {
        price = @"";
    }
    //发布者名字
    NSMutableAttributedString *authorStr = [[NSMutableAttributedString alloc] initWithString:author];
    [authorStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,authorStr.length)];
    [authorStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15] range:NSMakeRange(0, authorStr.length)];
    NSMutableAttributedString *tipStr = [[NSMutableAttributedString alloc] initWithString:@" 发布了问题，求回复"];
    [tipStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,tipStr.length)];
    [tipStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15] range:NSMakeRange(0, tipStr.length)];
    [authorStr appendAttributedString:tipStr];
    cell.authorLabel.attributedText = authorStr;
    CGSize size1 = [authorStr size];
    cell.authorLabel.frame = CGRectMake(5, 5, size1.width, size1.height);
    //悬赏额度
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:@"赏金："];
    [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,priceStr.length)];
    [priceStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15] range:NSMakeRange(0, priceStr.length)];
    NSMutableAttributedString * numStr = [[NSMutableAttributedString alloc] initWithString:price];
    [numStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,numStr.length)];
    [numStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15] range:NSMakeRange(0, numStr.length)];
    [priceStr appendAttributedString:numStr];
    cell.priceLabel.attributedText = priceStr;
    CGSize size2 = [priceStr size];
    cell.priceLabel.frame = CGRectMake(SCREEN_WIDTH - size2.width - 5, 5, size2.width, size2.height);
    //问题名称
    cell.titleView.text = question;
    //[cell.titleView sizeToFit];
    CGSize size3 = [question boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} context:nil].size;
    //CGSize size3 = cell.titleView.frame.size;
    cell.titleView.frame = CGRectMake(5, size1.height+7, size3.width, size3.height);
    //待点赞的回答
    cell.detailView.text = description;
    CGSize size4 = [description boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    cell.detailView.frame = CGRectMake(5, size1.height + size3.height+9, size4.width, size4.height);
    
    cell.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, cell.detailView.frame.origin.y + size4.height+5);
    cell.frame = cell.contentView.frame;
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
