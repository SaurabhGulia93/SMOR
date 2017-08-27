//
//  SMScannerViewController.m
//  SMOR
//
//  Created by Saurabh on 5/31/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import "SMScannerViewController.h"
#import <AVFoundation/AVFoundation.h>

#define QR1 @"11.90"
#define QR2 @"23.80"
#define QR3 @"35.70"

#define QR4 @"6"
#define QR5 @"12"


#define defaultsKey @"SMORDATA"
#define paidMeals @"PAIDMEALS"
#define redeemedMeals @"REDEEMEDMEALS"
#define earnedStamps @"EARNEDSTAMPS"
#define sixOff @"6OFF"
#define twelveOff @"12OFF"

@interface SMScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, assign) BOOL shouldStopScan;
@property (nonatomic, assign) NSInteger savedMeals;
@property (nonatomic, assign) NSString *qrCodeValue;


@end

@implementation SMScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"QR Scanner";
    self.permissionButton.layer.cornerRadius = 2;
    self.permissionButton.layer.masksToBounds = YES;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redeemMeals:) name:@"redeemNotification" object:nil];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.shouldStopScan = false;
    [self.permissionView setHidden:true];
    
//    NSInteger savedMealsValue = 0;
//    NSArray *savedPaidMeals = [self getDataForKey:paidMeals];
    
//    NSNumber *savedMeals = [self getDataForKey:defaultsKey];
    
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
    
    NSArray *savedStamps = [self getDataForKey:earnedStamps];
    
    self.savedMeals = savedStamps.count;

}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    self.redeem12Off = false;
    self.redeem6Off = false;
}

//-(void)redeemMeals:(NSNotification *)notification{
//    
//    NSDictionary *userInfo = notification.userInfo;
//    NSString *redeemVal = [userInfo objectForKey:@"redeem"];
//    if(redeemVal){
//        
//        if(redeemVal.intValue == 6){
//            self.redeem6Off = true;
//        }else if(redeemVal.intValue == 12){
//            self.redeem12Off = true;
//        }
//    }
//}

-(id)getDataForKey:(NSString *)key{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    id data = [prefs objectForKey:key];
    return data;
}

- (void)saveData:(id)data withKey:(NSString *)key
{
    if (!data) {
        return;
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:data forKey:key];
    [prefs synchronize];
}

- (void)removeDataWithKey:(NSString *)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:key];
    [prefs synchronize];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self startScanIfPossible];
}

-(void)startScan{
    
    BOOL startedReading = [self startReading];
    
    if(startedReading){
        [self.captureView setHidden:false];
        [self.permissionView setHidden:true];
    }else{
        [self.captureView setHidden:true];
        [self.permissionView setHidden:false];
    }

}

- (void)startScanIfPossible {
    
    if(self.savedMeals >= 10 && !self.redeem12Off && !self.redeem6Off){
        
        NSString *msg = [NSString stringWithFormat:@"You have got pending free meal. Please redeem it before scanning any further stamps."];
        
        UIAlertController * alert =   [UIAlertController
                                       alertControllerWithTitle:@"Hurrah!!"
                                       message:msg
                                       preferredStyle:UIAlertControllerStyleAlert];
        
        
        __weak typeof(self) weakSelf = self;

        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Ok"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * _Nonnull action) {
                                 
                                 weakSelf.tabBarController.selectedIndex = 2;
                                 
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if (authStatus == AVAuthorizationStatusAuthorized) {
        [self startScan];
    }
    else if(authStatus == AVAuthorizationStatusDenied){
        [self startScan];
    }
    else if(authStatus == AVAuthorizationStatusNotDetermined){
        __weak typeof(self) weakSelf = self;
        
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            if(granted){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf startScan];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf startScan];
                });
            }
            
        }];
    } else {
        
    }
}


- (BOOL)startReading {
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return false;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_captureView.layer.bounds];
    [_captureView.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
    
    return true;
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            
//            NSLog(@"QR Value - %@", [metadataObj stringValue]);
            
            NSString *qrCodeValue = [metadataObj stringValue];
            
            if ((_redeem6Off || _redeem12Off) && ([qrCodeValue containsString:QR4] || [qrCodeValue containsString:QR5])){
                
                self.qrCodeValue = qrCodeValue;
                if(!_shouldStopScan){
                    [self performSelectorOnMainThread:@selector(redeemSuccessFull) withObject:nil waitUntilDone:NO];
                    _shouldStopScan = true;
                }
            } else if([qrCodeValue containsString:QR1] || [qrCodeValue containsString:QR2]|| [qrCodeValue containsString:QR3]){
                
                self.qrCodeValue = qrCodeValue;
                if(!_shouldStopScan){
                    [self performSelectorOnMainThread:@selector(showSuccessPopup) withObject:nil waitUntilDone:NO];
                    _shouldStopScan = true;
                }
            }
            
        }
    }
}

-(void)redeemSuccessFull{
    
    if(self.redeem6Off){
        
//        NSArray *savedPaidMeals = [self getDataForKey:earnedStamps];
//        
//        NSMutableArray *mutArr = [NSMutableArray arrayWithArray:savedPaidMeals];
//        
//        [mutArr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 5)]];
//        
//        [self saveData:[NSArray arrayWithArray:mutArr] withKey:earnedStamps];
        
        [self saveData:[NSNumber numberWithBool:true] withKey:sixOff];
        
    }else if (self.redeem12Off){
        
        [self removeDataWithKey:earnedStamps];
        
        [self removeDataWithKey:paidMeals];
        
        [self removeDataWithKey:sixOff];
        
        [self saveData:[NSNumber numberWithBool:true] withKey:twelveOff];

    }
    
    if(_redeem12Off || _redeem6Off){
        
        NSString *msg = [NSString stringWithFormat:@"You have successfully redeemed an offer"];
        
        UIAlertController * alert =   [UIAlertController
                                       alertControllerWithTitle:@"Congratulations"
                                       message:msg
                                       preferredStyle:UIAlertControllerStyleAlert];
        
        
        __weak typeof(self) weakSelf = self;
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Ok"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * _Nonnull action) {
                                 
                                 [weakSelf updateUserDefaultsOnRedeem];
                                 weakSelf.tabBarController.selectedIndex = 2;

                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    _redeem6Off = false;
    _redeem12Off = false;

}

-(void)showSuccessPopup{
    
    NSInteger pointsEarned = 10;
    NSInteger previouseSavedMeals = self.savedMeals;
    NSInteger previousPoints = previouseSavedMeals * 10;
    
    if([_qrCodeValue containsString:QR1]){
        self.savedMeals += 1;
        pointsEarned = 10;
    }else if ([_qrCodeValue containsString:QR2]){
        self.savedMeals += 2;
        pointsEarned = 20;
    }else if ([_qrCodeValue containsString:QR3]){
        self.savedMeals += 3;
        pointsEarned = 30;
    }
    
//    NSInteger savedPoints = self.savedMeals * 10;
//    
//    NSString *msg = savedPoints == 100 ? @"You can redeem a free meal." : [NSString stringWithFormat:@"You have successfully earned %ld loyalty points. You can redeem a free meal after successfully earning 100 loyalty points.", (long)pointsEarned];
//    
//    if(savedPoints > 100){
//        
//        msg = @"You have successfully redeemed a free meal";
//        
//        if(previousPoints < 100 ){
//         
//            msg = @"You can redeem a free meal.";
//        }
//    }
    
    if(previousPoints >= 100){
        
        [self updateUserDefaults:previousPoints];
    }
    
    NSString *msg = [NSString stringWithFormat:@"You have successfully earned %ld loyalty points.", (long)pointsEarned];
    
    UIAlertController * alert =   [UIAlertController
                                  alertControllerWithTitle:@"Congratulations"
                                  message:msg
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * _Nonnull action) {
                             
                             [weakSelf updateUserDefaults:previousPoints];
                             
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)updateUserDefaultsOnRedeem{
    
    NSMutableDictionary *mutDict = [[NSMutableDictionary alloc] init];
    
    NSDate *date = [NSDate date];
    
    [mutDict setObject:date forKey:@"date"];
    
    if(self.qrCodeValue){
        
        [mutDict setObject:[NSString stringWithFormat:@"%@", self.qrCodeValue] forKey:@"qrValue"];
        
    }
    
    NSArray *savedRedeemedMeals = [self getDataForKey:redeemedMeals];
    
    NSMutableArray *mutArr = nil;
    if(savedRedeemedMeals){
        mutArr = [[NSMutableArray alloc] initWithArray:savedRedeemedMeals];
    }else{
        mutArr = [[NSMutableArray alloc] init];
    }
    [mutArr addObject:[NSDictionary dictionaryWithDictionary:mutDict]];
    
    [self saveData:[NSArray arrayWithArray:mutArr] withKey:redeemedMeals];

}

-(void)updateUserDefaults:(NSInteger)previousPoints{
    
//    NSInteger savedPoints = self.savedMeals * 10;
//    
//    if(savedPoints > 100 && previousPoints >= 100){
//        
//        // Clear UserDefaults
//        [self removeDataWithKey:defaultsKey];
//        
//        return;
//    }
    
    
//    if(previousPoints >= 100){
//        
//        NSString *msg = [NSString stringWithFormat:@"You already have 10 stamps. Please redeem a free meal"];
//        
//        UIAlertController * alert =   [UIAlertController
//                                       alertControllerWithTitle:@"Oops!"
//                                       message:msg
//                                       preferredStyle:UIAlertControllerStyleAlert];
//        
//        
//        __weak typeof(self) weakSelf = self;
//        
//        UIAlertAction* ok = [UIAlertAction
//                             actionWithTitle:@"Ok"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * _Nonnull action) {
//                                 
//                                 weakSelf.tabBarController.selectedIndex = 2;
//
//                                 
//                             }];
//        
//        [alert addAction:ok];
//        [self presentViewController:alert animated:YES completion:nil];
//        return;
//    }

    
    NSMutableDictionary *mutDict = [[NSMutableDictionary alloc] init];
    
    NSDate *date = [NSDate date];
    
    [mutDict setObject:date forKey:@"date"];
    
    if(self.qrCodeValue){
        
        [mutDict setObject:[NSString stringWithFormat:@"%@", self.qrCodeValue] forKey:@"qrValue"];
        
        NSInteger equivalentMeals = 1;
        if([_qrCodeValue containsString:QR1]){
            equivalentMeals = 1;
        }else if ([_qrCodeValue containsString:QR2]){
            equivalentMeals = 2;
        }else if ([_qrCodeValue containsString:QR3]){
            equivalentMeals = 3;
        }
        [mutDict setObject:[NSNumber numberWithInteger:equivalentMeals] forKey:@"equivalentMeals"];
        
        
        
        // Save earned Stamps
        NSArray *savedStamps = [self getDataForKey:earnedStamps];
        
        NSMutableArray *mutArr = nil;
        if(savedStamps){
            mutArr = [[NSMutableArray alloc] initWithArray:savedStamps];
        }else{
            mutArr = [[NSMutableArray alloc] init];
        }
        
        for(NSInteger i = 0; i < equivalentMeals; i++){
            
            [mutArr addObject:@"eranedStamp"];
    
        }
        [self saveData:[NSArray arrayWithArray:mutArr] withKey:earnedStamps];
    }
    

    NSArray *savedPaidMeals = [self getDataForKey:paidMeals];
    
    NSMutableArray *mutArr = nil;
    if(savedPaidMeals){
        mutArr = [[NSMutableArray alloc] initWithArray:savedPaidMeals];
    }else{
        mutArr = [[NSMutableArray alloc] init];
    }
    [mutArr addObject:[NSDictionary dictionaryWithDictionary:mutDict]];
    
    [self saveData:[NSArray arrayWithArray:mutArr] withKey:paidMeals];
    
//    [self saveData:mutDict withKey:[NSString stringWithFormat:@"%ld",(long)self.savedMeals]];
    
//    [self saveData:[NSNumber numberWithInteger:self.savedMeals] withKey:[NSString stringWithFormat:@"%@",defaultsKey]];
    
    self.tabBarController.selectedIndex = 2;
}

- (IBAction)grantPermission:(UIButton *)sender {
    
    if (UIApplicationOpenSettingsURLString != NULL) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Camera Permission" message:@"Please enable camera from the app settings for MyAirtel app" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}]
         ];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

@end
