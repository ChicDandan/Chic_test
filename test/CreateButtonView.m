//
//  CreateButtonView.m
//  Chic_Second
//
//  Created by apple on 15/11/27.
//  Copyright © 2015年 xike. All rights reserved.
//

#import "CreateButtonView.h"

#define KHorizontal_Space 15
#define KVertical_Space 15

@interface CreateButtonView ()


@end

@implementation CreateButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)addButtonBy:(NSArray *)buttonArray count:(NSInteger)count backgroundcolor:(UIColor *)backgroundcolor font:(UIFont *)font titleColor:(UIColor *)titleColor
{
    CGFloat buttonWidth = (self.frame.size.width - (count + 1) * KHorizontal_Space) / count;
    CGFloat buttonHeight;
    if (buttonArray.count % 5 == 0) {
        buttonHeight = (self.frame.size.height - (buttonArray.count / 5 + 1) * KVertical_Space) / (buttonArray.count / 5);
    } else {
        buttonHeight = (self.frame.size.height - (buttonArray.count / 5 + 2) * KVertical_Space) / (buttonArray.count / 5 + 1);
    }
    for (int i = 0; i < buttonArray.count; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((i % count + 1) * KHorizontal_Space + i % count * buttonWidth, (i / count + 1) * KVertical_Space + i / count * buttonHeight, buttonWidth, buttonHeight);
        button.backgroundColor = backgroundcolor;
        [button setTitle:buttonArray[i] forState:UIControlStateNormal];
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        button.titleLabel.font = font;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 6.f;
        [self addSubview:button];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
