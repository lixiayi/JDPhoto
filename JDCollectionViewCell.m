//
//  JDCollectionViewCell.m
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/4.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import "JDCollectionViewCell.h"
#import "JDAssetCheckMarkView.h"

@implementation JDCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
}

- (void)setupOveryView {
 
    self.overlayView = [[UIView alloc] initWithFrame:self.bounds];
    
    self.overlayView.backgroundColor = [UIColor darkGrayColor];
    
    self.overlayView.alpha = 0.6f;
    
    self.checkmarkView = [[JDAssetCheckMarkView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 20, self.bounds.size.height - 20, 20, 20)];
    
    [self.overlayView addSubview:self.checkmarkView];
    
    [self.contentView addSubview:self.overlayView];
}

@end
