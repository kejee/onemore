//
//  KKCollectionViewFlowLayout_r.h
//  ScrollViewPaging
//
//  Created by apple on 2020/9/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KKCollectionViewFlowLayout_rPageDelegate <NSObject>
- (void)fl_currentPage:(NSInteger)page pageWidth:(CGFloat)pWidth;
@end

@interface KKCollectionViewFlowLayout_r : UICollectionViewFlowLayout
//滚动方向item间隔
@property (nonatomic, assign) CGFloat lineSpace;
//默认居中，0.5。<0.5偏左，>0.5偏右
@property (nonatomic, assign) CGFloat leftOffsetPer;


//宽高缩放比例
@property (nonatomic ,assign) CGFloat scale;
//两边item的中心点偏移量 默认 centerOffset = 0
@property (nonatomic ,assign) CGFloat centerOffset;


@property (nonatomic, weak) id<KKCollectionViewFlowLayout_rPageDelegate> pageDelegate;

@end

NS_ASSUME_NONNULL_END
