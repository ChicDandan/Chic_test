//
//  ViewController.m
//  test
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 xike. All rights reserved.
//

#import "ViewController.h"
#import "ParallaxHeaderView.h"
#import "MyTopImageView.h"
#import "UIImage+Effects.h"
#import "CreateButtonView.h"

#import <CoreGraphics/CoreGraphics.h>
#import <CoreImage/CoreImage.h>

#define KScreen_Rect [UIScreen mainScreen].bounds
#define KHeaderView_Height 60
#define KTopImageView_Height 286
#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define RGB_COLOR(R, G, B, A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]


@interface ViewController ()

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)ParallaxHeaderView *topView;
@property (nonatomic, strong)MyTopImageView *topImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB_COLOR(236, 236, 239, 1.0);
    
    
//    [self.view addSubview:self.tableView];
    
    [self addView];
}

- (void)addView
{
    NSArray * buttonArray = [NSArray arrayWithObjects:@"大叔",@"潮男",@"英伦",@"学院",@"型男",@"儒雅",@"复古", nil];
    CreateButtonView * aView = [[CreateButtonView alloc] initWithFrame:CGRectMake(35, 120, 260, 80)];
    aView.backgroundColor = [UIColor redColor];
    [aView addButtonBy:buttonArray count:5 backgroundcolor:[UIColor greenColor] font:[UIFont systemFontOfSize:13.f] titleColor:[UIColor whiteColor]];
    [self.view addSubview:aView];
    
    UILabel * aLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 280, 100, 50)];
    aLabel.backgroundColor = [UIColor whiteColor];
//    aLabel.borderStyle = UITextBorderStyleLine;
    aLabel.layer.borderWidth= 1.0f;
    aLabel.layer.borderColor=[[UIColor orangeColor] CGColor];
    //    aLabel.numberOfLines = 0;
    aLabel.text = @"college";
    [self.view addSubview:aLabel];
    
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(60, 100, 120, 60);
//    [button setImage:[UIImage imageNamed:@"屌丝逆袭Dream.png"] forState:UIControlStateNormal];
//    [button setTitle:@"nihao" forState:UIControlStateNormal];
//    [self.view addSubview:button];
////    button.backgroundColor = [UIColor orangeColor];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 10);
//    button.imageEdgeInsets = UIEdgeInsetsMake(30, 30, 15, 30);
    
    
    
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView setTableHeaderView:self.topView];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (MyTopImageView *)topImageView
{
    if (!_topImageView) {
        self.topImageView = [[MyTopImageView alloc] initWithFrame:CGRectMake(0, 0, KScreen_Rect.size.width,  KTopImageView_Height)];
        _topImageView.image = [[UIImage imageNamed:@"imageMe"] applyBlurWithRadius:20.f tintColor:[UIColor colorWithWhite:0.f alpha:0.f] saturationDeltaFactor:1.4 maskImage:nil];
        [_topImageView.button setBackgroundImage:[UIImage imageNamed:@"屌丝逆袭Dream.png"] forState:UIControlStateNormal];
        _topImageView.delegate = self;
    }
    return _topImageView;
}



- (ParallaxHeaderView *)topView
{
    if (!_topView) {
        self.topView = [ParallaxHeaderView parallaxHeaderViewWithImage:nil forSize:CGSizeMake(KScreen_Rect.size.width, KTopImageView_Height)];
        _topView.imageScrollView.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KTopImageView_Height);
        [_topView.imageScrollView addSubview:self.topImageView];
        _topView.imageScrollView.contentSize = CGSizeMake(KScreen_Rect.size.width, KTopImageView_Height);
        _topView.imageScrollView.alwaysBounceHorizontal = NO; // 水平方向是否反弹
        _topView.backgroundColor = [UIColor redColor];
    }
    return _topView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.textColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
    cell.textLabel.text = [NSString stringWithFormat:@"%u",arc4random() % 1000 + 10000];
    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        [self.topView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}

- (void)entryMyDetailPage
{
    self.topImageView.button.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
}

#pragma mark - 模糊效果


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
