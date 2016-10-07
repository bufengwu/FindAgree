//
//  FAdataSource.m
//  FindAgree
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import "FAdataSource.h"

@implementation FAdataSource

static FAdataSource *sharedDataSource = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        sharedDataSource = [[super allocWithZone:NULL] init];
    });
    return sharedDataSource;
}

+ (id) allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id) copyWithZone:(struct _NSZone *)zone {
    return self;
}


- (void) initData {
    self.myQuestion = @[
                        @{@"question":@"this is a question test1",@"description":@"description question1"},
                        @{@"question":@"this is a question test2",@"description":@"description question2"},
                        @{@"question":@"this is a question test3",@"description":@"description question3"},
                        @{@"question":@"this is a question test4",@"description":@"description question4"}];
    self.myAnswer = @[
                        @{@"question":@"this is a question test1",@"answer":@"answer question1"},
                        @{@"question":@"this is a question test2",@"answer":@"answer question2"},
                        @{@"question":@"this is a question test3",@"answer":@"answer question3"},
                        @{@"question":@"this is a question test4",@"answer":@"answer question4"}];
    self.offerQuestion = @[
                           @{@"question":
                                 @"怎样学习吃饭",
                             @"description":
                                 @"我告诉你你啊，要拿勺子",
                             @"author":
                                 @"tom",
                             @"price":
                                 @"99"},
                           @{@"question":
                                 @"怎样学习喝水",
                             @"description":
                                 @"",
                             @"author":
                                 @"jim",
                             @"price":
                                 @"88"},
                           @{@"question":
                                 @"怎样学习吃饭",
                             @"description":
                                 @"我告诉你你啊，要拿勺子",
                             @"author":
                                 @"tom",
                             @"price":
                                 @"100"},
                           @{@"question":
                                 @"怎样学习吃饭",
                             @"description":
                                 @"我告诉你你啊，要拿勺子",
                             @"author":
                                 @"tom",
                             @"price":
                                 @"23"}];
    self.offerAnswer = @[
                       @{@"question":
                             @"怎样学习吃饭",
                         @"answer":
                             @"我告诉你你啊，要拿勺子",
                         @"author":
                             @"tom",
                         @"price":
                             @"99"},
                       @{@"question":
                             @"怎样学习喝水",
                         @"answer":
                             @"亲，欢迎您通过以下方式与我",
                         @"author":
                             @"jim",
                         @"price":
                             @"88"},
                       @{@"question":
                             @"怎样学习喝水",
                         @"answer":
                             @"亲，欢迎您通",
                         @"author":
                             @"jim",
                         @"price":
                             @"98"}
                       ];
    self.findArr = @[
                     @{@"question":
                           @"怎样学习吃饭",
                       @"description":
                           @"我告诉你你啊，要拿勺子",
                       @"author":
                           @"tom",
                       @"price":
                           @"5"},
                     @{@"question":
                           @"怎样学习喝水",
                       @"description":
                           @"亲，欢迎您通过以下方式与我",
                       @"author":
                           @"jim",
                       @"price":
                           @"5"},
                     @{@"question":
                           @"怎样学习喝水",
                       @"answer":
                           @"i am a walker",
                       @"author":
                           @"jim",
                       @"price":
                           @"5"}
                     ];
}

@end
