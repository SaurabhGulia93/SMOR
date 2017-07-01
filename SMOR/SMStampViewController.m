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
#import "MLStyle.h"

#define defaultsKey @"SMORDATA"

@interface SMStampViewController ()

@property (nonatomic, assign) NSInteger savedMeals;

@end

@implementation SMStampViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellCount = 10;
    
    // register our custom Cell
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"Cell"];
    
    // set background color
    //    self.collectionView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
//    self.collectionView.backgroundColor = [UIColor yellowColor];
    
    NSNumber *savedMeals = [self getDataForKey:defaultsKey];
    
    self.savedMeals = savedMeals ? savedMeals.integerValue : 0;
    self.savedMeals = 9;
//    [self createDataSource:savedMealsValue];

    
    [self.collectionView reloadData];

}

-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    self.collectionView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
}


-(id)getDataForKey:(NSString *)key{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *data = [prefs objectForKey:key];
    return data;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if(indexPath.item < self.savedMeals) {
        cell.smored = true;
    }else{
        cell.smored = false;
    }
    cell.labelTextTag = indexPath.item + 1;
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
