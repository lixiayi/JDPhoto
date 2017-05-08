//
//  JDAssetColletionViewController.m
//  JDPhoto
//
//  Created by xiaoyi li on 17/5/4.
//  Copyright © 2017年 xiaoyi li. All rights reserved.
//

#import "JDAssetColletionViewController.h"
#import "JDCollectionViewCell.h"
#import "JDAsssetToolBar.h"
#import "JDAssetPreviewViewController.h"

#define NUMBER_OF_COLUMNS    3

@interface JDAssetColletionViewController ()<UICollectionViewDelegateFlowLayout>

//@property (nonatomic, strong) PHFetchResult *fetchResult;

/**
 所有的图片资源
 */
@property (nonatomic, strong) NSMutableArray *assets;

/**
 工具栏
 */
@property (nonatomic, strong) JDAsssetToolBar *assetToolBar;

/**
 选择的indexpath
 */
@property (nonatomic, strong) NSIndexPath *lastIndexPath;

/**
 选择的图片数组
 */
@property (nonatomic, strong) NSMutableArray *seletedImages;


@end

@implementation JDAssetColletionViewController

static NSString * const reuseIdentifier = @"JDCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.collectionView registerNib:[UINib nibWithNibName:@"JDCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.allowsMultipleSelection = NO;
    
    self.assets = [NSMutableArray array];
    
    self.seletedImages = [NSMutableArray array];
    
    [self getAllPhoto];
    
    [self.view addSubview:self.assetToolBar];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSLog(@"self.lastIndex>>>>%@",self.lastIndexPath);
    
}

- (void)getAllPhoto{
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusAuthorized) {
        
        
        PHFetchResult *smartAlbumsFetchResult1 = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
        
        for (int i=0; i<smartAlbumsFetchResult1.count; i++) {
            
            PHAssetCollection *collection = smartAlbumsFetchResult1[i];
            
            PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
            
            
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.assets addObject:obj];
            }];
            
        }
    } else if (status == PHAuthorizationStatusNotDetermined) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {
                
                PHFetchResult *smartAlbumsFetchResult1 = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
                
                for (int i=0; i<smartAlbumsFetchResult1.count; i++) {
                    
                    PHAssetCollection *collection = smartAlbumsFetchResult1[i];
                    
                    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
                    
                    
                    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        [self.assets addObject:obj];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [self.collectionView reloadData];
                        });
                        
                    }];
                    
                }
                
            }
            
        }];
    }
}


- (JDAsssetToolBar *)assetToolBar {
    
    
    if (!_assetToolBar) {
    
        _assetToolBar = [[JDAsssetToolBar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44)];
        
        [_assetToolBar changeState:NO];
        
        
        __weak typeof(self) weakSelf = self;
        
        _assetToolBar.confirmBlock = ^(UIImage *image){
            
            if (weakSelf.seletedBlock) {
                
                [weakSelf.navigationController popViewControllerAnimated:true];
                
                weakSelf.seletedBlock(image);
            }
        };
        
        
        _assetToolBar.pvBlock = ^(UIImage *image){
  
            JDAssetPreviewViewController *preview = [[JDAssetPreviewViewController alloc] initWithNibName:@"JDAssetPreviewViewController" bundle:nil];
            preview.preImage = image;
            
            preview.selectBlock = ^(UIImage *img) {
                
                if (weakSelf.preBlock) {
                    
                    weakSelf.preBlock(img);
                    
                }
                
            };
            
            [weakSelf.navigationController pushViewController:preview animated:true];
            
        };
        
        
    }
    
    return _assetToolBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.assets count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[JDCollectionViewCell alloc] init];
    }
    
    PHAsset *asset = self.assets[indexPath.item];
    
    CGSize itemSize = [(UICollectionViewFlowLayout *)collectionView.collectionViewLayout itemSize];
    
    CGSize targetSize = CGSizeMake(itemSize.width * [[UIScreen mainScreen] scale], itemSize.height *  [[UIScreen mainScreen] scale]);
    
    PHImageManager *manager = [PHImageManager defaultManager];
    
    // PHImageManagerMaximumSize 当图片很多的时候使用后内存骤降，谨慎使用
    // Size to pass when requesting the original image or the largest rendered image available (resizeMode will be ignored)

    // 下面那个方法contentMode要设置为PHImageContentModeAspectFill,否则图片很模糊，同时option设置为nil
    [manager requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if (result) {
            
            cell.imageView.image = result;
            
        }
    }];
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JDCollectionViewCell *cell = (JDCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.showsOverlayViewWhenSelected = !cell.showsOverlayViewWhenSelected;
    
    if (_lastIndexPath != indexPath) {
        
            
        [cell setupOveryView];

        if (self.seletedImages.count > 0) {
            
            [self.seletedImages removeObjectAtIndex:0];
            
        }
        
        
        [self.seletedImages insertObject:cell.imageView.image atIndex:0];
        
        [self.assetToolBar changeState:YES];
        
        // Get image
        CGSize itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [[UIScreen mainScreen] bounds].size.height);
        PHImageRequestOptions *opt = [PHImageRequestOptions new];
        [opt setDeliveryMode:PHImageRequestOptionsDeliveryModeHighQualityFormat];
        
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestImageForAsset:self.assets[indexPath.row]
                           targetSize:itemSize
                          contentMode:PHImageContentModeAspectFill
                              options:nil
                        resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if(result) {self.assetToolBar.passImage = result;}
        }];
        
        // Deselect previous selected asset
        if (self.lastIndexPath) {
            
            UICollectionViewCell *deselectedCell = [collectionView cellForItemAtIndexPath:self.lastIndexPath];
            
            for (UIView *tempView in deselectedCell.contentView.subviews) {
                
                if ([tempView isKindOfClass:[UIImageView class]]) {
                    
                } else {
                    
                    [tempView removeFromSuperview];
                }
            }
            
        }
        
    } else {
        if (!cell.showsOverlayViewWhenSelected) {
            
            for (UIView *tempView in cell.contentView.subviews) {
                
                if ([tempView isKindOfClass:[UIImageView class]]) {
                    
                } else {
                    
                    [tempView removeFromSuperview];
                }
            }
            
            if (self.seletedImages.count > 0) {
                
                [self.seletedImages removeObjectAtIndex:0];
                
            }
            
            [self.assetToolBar changeState:NO];
            
            
        } else {
            
            [cell setupOveryView];
            
            if (self.seletedImages.count > 0) {
                
                [self.seletedImages removeObjectAtIndex:0];
                
            }
            
            [self.seletedImages insertObject:cell.imageView.image atIndex:0];
            
            [self.assetToolBar changeState:YES];
            
            self.assetToolBar.passImage = cell.imageView.image;
            
            
        }
    }
    
    _lastIndexPath = indexPath;
    
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *deselectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    
    for (UIView *tempView in deselectedCell.contentView.subviews) {

        if ([tempView isKindOfClass:[UIImageView class]]) {

        } else {

            [tempView removeFromSuperview];
        }
    }
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (self.view.frame.size.width- 2.0 * (NUMBER_OF_COLUMNS - 1)) / NUMBER_OF_COLUMNS;
    
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}


@end
