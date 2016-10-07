//
//  FAsortBoxViewController.h
//  FindAgree
//
//  Created by mac on 16/8/8.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoPushedViewDelegate <NSObject>

- (void) goMyAnswer;
- (void) goMyQuestion;

@end


@interface FAsortBoxViewController : NSObject

@property (nonatomic, weak) id<GoPushedViewDelegate> delegate;

+ (instancetype)sharedInstance;
- (void) showView;
@end
