//
//  SMScannerViewController.m
//  SMOR
//
//  Created by Saurabh on 5/31/17.
//  Copyright © 2017 Gronical Studios. All rights reserved.
//

#import "SMScannerViewController.h"
#import <AVFoundation/AVFoundation.h>

#define QR1 @"11.70"
#define QR2 @"11.70"
#define QR3 @"11.70"

@interface SMScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, assign) BOOL shouldStopScan;

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
            
            NSLog(@"QR Value - %@", [metadataObj stringValue]);
            
            NSString *qrCodeValue = [metadataObj stringValue];
            
            if([qrCodeValue isEqualToString:QR1] || [qrCodeValue isEqualToString:QR2]|| [qrCodeValue isEqualToString:QR3]){
                
                [self performSelectorOnMainThread:@selector(showSuccessPopup) withObject:nil waitUntilDone:NO];
            }
            
        }
    }
}

-(void)showSuccessPopup{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Congratulations"
                                  message:@"You have successfully earned 10 loyalty points. You can redeem a free meal after successfully earning 100 loyalyty points."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * _Nonnull action) {
                             
                             self.tabBarController.selectedIndex = 3;
                             
                         }];
    
    [alert addAction:ok];
    
    //    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];

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
