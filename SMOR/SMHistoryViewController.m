//
//  SMHistoryViewController.m
//  SMOR
//
//  Created by Saurabh on 5/31/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import "SMHistoryViewController.h"
#import "SMHistoryTableViewCell.h"

#define DefaultsKey @"SMORDATA"

@interface SMHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SMHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SMHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell){
        
        cell = [[SMHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    return cell;
}



@end
