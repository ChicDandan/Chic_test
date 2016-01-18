//
//  ParallaxHeaderView.h
//  ParallaxTableViewHeader
//
//  Created by Vinodh  on 26/10/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.

//

#import <UIKit/UIKit.h>

@class ParallaxHeaderView;
@protocol ParallaxHeaderViewDelegate <NSObject>

@optional
- (void)beginDragging:(ParallaxHeaderView *)parallaxHeaderView;
- (void)didScroll:(ParallaxHeaderView *)parallaxHeaderView offset_x:(CGFloat)offset_x;


@end

@interface ParallaxHeaderView : UIView<UIScrollViewDelegate>
@property (nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (nonatomic) UIImage *headerImage;
@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (nonatomic, assign) id<ParallaxHeaderViewDelegate> delegate;
@property (nonatomic, assign) BOOL isModelDetail;


//@property (nonatomic, strong)UIScrollView 

+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
+ (id)parallaxHeaderViewWithSubView:(UIView *)subView;
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;
- (void)refreshBlurViewForNewImage;
@end
