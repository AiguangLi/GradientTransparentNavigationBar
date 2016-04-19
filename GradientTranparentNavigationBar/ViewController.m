//
//  ViewController.m
//  GradientTranparentNavigationBar
//
//  Created by Aiguang Li on 16/4/19.
//  Email: Aiguang.Li@gmail.com
//  Github: https://github.com/AiguangLi/
//  Copyright © 2016年 mooeen. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Part.h"
#import "VisualFormatLayout.h"

#define kNavigationAndStatusBarHeihght 64
#define kBannerImageName @"banner.jpg"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) UILabel *viewInfoLabel;

@property (nonatomic, strong) UIView *customNavigationBar;
@property (nonatomic, strong) UIImageView *navigationBangroundImageView;
@property (nonatomic, strong) UILabel *navigationTitle;
@property (nonatomic, strong) UIButton *infoButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buldScrollView];
    [self buildNavigationBar];
}

-(void) buldScrollView
{
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    NSDictionary *views = NSDictionaryOfVariableBindings(_scrollView);
    NSArray *visualFormats = @[@"H:|[_scrollView]|",
                               @"V:|[_scrollView]|"
                               ];
    [VisualFormatLayout autoLayout:self.view visualFormats:visualFormats metrics:nil views:views];
    
    _bannerImageView = [[UIImageView alloc]init];
    _bannerImageView.contentMode = UIViewContentModeScaleToFill;
    UIImage *bannerImage = [UIImage imageNamed:@"banner.jpg"];
    _bannerImageView.image = bannerImage;
    [_scrollView addSubview:_bannerImageView];
    
    _viewInfoLabel = [[UILabel alloc]init];
    _viewInfoLabel.text = @"Gradient Tranparent Bar Demo. " \
                          @"This demo shows how to build a grandient transparent navigation bar";
    _viewInfoLabel.numberOfLines = 0;
    _viewInfoLabel.textColor = [UIColor whiteColor];
    _viewInfoLabel.textAlignment = NSTextAlignmentCenter;
    _viewInfoLabel.font = [UIFont systemFontOfSize:16.0];
    [_scrollView addSubview:_viewInfoLabel];
    
    CGSize bannerImageSize = bannerImage.size;
    CGFloat bannerImageViewHeight = self.view.frame.size.width / bannerImageSize.width * bannerImageSize.height;
    NSDictionary *metrics = @{@"HB":@(bannerImageViewHeight)};
    views = NSDictionaryOfVariableBindings(_scrollView, _bannerImageView, _viewInfoLabel);
    visualFormats = @[@"H:|[_bannerImageView(==_scrollView)]|",
                      @"H:|-[_viewInfoLabel]-|",
                      //Add 1000 to make scroll content size larger enough to scroll
                      @"V:|-[_viewInfoLabel(==HB)]",
                      @"V:|[_bannerImageView(==HB)]-1000-|"
                      ];
    [VisualFormatLayout autoLayout:_scrollView visualFormats:visualFormats metrics:metrics views:views];
}

-(void) buildNavigationBar
{
    _customNavigationBar = [[UIView alloc]init];
    [self.view addSubview:_customNavigationBar];
    NSDictionary *views = NSDictionaryOfVariableBindings(_customNavigationBar);
    NSDictionary *metrics = @{@"HN":@(kNavigationAndStatusBarHeihght)};
    NSArray *visualFormats = @[@"H:|[_customNavigationBar]|",
                               @"V:|[_customNavigationBar(==HN)]"
                               ];
    [VisualFormatLayout autoLayout:self.view visualFormats:visualFormats metrics:metrics views:views];
    
    _navigationBangroundImageView = [[UIImageView alloc]init];
    _navigationBangroundImageView.contentMode = UIViewContentModeScaleToFill;
    UIImage *bannerImage = [UIImage imageNamed:@"banner.jpg"];
    CGSize bannerImageSize = bannerImage.size;
    CGFloat bannerNavBGImageHeight = bannerImageSize.width / self.view.frame.size.width * kNavigationAndStatusBarHeihght;
    CGRect navigationBackroundImageRect = CGRectMake(0, 0, bannerImageSize.width, bannerNavBGImageHeight);
    UIImage *bannerNavBGImage = [bannerImage partImageInRect:navigationBackroundImageRect];
    _navigationBangroundImageView.image = bannerNavBGImage;
    [_customNavigationBar addSubview:_navigationBangroundImageView];
    
    _navigationTitle = [[UILabel alloc]init];
    _navigationTitle.text = @"Gradient Tranparent Bar";
    _navigationTitle.textColor = [UIColor whiteColor];
    _navigationTitle.textAlignment = NSTextAlignmentCenter;
    _navigationTitle.font = [UIFont systemFontOfSize:18.0];
    [_customNavigationBar addSubview:_navigationTitle];
    
    _infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [_infoButton addTarget:self action:@selector(doInfoButton:) forControlEvents:UIControlEventTouchUpInside];
    [_customNavigationBar addSubview:_infoButton];
    
    views = NSDictionaryOfVariableBindings(_navigationBangroundImageView, _navigationTitle, _infoButton);
    metrics = @{@"WB":@(34)};
    visualFormats =  @[@"H:|[_navigationBangroundImageView]|",
                       @"H:|-WB-[_navigationTitle]-[_infoButton(==WB)]-|",
                       @"V:|[_navigationBangroundImageView]|",
                       @"V:|-[_navigationTitle]-|",
                       @"V:|-[_infoButton]-|"
                       ];
    [VisualFormatLayout autoLayout:_customNavigationBar visualFormats:visualFormats metrics:metrics views:views];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat threholdHeight = _bannerImageView.frame.size.height - kNavigationAndStatusBarHeihght;
    if(scrollView.contentOffset.y >= 0 &&
       scrollView.contentOffset.y <= threholdHeight) {
        CGFloat alpha = scrollView.contentOffset.y / threholdHeight;
        _customNavigationBar.alpha = alpha;
    }
    else if(scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    else {
        _customNavigationBar.alpha = 1.0;
    }
}

-(void) doInfoButton:(id)sender
{
    NSLog(@"Information Button Touched!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
