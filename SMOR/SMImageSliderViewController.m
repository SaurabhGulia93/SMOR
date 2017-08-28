//
//  SMImageSliderViewController.m
//  SMOR
//
//  Created by Saurabh on 5/31/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import "SMImageSliderViewController.h"
#import "MLStyle.h"
#import "SBSliderView.h"


@interface SMImageSliderViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imagesArr;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation SMImageSliderViewController{
    BOOL autoSrcollEnabled;
    NSTimer *activeTimer;
    SBSliderView *slider;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.opening.textColor = kWhiteColor;
    self.time1.textColor = kWhiteColor;
    self.time2.textColor = kWhiteColor;
    self.address.textColor = kWhiteColor;
    self.address2.textColor = kWhiteColor;
    
    self.opening2.textColor = kWhiteColor;
    self.time3.textColor = kWhiteColor;
    self.time4.textColor = kWhiteColor;
    self.address3.textColor = kWhiteColor;
    self.address4.textColor = kWhiteColor;
    
    _pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:self.pageControl];
    
    self.imagesArr = [[NSMutableArray alloc] initWithObjects:@"slide1", @"slide2", @"slide3", nil];
    
    _pageControl.numberOfPages = _imagesArr.count;
    
    autoSrcollEnabled = true;
    
    self.view.backgroundColor = kBlackFontColor;
    
//    _sliderScrollView.backgroundColor = kBlueColor;
    _sliderScrollView.pagingEnabled = YES;
    _sliderScrollView.delegate = self;
    _sliderScrollView.contentSize = CGSizeMake((_sliderScrollView.frame.size.width * [_imagesArr count] * 3), _sliderScrollView.frame.size.height);
    
    int mainCount = 0;
    for (int x = 0; x < 3; x++) {
    
        for (int i=0; i < [_imagesArr count]; i++) {
            
            UIImageView *imageV = [[UIImageView alloc] init];
            imageV.backgroundColor = [UIColor clearColor];
            imageV.image = [UIImage imageNamed:(NSString *)[_imagesArr objectAtIndex:i]];
            CGRect frameRect;
            frameRect.origin.y = 0.0f;
            frameRect.size.width = _sliderScrollView.frame.size.width;
            frameRect.size.height = _sliderScrollView.frame.size.height;
            frameRect.origin.x = (frameRect.size.width * mainCount);
            imageV.frame = frameRect;
            imageV.contentMode = UIViewContentModeTop;
            [_sliderScrollView addSubview:imageV];
            imageV.clipsToBounds = YES;
            imageV.userInteractionEnabled = YES;
            
            mainCount++;
        }
        
    }
    
    CGFloat startX = (CGFloat)[_imagesArr count] * [UIScreen mainScreen].bounds.size.width;
    [_sliderScrollView setContentOffset:CGPointMake(startX, 0) animated:NO];
    [self startAutoPlay];
    
    self.pageControl.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - _pageControl.frame.size.width)/2, _sliderScrollView.frame.size.height - 35, _pageControl.frame.size.width, _pageControl.frame.size.height);
    
    
//    self.sliderScrollView.hidden = true;
    
//    slider = [[[NSBundle mainBundle] loadNibNamed:@"SBSliderView" owner:self options:nil] firstObject];
//    slider.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
//    [self.view addSubview:slider];
//    slider.backgroundColor = kBlackFontColor;
//    [slider createSliderWithImages:_imagesArr WithAutoScroll:true inView:self.view];

//    _pageControl.frame = CGRectMake(_pageControl.frame.origin.x, slider.frame.size.height, _pageControl.frame.size.width, _pageControl.frame.size.height);

    
    // Do any additional setup after loading the view.
}

-(void)viewWillLayoutSubviews{
    
    
}


#pragma mark - UIScrollView delegate

#pragma mark - UIScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    
    NSInteger moveToPage = page;
    if (moveToPage == 0) {
        
        moveToPage = [_imagesArr count];
        CGFloat startX = (CGFloat)moveToPage * [UIScreen mainScreen].bounds.size.width;
        [scrollView setContentOffset:CGPointMake(startX, 0) animated:NO];
        
    } else if (moveToPage == (([_imagesArr count] * 3) - 1)) {
        
        moveToPage = [_imagesArr count] - 1;
        CGFloat startX = (CGFloat)moveToPage * [UIScreen mainScreen].bounds.size.width;
        [scrollView setContentOffset:CGPointMake(startX, 0) animated:NO];
        
    }
    
    if (moveToPage < [_imagesArr count]) {
        _pageControl.currentPage = moveToPage;
    } else {
        
        moveToPage = moveToPage % [_imagesArr count];
        _pageControl.currentPage = moveToPage;
    }
    if (([_imagesArr count] > 1) && (autoSrcollEnabled)) {
        [self startTimerThread];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    
    NSInteger moveToPage = page;
    if (moveToPage == 0) {
        
        moveToPage = [_imagesArr count];
        CGFloat startX = (CGFloat)moveToPage * [UIScreen mainScreen].bounds.size.width;
        [scrollView setContentOffset:CGPointMake(startX, 0) animated:NO];
        
    } else if (moveToPage == (([_imagesArr count] * 3) - 1)) {
        
        moveToPage = [_imagesArr count] - 1;
        CGFloat startX = (CGFloat)moveToPage * [UIScreen mainScreen].bounds.size.width;
        [scrollView setContentOffset:CGPointMake(startX, 0) animated:NO];
        
    }
    
    if (moveToPage < [_imagesArr count]) {
        _pageControl.currentPage = moveToPage;
    } else {
        
        moveToPage = moveToPage % [_imagesArr count];
        _pageControl.currentPage = moveToPage;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (activeTimer) {
        [activeTimer invalidate];
        activeTimer = nil;
    }
}

#pragma mark end -

- (void)slideImage {
    
    CGFloat startX = 0.0f;
    CGFloat width = _sliderScrollView.frame.size.width;
    NSInteger page = (_sliderScrollView.contentOffset.x + (0.5f * width)) / width;
    NSInteger nextPage = page + 1;
    startX = (CGFloat)nextPage * width;
    //    [_sliderMainScroller scrollRectToVisible:CGRectMake(startX, 0, width, _sliderMainScroller.frame.size.height) animated:YES];
    [_sliderScrollView setContentOffset:CGPointMake(startX, 0) animated:YES];
}

-(void)startTimerThread
{
    if (activeTimer) {
        [activeTimer invalidate];
        activeTimer = nil;
    }
    activeTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(slideImage) userInfo:nil repeats:YES];
}

-(void)startAutoPlay
{
    autoSrcollEnabled = YES;
    if (([_imagesArr count] > 1) && (autoSrcollEnabled)) {
        [self startTimerThread];
    }
}

-(void)stopAutoPlay
{
    autoSrcollEnabled = NO;
    if (activeTimer) {
        [activeTimer invalidate];
        activeTimer = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
