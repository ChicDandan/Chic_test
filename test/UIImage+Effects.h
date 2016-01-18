//
//  UIImage+Effects.h
//  test
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 xike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Effects)
/**
 Radius 半径圈 
 tintColor 色彩
 saturationDeltaFactor 饱和度
 maskImage 背景图片
 */
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;
@end
