//
//  JDAssetCheckMarkView.m
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/5.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import "JDAssetCheckMarkView.h"

@implementation JDAssetCheckMarkView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
    
        // Set default values
        self.borderWidth = 1.0;
        
        self.checkmarkLineWidth = 1.2;
        
        self.borderColor = [UIColor whiteColor];
        self.bodyColor = [UIColor clearColor];
        self.checkmarkColor = [UIColor whiteColor];
        
        self.backgroundColor = [UIColor clearColor];
        
        // Set shadow
        self.layer.shadowColor = [[UIColor grayColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.6;
        self.layer.shadowRadius = 2.0;
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = self.frame.size.width/2.0f;
        
    }
    
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *checkmarkPath = [UIBezierPath bezierPath];
    
    checkmarkPath.lineWidth = self.checkmarkLineWidth;
    
    [checkmarkPath moveToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (6.0 / 24.0), CGRectGetHeight(self.bounds) * (12.0 / 24.0))];
    
    [checkmarkPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (10.0 / 24.0), CGRectGetHeight(self.bounds) * (16.0 / 24.0))];
    
    [checkmarkPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) * (18.0 / 24.0), CGRectGetHeight(self.bounds) * (8.0 / 24.0))];
    
    
    
    [self.checkmarkColor setStroke];
    
    [checkmarkPath stroke];
 
}


@end
