//
//  SMStampViewController.m
//  SMOR
//
//  Created by Saurabh on 7/1/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import "SMStampViewController.h"

#import "CircleLayout.h"
#import "Cell.h"


@interface SMStampViewController ()

@end

@implementation SMStampViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellCount = 10;
    
    // register our custom Cell
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"Cell"];
    
    // add gesture recognizers
    //    UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    //    [self.collectionView addGestureRecognizer:tapRecognizer];
    
    // set background color
    //    self.collectionView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    self.collectionView.backgroundColor = [UIColor blueColor];
    
    [self.collectionView reloadData];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
