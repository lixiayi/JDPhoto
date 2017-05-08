//
//  JDAssetCameraPreview.h
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/8.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedImageBlock)(UIImage *);


@interface JDAssetCameraPreview : UIViewController


@property (nonatomic, strong) SelectedImageBlock selectBlock;

- (id)initWithImage:(UIImage *)image;

@end
