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

#define defaultsKey @"SMORDATA"

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
    self.permissionButton.layer.cornerRadius = 2;
    self.permissionButton.layer.masksToBounds = YES;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.shouldStopScan = false;
    [self.permissionView setHidden:true];
    NSNumber *savedMeals = [self getDataForKey:defaultsKey];
    
    NSInteger savedMealsValue = savedMeals ? savedMeals.integerValue : 0;
    
    self.savedMeals = savedMealsValue;

}

-(NSNumber *)getDataForKey:(NSString *)key{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *data = [prefs objectForKey:key];
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
            
            if([qrCodeValue containsString:QR1] || [qrCodeValue containsString:QR2]|| [qrCodeValue containsString:QR3]){
                
                self.qrCodeValue = qrCodeValue;
                if(!_shouldStopScan){
                    [self performSelectorOnMainThread:@selector(showSuccessPopup) withObject:nil waitUntilDone:NO];
                    _shouldStopScan = true;
                }
            }
            
        }
    }
}

-(void)showSuccessPopup{
    
    self.savedMeals += 1;
    
    NSInteger savedPoints = self.savedMeals * 10;
    
    NSString *msg = savedPoints >= 100 ? @"You can redeem a free meal." : @"You have successfully earned 10 loyalty points. You can redeem a free meal after successfully earning 100 loyalty points.";
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Congratulations"
                                  message:msg
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * _Nonnull action) {
                             
                             [weakSelf updateUserDefaults];
                             
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)updateUserDefaults{
    
    NSMutableDictionary *mutDict = [[NSMutableDictionary alloc] init];
    
    NSDate *date = [NSDate date];
    
    [mutDict setObject:date forKey:@"date"];
    
    if(self.qrCodeValue){
        
        [mutDict setObject:[NSString stringWithFormat:@"%@", self.qrCodeValue] forKey:@"qrValue"];
    }
    
    [self saveData:mutDict withKey:[NSString stringWithFormat:@"%ld",(long)self.savedMeals]];
    
    [self saveData:[NSNumber numberWithInteger:self.savedMeals] withKey:[NSString stringWithFormat:@"%@",defaultsKey]];
    
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
