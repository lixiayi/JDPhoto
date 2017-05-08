//
//  JDAssetCameraViewController.h
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/8.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CameraSelectedBlock)(UIImage *);

@interface JDAssetCameraViewController : UIViewController

@property (nonatomic, strong) CameraSelectedBlock cameraBlock;

@end
