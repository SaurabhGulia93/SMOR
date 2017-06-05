//
//  SMImageSliderViewController.m
//  SMOR
//
//  Created by Saurabh on 5/31/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import "SMImageSliderViewController.h"
#import "MLStyle.h"

@interface SMImageSliderViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imagesArr;

@end

@implementation SMImageSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagesArr = [[NSMutableArray alloc] initWithObjects:@"sm1.jpg", @"sm2.jpg", @"sm3.jpg", nil];
    
    _sliderScrollView.backgroundColor = kBlackFontColor;
    _sliderScrollView.pagingEnabled = YES;
    _sliderScrollView.delegate = self;
    _pageControl.numberOfPages = [_imagesArr count];
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
            imageV.contentMode = UIViewContentModeScaleAspectFit;
            [_sliderScrollView addSubview:imageV];
            imageV.clipsToBounds = YES;
            imageV.userInteractionEnabled = YES;
            
            mainCount++;
        }
        
    }
    
    CGFloat startX = (CGFloat)[_imagesArr count] * [UIScreen mainScreen].bounds.size.width;
    [_sliderScrollView setContentOffset:CGPointMake(startX, 0) animated:NO];
    
    // Do any additional setup after loading the view.
}

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
//    if (([_imagesArr count] > 1) && (autoSrcollEnabled)) {
//        [self startTimerThread];
//    }
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
    
//    if (activeTimer) {
//        [activeTimer invalidate];
//        activeTimer = nil;
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
