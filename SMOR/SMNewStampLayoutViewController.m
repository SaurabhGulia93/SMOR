//
//  SMNewStampLayoutViewController.m
//  SMOR
//
//  Created by Saurabh on 8/4/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import "SMNewStampLayoutViewController.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface SMNewStampLayoutViewController ()

@property (nonatomic, assign) NSInteger radius;

@end

@implementation SMNewStampLayoutViewController
{
    int number;
    int frameWidth;
    int frameHeight;
}

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


- (void)viewDidLoad {
    [super viewDidLoad];
    frameWidth = [UIScreen mainScreen].bounds.size.width;
    frameHeight = [UIScreen mainScreen].bounds.size.height;
    
    number = 12;
    
    for(int i=0;i<number;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(134*frameWidth/320, 180*frameHeight/480, 1, 1)];
        
        [self.view addSubview:button];
        [button setBackgroundColor:[UIColor blueColor]];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"" forState:UIControlStateNormal];
        button.tag = i+1;
        
    }
    
    [self arrangePlayers:number];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [self makeStampCard];
}

-(void)arrangePlayers:(int)num{
    
    int width = 0,height = 0;
    float angle = 0.0;
    int r = 110;
    int j;
    j=0;
    switch (num) {
        case 2:
            angle = DEGREES_TO_RADIANS(360/num);
            width = 55;
            height = 55;
            break;
        case 3:
            angle = DEGREES_TO_RADIANS(360/num);
            width = 50;
            height = 50;
            break;
        case 4:
            angle = DEGREES_TO_RADIANS(360/num);
            width = 40;
            height = 40;
            break;
        case 5:
            width = 40;
            height = 40;
            angle = DEGREES_TO_RADIANS(360/num);
            break;
            
        case 6:
            width = 40;
            height = 40;
            angle = DEGREES_TO_RADIANS(360/num);
            break;
            
        case 7:
            angle = DEGREES_TO_RADIANS(360/num);
            width = 40;
            height = 40;
            r = 130;
            break;
            
        case 8:
            angle = DEGREES_TO_RADIANS(360/num);
            width = 40;
            height = 40;
            r = 130;
            break;
            
        case 9:
            width = 40;
            height = 40;
            r = 130;
            angle = DEGREES_TO_RADIANS(360/num);
            break;
            
        case 12:
            width = 45;
            height = 45;
            r = 130;
            angle = DEGREES_TO_RADIANS(360/num);
            break;

        default:
            break;
    }
    
        r = 125;
        for(UIButton *button in self.view.subviews)
        {
            if(button.tag)
            {
                if (j == 0) {
                    [button setBackgroundColor:[UIColor yellowColor]];
                }
                [button setFrame:CGRectMake(140*frameWidth/320 + (r*frameWidth/320 * sin(j *angle)), 140*frameHeight/480 - (r*frameHeight/480 * cos(j * angle )), width*frameWidth/320, height*frameWidth/320)];
                //NSLog(@"(r*frameWidth/320 * sin(j *angle)) = %f",(r*frameWidth/320 * sin(j *angle)));
                j++;
                [button setHidden:NO];
                button.layer.cornerRadius = button.frame.size.width/2;
                button.layer.masksToBounds = YES;
            }
        }
}

-(void)makeStampCard{
    
    float topPAdding = 40;
    float bottomPAdding = 100;
    float sidePAdding = 40;
    
    NSLog(@"%f",self.tabBarController.tabBar.bounds.size.height);
    
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - (self.view.bounds.size.width - 2 * sidePAdding))/2, topPAdding, (self.view.bounds.size.width - 2 * sidePAdding), (self.view.bounds.size.height - (topPAdding + bottomPAdding) - self.tabBarController.tabBar.bounds.size.height))];
    containerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:containerView];
    
    float containerCenterX = containerView.center.x;
    float containerCenterY = containerView.center.y;
    
    int width,height;
    float angle;
    int r = 200;
//    int j = 0;

    angle = 0;
    width = 55;
    height = 55;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(buttonTApped) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(0, 0, width, height);
    [containerView addSubview:button];
    
    float buttonCenterX =  r * cos(angle);
    float buttonCenterY =  r * sin(angle);
    
    [button setCenter:CGPointMake(buttonCenterX, buttonCenterY)];
    
}

-(void)buttonTApped{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
