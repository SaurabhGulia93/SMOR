//
//  SMStampViewController.h
//  SMOR
//
//  Created by Saurabh on 7/1/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMStampViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger cellCount;

@end
