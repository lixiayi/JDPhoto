//
//  JDAssetColletionViewController.h
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/4.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef void(^SelectedImageBlock)(UIImage *image);
typedef void(^PreviewBlock)(UIImage *image);

@interface JDAssetColletionViewController : UICollectionViewController

/**
 确定按钮的回调,把选择的图片传给调用方
 */
@property (nonatomic, strong) SelectedImageBlock seletedBlock;

@property (nonatomic, strong) PreviewBlock preBlock;


@end
