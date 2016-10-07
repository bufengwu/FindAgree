//
//  FAUtils.h
//  XZ
//
//  Created by mac on 16/7/11.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAUtils : NSObject
+(NSString *) getLabelByName:(NSString *) name;
+ (UIImage *) getImageByName:(NSString *) name;
+ (void) showAllTextDialog:(NSString *)str;
@end
