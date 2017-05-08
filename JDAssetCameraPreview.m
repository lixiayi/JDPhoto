//
//  JDAssetCameraPreview.m
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/8.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import "JDAssetCameraPreview.h"

@interface JDAssetCameraPreview ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) UIImage *image;

@end

@implementation JDAssetCameraPreview

- (id)initWithImage:(UIImage *)image {
    
    self = [super init];
    
    if (self) {
        
        self.image = image;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageView.image = self.image;
}
- (IBAction)cancelClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:true];
    
}
- (IBAction)confirmClick:(id)sender {
    
    if (self.selectBlock) {
        
        self.selectBlock(self.image);
    }
    
    [self.navigationController popToRootViewControllerAnimated:true];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
