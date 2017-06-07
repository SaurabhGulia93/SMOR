//
//  SMRedeemFreeMealViewController.m
//  SMOR
//
//  Created by Saurabh on 5/31/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import "SMRedeemFreeMealViewController.h"
#import "MLStyle.h"

#define defaultsKey @"SMORDATA"

@interface SMRedeemFreeMealViewController ()

@property (nonatomic, assign) NSInteger savedMeals;

@end

@implementation SMRedeemFreeMealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.redeemButton.backgroundColor = kBlueColor;
    [self.redeemButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    self.redeemButton.layer.cornerRadius = 4;
    self.redeemButton.layer.masksToBounds = true;
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self updateUI];
}

-(void)updateUI{
    
    NSNumber *savedMeals = [self getDataForKey:defaultsKey];
    
    NSInteger savedMealsValue = savedMeals ? savedMeals.integerValue : 0;
    
    self.savedMeals = savedMealsValue;
    
    self.label.attributedText = [self attrTextForHeaderView:savedMealsValue];
}

- (NSAttributedString *)attrTextForHeaderView:(NSInteger)points
{
    NSInteger savedPoints = points * 10;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    
    NSMutableParagraphStyle *mainStyle = [[NSMutableParagraphStyle alloc] init];
    mainStyle.alignment = NSTextAlignmentCenter;
    mainStyle.paragraphSpacing = 4;
    
    NSDictionary *headerTitleDict2 = @{NSFontAttributeName : REGULAR(17),
                                       NSForegroundColorAttributeName : kBlackFontColor,
                                       NSParagraphStyleAttributeName : mainStyle
                                       };
    
    NSDictionary *headerTitleDict1 = @{NSFontAttributeName : REGULAR(12),
                         NSForegroundColorAttributeName : kLightGrayColor,
                         NSParagraphStyleAttributeName : mainStyle
                         };

    
    NSAttributedString *headerAttr1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  :  ", @"Earned Loyalty Points"] attributes:headerTitleDict2];
    [attStr appendAttributedString:headerAttr1];

    NSAttributedString *headerAttr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld",(long)savedPoints] attributes:headerTitleDict2];
    [attStr appendAttributedString:headerAttr2];

    if(savedPoints >= 100){
        
        NSAttributedString *headerAttr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", @"You can now redeem a free meal"] attributes:headerTitleDict1];
        [attStr appendAttributedString:headerAttr2];

        
    }else{
        
        NSAttributedString *headerAttr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", @"You can redeem a free meal once you earn 100 loyalty points"] attributes:headerTitleDict1];
        [attStr appendAttributedString:headerAttr2];
        
    }
    
    return [[NSAttributedString alloc] initWithAttributedString:attStr];
}


-(NSNumber *)getDataForKey:(NSString *)key{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *data = [prefs objectForKey:key];
    return data;
}

- (void)saveData:(NSNumber *)data withKey:(NSString *)key
{
    if (!data) {
        return;
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:data forKey:key];
    [prefs synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)redeemButtonTapped:(UIButton *)sender {
    
    NSInteger savedPoints = self.savedMeals * 10;
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:savedPoints >= 100 ? @"Congratulations" : @"Oops!"
                                  message:savedPoints >= 100 ? @"You have successfully redeemed a free meal." : @"You can redeem a free meal after successfully earning 100 loyalty points."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * _Nonnull action) {
                             
                             [weakSelf updateUserDefaults];
                             
                         }];
    
    [alert addAction:ok];
    
    //    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)updateUserDefaults{
    
    if(self.savedMeals >= 10){
        
        // Clear UserDefaults
        
        [self removeDataWithKey:defaultsKey];
        
        for (NSInteger i = 1; i <= self.savedMeals; i++) {
            
            [self removeDataWithKey:[NSString stringWithFormat:@"%ld", (long)i]];
        }
        
        [self updateUI];
    }
    
}

- (void)removeDataWithKey:(NSString *)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:key];
    [prefs synchronize];
}

@end
