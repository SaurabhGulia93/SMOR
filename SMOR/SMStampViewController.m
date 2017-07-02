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
    
    self.title = @"Loyalty Stamps";
    
    // register our custom Cell
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.userInteractionEnabled = NO;

    // set background color
    //    self.collectionView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
//    self.collectionView.backgroundColor = [UIColor yellowColor];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSNumber *savedMeals = [self getDataForKey:defaultsKey];
    
    self.savedMeals = savedMeals ? savedMeals.integerValue : 0;
    //    self.savedMeals = 4;
    
    [self.collectionView reloadData];
    
    self.label.attributedText = [self attrTextForHeaderView:self.savedMeals];
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

- (NSAttributedString *)attrTextForHeaderView:(NSInteger)points
{
    NSInteger savedPoints = points * 10;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    
    NSMutableParagraphStyle *mainStyle = [[NSMutableParagraphStyle alloc] init];
    mainStyle.alignment = NSTextAlignmentCenter;
    mainStyle.paragraphSpacing = 4;
    
    NSDictionary *headerTitleDict2 = @{NSFontAttributeName : REGULAR(17),
                                       NSForegroundColorAttributeName : kDarkerGrayFontColor,
                                       NSParagraphStyleAttributeName : mainStyle
                                       };
    
    NSDictionary *headerTitleDict1 = @{NSFontAttributeName : REGULAR(12),
                                       NSForegroundColorAttributeName : kDarkerGrayFontColor,
                                       NSParagraphStyleAttributeName : mainStyle
                                       };
    
    
//    NSAttributedString *headerAttr1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  :  ", @"Earned Loyalty Points"] attributes:headerTitleDict2];
//    [attStr appendAttributedString:headerAttr1];
//    
//    NSAttributedString *headerAttr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld",(long)savedPoints] attributes:headerTitleDict2];
//    [attStr appendAttributedString:headerAttr2];
    
    if(savedPoints >= 100){
        
        NSAttributedString *headerAttr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"You can now redeem a free meal"] attributes:headerTitleDict2];
        [attStr appendAttributedString:headerAttr2];
        
        
    }else{
        
        NSAttributedString *headerAttr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"You can redeem a free meal once you earn 10 loyalty stamps"] attributes:headerTitleDict2];
        [attStr appendAttributedString:headerAttr2];
        
    }
    
    return [[NSAttributedString alloc] initWithAttributedString:attStr];
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
        cell.alpha = 1;
    }else{
        cell.smored = false;
        cell.alpha = 0.5;
    }
    cell.labelTextTag = indexPath.item + 1;
    [cell setNeedsDisplay];
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
