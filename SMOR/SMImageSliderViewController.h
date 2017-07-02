//
//  SMImageSliderViewController.h
//  SMOR
//
//  Created by Saurabh on 5/31/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMImageSliderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *sliderScrollView;
@property (weak, nonatomic) IBOutlet UILabel *opening;
@property (weak, nonatomic) IBOutlet UILabel *time1;
@property (weak, nonatomic) IBOutlet UILabel *time2;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *address2;

@end
