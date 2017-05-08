//
//  JDAsssetToolBar.h
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/5.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 预览的回调
 */
typedef void(^PreviewBtnBlock)(UIImage *);

/**
 确认的回调
 */
typedef void(^confirmBtnBlock)(UIImage *);


@interface JDAsssetToolBar : UIView


/**
 预览
 */
@property (nonatomic, strong) UIButton *preViewBtn;

/**
 确定
 */
@property (nonatomic, strong) UIButton *confirmBtn;


/**
 预览的回调
 */
@property (nonatomic, strong) PreviewBtnBlock pvBlock;

/**
 确定的回调
 */
@property (nonatomic, strong) confirmBtnBlock confirmBlock;


/**
 传递选择的图片
 */
@property (nonatomic, strong) UIImage *passImage;

/**
 修改状态

 @param enabled 是否可用
 */
- (void)changeState:(BOOL)enabled;

@end
