//
//  KKCollectionViewFlowLayout_r.h
//  ScrollViewPaging
//
//  Created by apple on 2020/9/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKCollectionViewFlowLayout_r : UICollectionViewFlowLayout

///=============
///宽高缩放比例
///=============
@property (nonatomic ,assign) CGFloat scale;

///=================================
///两边item的中心点偏移量
///默认 centerOffset = 0
///=================================
@property (nonatomic ,assign) CGFloat centerOffset;

@end

NS_ASSUME_NONNULL_END
