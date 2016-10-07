//
//  FASliderDelegate.h
//  FindAgree
//
//  Created by mac on 16/8/5.
//  Copyright © 2016年 罗辑. All rights reserved.
//

#ifndef FASliderDelegate_h
#define FASliderDelegate_h


@protocol SliderDelegate <NSObject>

- (void) addPan;
- (void) removePan;
- (void) changeLeftSlider;

@end

#endif /* FASliderDelegate_h */
