//
//  Cell.h
//  CollectionViewLayouts
//
//  Created by Ramon Bartl on 25.05.13.
//  Copyright (c) 2013 Ramon Bartl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UICollectionViewCell

@property (nonatomic, assign) BOOL smored;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) NSInteger labelTextTag;
@property (nonatomic, strong) UIImageView *smorImageView;

@end
