//
//  CreateButtonView.h
//  Chic_Second
//
//  Created by apple on 15/11/27.
//  Copyright © 2015年 xike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateButtonView : UIView

/**
 create button By array and buttonCount
 */
- (void)addButtonBy:(NSArray *)buttonArray count:(NSInteger)count backgroundcolor:(UIColor *)backgroundcolor font:(UIFont *)font titleColor:(UIColor *)titleColor;


@end
