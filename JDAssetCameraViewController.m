//
//  JDAssetCameraViewController.m
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/8.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import "JDAssetCameraViewController.h"
#import "LLSimpleCamera.h"
#import "JDAssetCameraToolbarView.h"
#import "JDAssetCameraPreview.h"


@interface JDAssetCameraViewController ()

@property (nonatomic, strong) LLSimpleCamera *camera;

@property (nonatomic, strong) JDAssetCameraToolbarView *cameraToolbarView;




@end

@implementation JDAssetCameraViewController

- (BOOL)prefersStatusBarHidden {

    return YES;
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.camera = [[LLSimpleCamera alloc] initWithQuality:AVCaptureSessionPresetHigh
                                                 position:LLCameraPositionRear
                                             videoEnabled:NO];
    
    [self.view addSubview:self.cameraToolbarView];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    [self.camera attachToViewController:self withFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height - 150)];
    
    self.camera.fixOrientationAfterCapture = NO;
    
    __weak typeof(self) weakSelf = self;
    
    [self.camera setOnDeviceChange:^(LLSimpleCamera *camera, AVCaptureDevice *device) {
        
        if (weakSelf.cameraToolbarView) {
            
            
            if([camera isFlashAvailable]) {
                // show the flash button here
                [weakSelf.cameraToolbarView setFlashEnabled:YES];
                if(camera.flash == LLCameraFlashOff) {
                    // turn off the flash button
                    [weakSelf.cameraToolbarView setFlashState:NO];
                } else {
                    // turn on the flash button
                    [weakSelf.cameraToolbarView setFlashState:YES];
                }
            } else {
                // hide the flash button here
                [weakSelf.cameraToolbarView setFlashEnabled:NO];
            }
        }
    }];
    
    [self.camera setOnError:^(LLSimpleCamera *camera, NSError *error) {
        NSLog(@"Camera error: %@", error);
        
        if([error.domain isEqualToString:LLSimpleCameraErrorDomain]) {
            if(error.code == LLSimpleCameraErrorCodeCameraPermission ||
               error.code == LLSimpleCameraErrorCodeMicrophonePermission) {
            }
        }
    }];
    
}

- (UIView *)cameraToolbarView {
    
    if (!_cameraToolbarView) {
        
        _cameraToolbarView = [[JDAssetCameraToolbarView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 150)];
        
        [_cameraToolbarView.cameraCancelButton addTarget:self action:@selector(cameraCancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_cameraToolbarView.cameraFlashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_cameraToolbarView.cameraSwitchButton addTarget:self action:@selector(switchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_cameraToolbarView.cameraSnapButton addTarget:self action:@selector(snapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cameraToolbarView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.camera start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.camera stop];
}

#pragma mark - Actions

- (void)switchButtonPressed:(id)sender
{
    [self.camera togglePosition];
}

- (void)flashButtonPressed:(id)sender
{
    if(self.camera.flash == LLCameraFlashOff) {
        BOOL done = [self.camera updateFlashMode:LLCameraFlashOn];
        if(done) {
            [_cameraToolbarView setFlashState:YES];
        }
    }
    else {
        BOOL done = [self.camera updateFlashMode:LLCameraFlashOff];
        if(done) {
            [_cameraToolbarView setFlashState:NO];
        }
    }
}

- (void)snapButtonPressed:(id)sender
{
    [self.camera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
        if(!error) {
            
            // We should stop the camera, we are opening a new vc, thus we don't need it anymore.
            // This is important, otherwise you may experience memory crashes.
            // Camera is started again at viewWillAppear after the user comes back to this view.
            // I put the delay, because in iOS9 the shutter sound gets interrupted if we call it directly.
            
            [camera performSelector:@selector(stop) withObject:nil afterDelay:0.2];
            JDAssetCameraPreview *vc = [[JDAssetCameraPreview alloc]initWithImage:image];
            
            vc.selectBlock = ^(UIImage *img) {
                
                if (self.cameraBlock) {
                    
                    self.cameraBlock(img);
                }
                
            };
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            NSLog(@"An error has occured: %@", error);
        }
    } exactSeenImage:YES];
}

- (void)cameraCancelButtonPressed:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
