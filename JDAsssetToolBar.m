//
//  JDAsssetToolBar.m
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/5.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import "JDAsssetToolBar.h"

@implementation JDAsssetToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0f];
        
        // cancelBtn
        self.preViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.preViewBtn.frame = CGRectMake(30, 0, 40, 40);
        
        [self.preViewBtn setTitle:@"预览" forState:UIControlStateNormal];
        
        [self.preViewBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        [self.preViewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
       
        [self addSubview:self.preViewBtn];
        
        
        // cameraBtn
        
        self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.confirmBtn.frame = CGRectMake(self.bounds.size.width - 70, 0, 40, 40);
        
        [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        [self.confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        [self.confirmBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [self addSubview:self.confirmBtn];
        
    }
    
    return self;
}


- (void)preViewBtnClick:(UIButton *)button {
    
    if (self.pvBlock && self.passImage) {
        
        self.pvBlock(self.passImage);
        
    }
}


- (void)confirmBtnClick:(UIButton *)button {
    
    if (self.confirmBlock && self.passImage) {
        
        self.confirmBlock(self.passImage);

    }
}

- (void)changeState:(BOOL)enabled {
    
    if (enabled) {
        
        [self.preViewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.preViewBtn.enabled = true;
        [self.preViewBtn addTarget:self action:@selector(preViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.preViewBtn.enabled = true;
        
    } else {
        
        [self.preViewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.preViewBtn.enabled = false;
        [self.preViewBtn removeTarget:self action:@selector(preViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.confirmBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.confirmBtn removeTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        self.preViewBtn.enabled = false;
        
    }
}


@end
