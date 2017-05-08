//
//  JDCollectionViewCell.h
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/4.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDAssetCheckMarkView.h"

@interface JDCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIView *overlayView;

@property (nonatomic, strong) JDAssetCheckMarkView *checkmarkView;

@property (nonatomic, assign) BOOL showsOverlayViewWhenSelected;


- (void)setupOveryView;

@end
