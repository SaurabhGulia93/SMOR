//
//  SMHistoryViewController.m
//  SMOR
//
//  Created by Saurabh on 5/31/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import "SMHistoryViewController.h"
#import "SMHistoryTableViewCell.h"
#import "MLStyle.h"

#define defaultsKey @"SMORDATA"
#define paidMeals @"PAIDMEALS"
#define redeemedMeals @"REDEEMEDMEALS"
#define paymentHistoryTimeFormat @"dd-MMM-yyyy 'at' HH:mm"

@interface SMHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSDateFormatter *paymentHistoryDateFormatter;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

@end

@implementation SMHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.selectedSegmentIndex = 0;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.selectedSegmentIndex = 0;
    self.segmentControl.selectedSegmentIndex = self.selectedSegmentIndex;
    NSLocale *posixLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];

    
    self.paymentHistoryDateFormatter = [[NSDateFormatter alloc] init];
    [self.paymentHistoryDateFormatter setDateFormat:paymentHistoryTimeFormat];
    [self.paymentHistoryDateFormatter setLocale:posixLocale];

    [self createDataSourceForPaidMeals];
    
}

-(void)createDataSourceForPaidMeals{
    
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    
    NSArray *savedPaidMeals = [self getDataForKey:paidMeals];
    
    if(savedPaidMeals){
        for(NSDictionary *dict in savedPaidMeals){
            NSDate *date = [dict objectForKey:@"date"];
            NSString *price = [dict objectForKey:@"qrValue"];
            NSAttributedString *labelStr = [self attrTextWithPrice:[price containsString:@"$"] ? [NSString stringWithFormat:@"%@", price] : [NSString stringWithFormat:@"$%@", price] dateStr:[self.paymentHistoryDateFormatter stringFromDate:date]];
            
            [mutArr addObject:labelStr];
        }
    }
    mutArr = [[[mutArr reverseObjectEnumerator] allObjects] mutableCopy];
    self.dataSource = [NSArray arrayWithArray:mutArr];
    
    [self.tableView reloadData];
}

-(void)createDataSourceForRedeemedMeals{
    
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    
    NSArray *savedRedeemedMeals = [self getDataForKey:redeemedMeals];
    
    if(savedRedeemedMeals){
        for(NSDictionary *dict in savedRedeemedMeals){
            NSDate *date = [dict objectForKey:@"date"];
            NSString *price = [dict objectForKey:@"qrValue"];
            NSAttributedString *labelStr = [self attrTextForRedeemedMealsWithPrice:[price containsString:@"$"] ? [NSString stringWithFormat:@"%@", price] : [NSString stringWithFormat:@"$%@", price] dateStr:[self.paymentHistoryDateFormatter stringFromDate:date]];
            
            [mutArr addObject:labelStr];
        }
    }
    mutArr = [[[mutArr reverseObjectEnumerator] allObjects] mutableCopy];
    self.dataSource = [NSArray arrayWithArray:mutArr];
    
    [self.tableView reloadData];
}

-(id)getDataForKey:(NSString *)key{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *data = [prefs objectForKey:key];
    return data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SMHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell){
        
        cell = [[SMHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.historyLabel.attributedText = [self.dataSource objectAtIndex:indexPath.row];
    cell.smoredImage.hidden = NO;
    
    if(self.selectedSegmentIndex == 1){
        cell.smoredImage.hidden = YES;
    }
    
    return cell;
}

- (NSAttributedString *)attrTextWithPrice:(NSString *)price dateStr:(NSString *)dateStr
{
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    
    NSMutableParagraphStyle *mainStyle = [[NSMutableParagraphStyle alloc] init];
    mainStyle.alignment = NSTextAlignmentLeft;
    mainStyle.paragraphSpacing = 4;
    
//    NSDictionary *headerTitleDict3 = @{NSFontAttributeName : REGULAR(17),
//                                       NSForegroundColorAttributeName : kDarkerGrayFontColor,
//                                       NSParagraphStyleAttributeName : mainStyle
//                                       };
    
    NSDictionary *headerTitleDict2 = @{NSFontAttributeName : REGULAR(17),
                                       NSForegroundColorAttributeName : kBlackFontColor,
                                       NSParagraphStyleAttributeName : mainStyle
                                       };
    
    NSDictionary *headerTitleDict1 = @{NSFontAttributeName : REGULAR(12),
                                       NSForegroundColorAttributeName : kLightGrayColor,
                                       NSParagraphStyleAttributeName : mainStyle
                                       };
    
    
    NSAttributedString *headerAttr1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"Bill Paid: "] attributes:headerTitleDict2];
    [attStr appendAttributedString:headerAttr1];
    
    NSAttributedString *headerAttr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",price] attributes:headerTitleDict2];
    [attStr appendAttributedString:headerAttr2];
    
    NSAttributedString *headerAttr3 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", dateStr] attributes:headerTitleDict1];
    [attStr appendAttributedString:headerAttr3];
    
    
    return [[NSAttributedString alloc] initWithAttributedString:attStr];
}

- (NSAttributedString *)attrTextForRedeemedMealsWithPrice:(NSString *)price dateStr:(NSString *)dateStr
{
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    
    NSMutableParagraphStyle *mainStyle = [[NSMutableParagraphStyle alloc] init];
    mainStyle.alignment = NSTextAlignmentLeft;
    mainStyle.paragraphSpacing = 4;
    
    //    NSDictionary *headerTitleDict3 = @{NSFontAttributeName : REGULAR(17),
    //                                       NSForegroundColorAttributeName : kDarkerGrayFontColor,
    //                                       NSParagraphStyleAttributeName : mainStyle
    //                                       };
    
    NSDictionary *headerTitleDict2 = @{NSFontAttributeName : REGULAR(17),
                                       NSForegroundColorAttributeName : kBlackFontColor,
                                       NSParagraphStyleAttributeName : mainStyle
                                       };
    
    NSDictionary *headerTitleDict1 = @{NSFontAttributeName : REGULAR(12),
                                       NSForegroundColorAttributeName : kLightGrayColor,
                                       NSParagraphStyleAttributeName : mainStyle
                                       };
    
    
    NSAttributedString *headerAttr1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"Redeemed Meal: "] attributes:headerTitleDict2];
    [attStr appendAttributedString:headerAttr1];
    
    NSAttributedString *headerAttr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",price] attributes:headerTitleDict2];
    [attStr appendAttributedString:headerAttr2];
    
    NSAttributedString *headerAttr3 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", dateStr] attributes:headerTitleDict1];
    [attStr appendAttributedString:headerAttr3];
    
    
    return [[NSAttributedString alloc] initWithAttributedString:attStr];
}


- (IBAction)segmentControlTapped:(UISegmentedControl *)sender {

    self.selectedSegmentIndex = sender.selectedSegmentIndex;
    if(sender.selectedSegmentIndex == 0){
        [self createDataSourceForPaidMeals];
    }else if (sender.selectedSegmentIndex == 1){
        [self createDataSourceForRedeemedMeals];
    }
}

@end
