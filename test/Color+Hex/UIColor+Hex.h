//
//  UIColor+Hex.h
//  Chic
//
//  Created by Apple on 15/12/15.
//  Copyright © 2015年 Miss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;

@end
