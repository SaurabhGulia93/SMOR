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
#define paymentHistoryTimeFormat @"dd-MMM-yyyy"

@interface SMHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSDateFormatter *paymentHistoryDateFormatter;


@end

@implementation SMHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLocale *posixLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];

    
    self.paymentHistoryDateFormatter = [[NSDateFormatter alloc] init];
    [self.paymentHistoryDateFormatter setDateFormat:paymentHistoryTimeFormat];
    [self.paymentHistoryDateFormatter setLocale:posixLocale];

    
    NSNumber *savedMeals = [self getDataForKey:defaultsKey];
    
    NSInteger savedMealsValue = savedMeals ? savedMeals.integerValue : 0;

    [self createDataSource:savedMealsValue];
    
}

-(void) createDataSource:(NSInteger)savedMeals{
    
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 1; i <= savedMeals; i++) {
        
        NSDictionary *dict = [self getDataForKey:[NSString stringWithFormat:@"%ld",(long)i]];
        NSDate *date = [dict objectForKey:@"date"];
        NSString *price = [dict objectForKey:@"qrValue"];
        
        NSAttributedString *labelStr = [self attrTextWithPrice:[NSString stringWithFormat:@"$%@", price] dateStr:[self.paymentHistoryDateFormatter stringFromDate:date]];
        
        [mutArr addObject:labelStr];
    }
    
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

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
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




@end
