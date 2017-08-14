//
//  SMNewStampLayoutViewController.m
//  SMOR
//
//  Created by Saurabh on 8/4/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import "SMNewStampLayoutViewController.h"
#import "MLStyle.h"
#import "SMScannerViewController.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define defaultsKey @"SMORDATA"
#define paidMeals @"PAIDMEALS"
#define redeemedMeals @"REDEEMEDMEALS"
#define earnedStamps @"EARNEDSTAMPS"


@interface SMNewStampLayoutViewController ()

@property (nonatomic, assign) NSInteger radius;

@end

@implementation SMNewStampLayoutViewController
{
    int number;
    int frameWidth;
    int frameHeight;
    NSInteger savedMealsInt;
}

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

-(id)getDataForKey:(NSString *)key{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *data = [prefs objectForKey:key];
    return data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    frameWidth = [UIScreen mainScreen].bounds.size.width;
    frameHeight = [UIScreen mainScreen].bounds.size.height;
    
    number = 12;
    
    for(int i=0;i<number;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(134*frameWidth/320, 180*frameHeight/480, 45, 45)];
        
        [self.view addSubview:button];
        [button setBackgroundColor:[UIColor colorWithRed: 0.667 green: 0.667 blue: 0.667 alpha: 1]];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"" forState:UIControlStateNormal];
        button.tag = i+1;
        [[button titleLabel] setFont:[UIFont systemFontOfSize:12]];
        if(button.tag == 1){
            
            [button setTitle:@"$12 Off" forState:UIControlStateNormal];
        }
        if(button.tag == 7){
            
            [button setTitle:@"$6 Off" forState:UIControlStateNormal];
        }
    }
    
    self.noteLabel = [[UILabel alloc] init];
    self.noteLabel.numberOfLines = 0;
    [self.view addSubview:self.noteLabel];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSArray *savedPaidMeals = [self getDataForKey:earnedStamps];

    NSInteger savedMealsValue = savedPaidMeals.count;
    
//    if(savedPaidMeals){
//        for(NSDictionary *dict in savedPaidMeals){
//            NSNumber *equivalentMeals = [dict objectForKey:@"equivalentMeals"];
//            if(equivalentMeals){
//                savedMealsValue += equivalentMeals.integerValue;
//            }
//        }
//    }else{
//        savedMealsValue = 0;
//    }
    
    savedMealsInt = savedMealsValue;
    
    for(int i=1;i<= 12 ;i++){
        
        UIButton *button = [self.view viewWithTag:i];
        
        if(button.tag == 1 || button.tag == 7){
            continue;
        }
        
        if(button.tag < 7){
            [button setTitle:[NSString stringWithFormat:@"%ld", button.tag - 1] forState:UIControlStateNormal];
        }
        if(button.tag > 7){
            [button setTitle:[NSString stringWithFormat:@"%ld", button.tag - 2] forState:UIControlStateNormal];
        }
        [button setBackgroundImage:nil forState:UIControlStateNormal];
//        button.layer.borderWidth = 0;
//        button.layer.masksToBounds = YES;
        if(savedMealsValue > 0){
            
            [button setBackgroundImage:[UIImage imageNamed:@"smoreStamp.jpeg"] forState:UIControlStateNormal];
            savedMealsValue--;
//            button.layer.borderWidth = 1;
//            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
//            button.layer.masksToBounds = YES;
        }
    }
    
    [self arrangePlayers:number];
    [self arrangeNoteLabel];
}

-(void)buttonClicked:(UIButton *)sender{
    
    if(sender.tag == 1){
        
        if(savedMealsInt >= 10){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"redeemNotification" object:nil userInfo:@{@"redeem" : @"12"}];
            self.tabBarController.selectedIndex = 1;
        }else{
            NSString *msg = @"You can redeem a free meal after successfully earning 10 loyalty stamps.";
            [self showPopUp:msg];
        }
        
    }else if (sender.tag == 7){
        
        if(savedMealsInt >= 5){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"redeemNotification" object:nil userInfo:@{@"redeem" : @"6"}];
            self.tabBarController.selectedIndex = 1;
        }else{
            NSString *msg = @"You can redeem a $6 Off after successfully earning atleast 5 loyalty stamps.";
            [self showPopUp:msg];
        }
    }
    
}

-(void)showPopUp:(NSString *)msg{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Oops!"
                                  message:msg
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * _Nonnull action) {
                             
                         }];
    
    [alert addAction:ok];
    
    //    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)arrangePlayers:(int)num{
    
    int width = 45,height = 45;
    float angle = 0.0;
    int r = 125;
    int j = 0;
    angle = DEGREES_TO_RADIANS(360/num);

    for(UIButton *button in self.view.subviews)
        {
            if(button.tag)
            {
                [button setFrame:CGRectMake(140*frameWidth/320 + (r*frameWidth/320 * sin(j *angle)), 140*frameHeight/480 - (r*frameHeight/480 * cos(j * angle )), width*frameWidth/320, height*frameWidth/320)];
                j++;
                button.layer.cornerRadius = button.frame.size.width/2;
                button.layer.masksToBounds = YES;
            }
        }
}

-(void)arrangeNoteLabel{
    
    self.noteLabel = [[UILabel alloc] init];
    self.noteLabel.numberOfLines = 0;
    self.noteLabel.attributedText = [self attrTextForNoteLabel];
    
    CGRect referenceFrame = [self.view viewWithTag:7].frame;
    
    self.noteLabel.frame = CGRectMake(10, CGRectGetMaxY(referenceFrame) + 10, self.view.bounds.size.width - 2*10, 100);
    
    [self.view addSubview:self.noteLabel];
//    self.noteLabel.backgroundColor = [UIColor yellowColor];
    self.noteLabel.contentMode = UIViewContentModeTop;
    [self.noteLabel sizeToFit];
}

- (NSAttributedString *)attrTextForNoteLabel
{
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    
    NSMutableParagraphStyle *mainStyle = [[NSMutableParagraphStyle alloc] init];
    mainStyle.alignment = NSTextAlignmentLeft;
    mainStyle.paragraphSpacing = 4;
    
    //    NSDictionary *headerTitleDict3 = @{NSFontAttributeName : REGULAR(17),
    //                                       NSForegroundColorAttributeName : kDarkerGrayFontColor,
    //                                       NSParagraphStyleAttributeName : mainStyle
    //                                       };
    
    NSDictionary *headerTitleDict2 = @{NSFontAttributeName : REGULAR(15),
                                       NSForegroundColorAttributeName : kDarkerGrayFontColor,
                                       NSParagraphStyleAttributeName : mainStyle
                                       };
    
    NSDictionary *headerTitleDict1 = @{NSFontAttributeName : REGULAR(15),
                                       NSForegroundColorAttributeName : kLightGrayColor,
                                       NSParagraphStyleAttributeName : mainStyle
                                       };
    
    
    NSAttributedString *headerAttr1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"Note:\n"] attributes:headerTitleDict2];
    [attStr appendAttributedString:headerAttr1];
    
    NSAttributedString *headerAttr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",@"Redeem $6 off by earning atleast 5 stamps.\nRedeem $12 off by earning 10 stamps"] attributes:headerTitleDict1];
    [attStr appendAttributedString:headerAttr2];
    
//    NSAttributedString *headerAttr3 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", dateStr] attributes:headerTitleDict1];
//    [attStr appendAttributedString:headerAttr3];
    
    
    return [[NSAttributedString alloc] initWithAttributedString:attStr];
}


//-(void)makeStampCard{
//    
//    float topPAdding = 40;
//    float bottomPAdding = 100;
//    float sidePAdding = 40;
//    
//    NSLog(@"%f",self.tabBarController.tabBar.bounds.size.height);
//    
//    
//    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - (self.view.bounds.size.width - 2 * sidePAdding))/2, topPAdding, (self.view.bounds.size.width - 2 * sidePAdding), (self.view.bounds.size.height - (topPAdding + bottomPAdding) - self.tabBarController.tabBar.bounds.size.height))];
//    containerView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:containerView];
//    
//    float containerCenterX = containerView.center.x;
//    float containerCenterY = containerView.center.y;
//    
//    int width,height;
//    float angle;
//    int r = 200;
////    int j = 0;
//
//    angle = 0;
//    width = 55;
//    height = 55;
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button addTarget:self action:@selector(buttonTApped) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = [UIColor blueColor];
//    button.frame = CGRectMake(0, 0, width, height);
//    [containerView addSubview:button];
//    
//    float buttonCenterX =  r * cos(angle);
//    float buttonCenterY =  r * sin(angle);
//    
//    [button setCenter:CGPointMake(buttonCenterX, buttonCenterY)];
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
