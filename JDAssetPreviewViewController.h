//
//  JDAssetPreviewViewController.h
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/8.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedImageBlock)(UIImage *);

@interface JDAssetPreviewViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *preImageView;

@property (nonatomic, strong) UIImage *preImage;

@property (strong, nonatomic) IBOutlet UIButton *done;

@property (nonatomic, strong) SelectedImageBlock selectBlock;

@end
