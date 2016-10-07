//
//  FAdataSource.h
//  FindAgree
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAdataSource : NSObject

@property (nonatomic, strong) NSArray * myAnswer;
@property (nonatomic, strong) NSArray * myQuestion;
@property (nonatomic, strong) NSArray * offerAnswer;
@property (nonatomic, strong) NSArray * offerQuestion;
@property (nonatomic, strong) NSArray * findArr;

+ (instancetype)sharedInstance ;
- (void) initData;
@end
