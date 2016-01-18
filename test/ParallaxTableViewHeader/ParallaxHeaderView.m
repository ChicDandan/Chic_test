//
//  ParallaxHeaderView.m
//  ParallaxTableViewHeader
//
//  Created by Vinodh  on 26/10/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.

//

#import <QuartzCore/QuartzCore.h>

#import "ParallaxHeaderView.h"
#import "UIImage+ImageEffects.h"

@interface ParallaxHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (nonatomic) IBOutlet UIImageView *bluredImageView;
@end

#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)

static CGFloat kParallaxDeltaFactor = 0.5f;
static CGFloat kMaxTitleAlphaOffset = 100.0f;

@implementation ParallaxHeaderView

- (void)dealloc
{
    self.imageScrollView.delegate = nil;
}

//--------------------------
+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
{
    ParallaxHeaderView *headerView = [[ParallaxHeaderView alloc] initWithFrame:CGRectMake(0, 0, headerSize.width, headerSize.height)];
    [headerView initialSetupForDefaultHeader];
    return headerView;
}
// ------------------------------------------------

+ (id)parallaxHeaderViewWithSubView:(UIView *)subView
{
    ParallaxHeaderView *headerView = [[ParallaxHeaderView alloc] initWithFrame:CGRectMake(0, 0, subView.frame.size.width, subView.frame.size.height)];
    [headerView initialSetupForCustomSubView:subView];
    return headerView;
}

- (void)awakeFromNib
{
    if (self.subView)
        [self initialSetupForCustomSubView:self.subView];
    else
        [self initialSetupForDefaultHeader];
    
    [self refreshBlurViewForNewImage];
}


- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset
{
    CGRect frame = self.imageScrollView.frame;
    if (offset.y > 0)
    {
        frame.origin.y = MAX(offset.y *kParallaxDeltaFactor, 0);
        self.imageScrollView.frame = frame;
        self.bluredImageView.alpha =   1 / kDefaultHeaderFrame.size.height * offset.y * 2;
        self.clipsToBounds = YES;
    }
    else
    {
        CGFloat delta = 0.0f;
        CGRect rect = kDefaultHeaderFrame;
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.imageScrollView.frame = rect;
        self.clipsToBounds = NO;
        self.headerTitleLabel.alpha = 1 - (delta) * 1 / kMaxTitleAlphaOffset;
    }
}

- (void)refreshBlurViewForNewImage
{
    UIImage *screenShot = [self screenShotOfView:self];
    screenShot = [screenShot applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0.6 alpha:0.2] saturationDeltaFactor:1.0 maskImage:nil];
    self.bluredImageView.image = screenShot;
}

#pragma mark -
#pragma mark Private
// ------------------------------------------------
- (void)initialSetupForDefaultHeader
{
    self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
// ---------------------------------------------//
    self.imageScrollView.delegate = self;
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.showsHorizontalScrollIndicator = NO;
    self.imageScrollView.showsVerticalScrollIndicator = NO;
    self.imageScrollView.alwaysBounceHorizontal = YES;

// ----------------------------------------------//
    
    [self addSubview:self.imageScrollView];
    
}
// --------------------------------------------------------


- (void)initialSetupForCustomSubView:(UIView *)subView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.imageScrollView = scrollView;
    self.subView = subView;
    subView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.imageScrollView addSubview:subView];
    
    self.bluredImageView = [[UIImageView alloc] initWithFrame:subView.frame];
    self.bluredImageView.autoresizingMask = subView.autoresizingMask;
    self.bluredImageView.alpha = 0.0f;
    [self.imageScrollView addSubview:self.bluredImageView];
    
    [self addSubview:self.imageScrollView];
    [self refreshBlurViewForNewImage];
}

- (void)setHeaderImage:(UIImage *)headerImage
{
    _headerImage = headerImage;
}

- (UIImage *)screenShotOfView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(kDefaultHeaderFrame.size, YES, 0.0);
    [self drawViewHierarchyInRect:kDefaultHeaderFrame afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// 将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.imageScrollView) {
        if ([self.delegate respondsToSelector:@selector(beginDragging:)]) {
            [self.delegate beginDragging:self];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger number = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
//    NSLog(@"number === %ld",(long)number);
    if (self.imageScrollView == scrollView) {
        UIImageView * aImageView = (UIImageView *)[scrollView viewWithTag:100 + number];
        [scrollView bringSubviewToFront:aImageView];
        if ([self.delegate respondsToSelector:@selector(didScroll:offset_x:)]) {
            [self.delegate didScroll:self offset_x:scrollView.contentOffset.x];
        }
    }
}


@end
