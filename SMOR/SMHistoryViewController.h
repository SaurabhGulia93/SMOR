//
//  SMHistoryViewController.h
//  SMOR
//
//  Created by Saurabh on 5/31/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)segmentControlTapped:(UISegmentedControl *)sender;

@end
