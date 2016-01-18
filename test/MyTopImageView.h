//
//  MyHeaderImageView.h
//  ChicMe
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 xike. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTopImageViewDelegate <NSObject>

- (void)entryMyDetailPage;

@end

@interface MyTopImageView : UIImageView

@property (nonatomic, strong)UIImage *buttonBackgroundImage;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, weak)id<MyTopImageViewDelegate> delegate;

@end
