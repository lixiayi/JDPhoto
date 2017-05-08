//
//  JDAssetCameraToolbarView.h
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/8.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDAssetCameraToolbarView : UIView


@property (nonatomic, strong) UIButton *cameraCancelButton;

@property (nonatomic, strong) UIButton *cameraFlashButton;

@property (nonatomic, strong) UIButton *cameraSwitchButton;

@property (nonatomic, strong) UIButton *cameraSnapButton;


- (id)initWithFrame:(CGRect)frame;

- (void)setFlashEnabled:(BOOL)enabled;

- (void)setFlashState:(BOOL)state;

@end
