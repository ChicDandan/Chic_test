//
//  MyHeaderImageView.m
//  ChicMe
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 xike. All rights reserved.
//

#import "MyTopImageView.h"

#define KButton_Size 100
#define KSpace 30
#define KTitleLabel_Height 40

@interface MyTopImageView ()

@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation MyTopImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        self.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.button];
        [self addSubview:self.titleLabel];
    }
    return self;
}


- (UIButton *)button
{
    if (!_button) {
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake((CGRectGetWidth(self.frame) - KButton_Size) / 2, (CGRectGetHeight(self.frame) - KButton_Size) / 5, KButton_Size, KButton_Size);
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = KButton_Size / 2;
        [_button addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
        _button.backgroundColor = [UIColor whiteColor];
    }
    return _button;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.button.frame) + KSpace, [UIScreen mainScreen].bounds.size.width, KTitleLabel_Height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (void)setButtonBackgroundImage:(UIImage *)buttonBackgroundImage
{
    _buttonBackgroundImage = buttonBackgroundImage;
    [self.button setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)doClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(entryMyDetailPage)]) {
        [_delegate entryMyDetailPage];
    }
}

@end
