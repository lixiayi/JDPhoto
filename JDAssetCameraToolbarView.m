//
//  JDAssetCameraToolbarView.m
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/8.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import "JDAssetCameraToolbarView.h"

@implementation JDAssetCameraToolbarView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {

        CGFloat button_width = 46.0f;
        
        // In order to decrease the complexity of the structure, I moved the event handler to the camera controller, so that the responder chain would be clearer
        
        CGFloat margin_width_camera = (self.frame.size.width - 76.0f - 3 * button_width ) / 2.0f;
        self.cameraCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(38.0f, 14.0f, button_width, button_width)];
        [_cameraCancelButton setImage:[UIImage imageNamed:@"rtimagepicker_cancel"] forState:UIControlStateNormal];
        [self addSubview:_cameraCancelButton];
        
        self.cameraFlashButton = [[UIButton alloc] initWithFrame:CGRectMake(_cameraCancelButton.frame.origin.x + _cameraCancelButton.frame.size.width + margin_width_camera, 14.0f, button_width, button_width)];
        [_cameraFlashButton setImage:[UIImage imageNamed:@"rtimagepicker_flash_off"] forState:UIControlStateNormal];
        [self addSubview:_cameraFlashButton];
        
        self.cameraSwitchButton = [[UIButton alloc] initWithFrame:CGRectMake(_cameraFlashButton.frame.origin.x + _cameraFlashButton.frame.size.width + margin_width_camera, _cameraFlashButton.frame.origin.y, button_width, button_width)];
        [_cameraSwitchButton setImage:[UIImage imageNamed:@"rtimagepicker_switch"] forState:UIControlStateNormal];
        [self addSubview:_cameraSwitchButton];
        
        self.cameraSnapButton = [[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width - self.frame.size.height/2.0f)/2.0f, _cameraSwitchButton.frame.origin.y + _cameraSwitchButton.frame.size.height, self.frame.size.height/2.0f, self.frame.size.height/2.0f)];
        [_cameraSnapButton setImage:[UIImage imageNamed:@"rtimagepicker_snap"] forState:UIControlStateNormal];
        [self addSubview:_cameraSnapButton];
    }
    
    return self;
}

- (void)setFlashEnabled:(BOOL)enabled
{
    self.cameraFlashButton.hidden = !enabled;
}

- (void)setFlashState:(BOOL)state
{
    if(state) {
        [self.cameraFlashButton setImage:[UIImage imageNamed:@"rtimagepicker_flash_on"] forState:UIControlStateNormal];
    } else {
        [self.cameraFlashButton setImage:[UIImage imageNamed:@"rtimagepicker_flash_off"] forState:UIControlStateNormal];
    }
}

@end
