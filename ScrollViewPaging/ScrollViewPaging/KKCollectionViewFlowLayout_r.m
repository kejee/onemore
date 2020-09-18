//
//  KKCollectionViewFlowLayout_r.m
//  ScrollViewPaging
//
//  Created by apple on 2020/9/18.
//

#import "KKCollectionViewFlowLayout_r.h"
#import <objc/message.h>

@implementation KKCollectionViewFlowLayout_r

- (void)prepareLayout{
    [super prepareLayout];
    
    self.scale = 0.8;
    self.centerOffset = -20;
    
    CGFloat collectionW = CGRectGetWidth(self.collectionView.frame);
    
    self.itemSize = CGSizeMake(collectionW-80, 200);
    
    //line 跟滚动方向相同的间距
    self.minimumLineSpacing = 20.0;
    //item 跟滚动方向垂直的间距
//    self.minimumInteritemSpacing = 0.0;
    
    //屏幕宽去掉中间的cell宽度的大小
    CGFloat contentInset = (collectionW - self.itemSize.width);//collectionW - round(self.itemSize.width * collectionW/375);
    
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, contentInset*0.5, 0, contentInset*0.5);
    
    self.collectionView.pagingEnabled = YES;
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //minimumLineSpacing cell之间的间隔
    if ([self.collectionView respondsToSelector:NSSelectorFromString(@"_setInterpageSpacing:")]) {
        ((void(*)(id,SEL,CGSize))objc_msgSend)(self.collectionView,NSSelectorFromString(@"_setInterpageSpacing:"),CGSizeMake(-(contentInset - self.minimumLineSpacing), 0));
    }
    //让下一页延伸到上一页
    if ([self.collectionView respondsToSelector:NSSelectorFromString(@"_setPagingOrigin:")]) {
        ((void(*)(id,SEL,CGPoint))objc_msgSend)(self.collectionView,NSSelectorFromString(@"_setPagingOrigin:"),CGPointMake(-contentInset*0.5, 0));
    }

//    //防止转屏后cell错位 和后面的放大效果冲突
//    NSIndexPath *firstIndexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
//    [self.collectionView scrollToItemAtIndexPath:firstIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}


/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用 layoutAttributesForElementsInRect:方法
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *设置放大动画
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    /*获取rect范围内的所有subview的UICollectionViewLayoutAttributes*/
//    防止报错先复制attributes
    NSArray *originArr = [super layoutAttributesForElementsInRect:rect];
    NSArray * arr = [[NSArray alloc]initWithArray:originArr copyItems:YES];

    /*动画计算*/
    /*计算屏幕中线*/
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    /*刷新cell缩放*/
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        /*移动的距离和屏幕宽度的的比例*/
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        /*把卡片移动范围固定到 -π/4到 +π/4这一个范围内*/
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        /*设置cell的缩放按照余弦函数曲线越居中越趋近于1*/
        CATransform3D plane_3D = CATransform3DIdentity;
        plane_3D = CATransform3DScale(plane_3D, 1, scale, 1);
        attributes.transform3D = plane_3D;
        
        /// 根据偏移量，重新设置 center
        attributes.center = CGPointMake(attributes.center.x, attributes.center.y + self.centerOffset * apartScale);
    }

    return arr;
    
}



@end
