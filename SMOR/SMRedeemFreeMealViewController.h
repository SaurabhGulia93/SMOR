//
//  SMRedeemFreeMealViewController.h
//  SMOR
//
//  Created by Saurabh on 5/31/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMRedeemFreeMealViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *redeemButton;
- (IBAction)redeemButtonTapped:(UIButton *)sender;

@end
