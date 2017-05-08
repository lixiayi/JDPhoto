//
//  ViewController.m
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/4.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import "ViewController.h"
#import "JDAssetColletionViewController.h"
#import "JDAssetCameraViewController.h"

@interface ViewController ()
@property (nonatomic, copy) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 60, 70, 120, 40);
    
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor redColor]];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height - 120)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:_imageView];
}

- (void)btnClick:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        JDAssetCameraViewController *vc = [[JDAssetCameraViewController alloc] init];
        
        vc.cameraBlock = ^(UIImage *image) {
            [_imageView setImage:image];
        };
        
        [self.navigationController pushViewController:vc animated:true];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        JDAssetColletionViewController *vc = [[JDAssetColletionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        vc.seletedBlock = ^(UIImage *image) {
            
            [_imageView setImage:image];
            
        };
        
        vc.preBlock = ^(UIImage *image) {
            
            [_imageView setImage:image];
            
        };
        
        
        [self.navigationController pushViewController:vc animated:true];

    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    [alertController addAction:action1];
    
    [alertController addAction:action2];
    
    [alertController addAction:action3];
    
    [self presentViewController:alertController animated:true completion:nil];
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
