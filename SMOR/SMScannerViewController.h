//
//  SMScannerViewController.h
//  SMOR
//
//  Created by Saurabh on 5/31/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMScannerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *captureView;
@property (weak, nonatomic) IBOutlet UIView *permissionView;
@property (weak, nonatomic) IBOutlet UIButton *permissionButton;
- (IBAction)grantPermission:(UIButton *)sender;
@property (nonatomic, assign) BOOL redeem6Off;
@property (nonatomic, assign) BOOL redeem12Off;
@end
