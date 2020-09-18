//
//  KKCustomFlowLayout.m
//  pickcolor
//
//  Created by apple on 2020/8/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import "KKCustomFlowLayout.h"
@interface KKCustomFlowLayout ()

@property (nonatomic, assign) UIEdgeInsets sectionInsets;
@property (nonatomic, assign) CGFloat miniLineSpace;
@property (nonatomic, assign) CGFloat miniInterItemSpace;
@property (nonatomic, assign) CGSize eachItemSize;
@property (nonatomic, assign) BOOL scrollAnimation;/**<是否有分页动画*/
@property (nonatomic, assign) CGPoint lastOffset;/**<记录上次滑动停止时contentOffset值*/
@end

@implementation KKCustomFlowLayout

/*初始化部分*/
- (instancetype)initWithSectionInset:(UIEdgeInsets)insets andMiniLineSapce:(CGFloat)miniLineSpace andMiniInterItemSpace:(CGFloat)miniInterItemSpace andItemSize:(CGSize)itemSize
{
    self = [self init];
    if (self) {
        //基本尺寸/边距设置
        self.sectionInsets = insets;
        self.miniLineSpace = miniLineSpace;
        self.miniInterItemSpace = miniInterItemSpace;
        self.eachItemSize = itemSize;
        
        self.scrollAnimation = YES;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lastOffset = CGPointZero;
    }
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;// 水平滚动
    /*设置内边距*/
    self.sectionInset = _sectionInsets;
    self.minimumLineSpacing = _miniLineSpace;
    self.minimumInteritemSpacing = _miniInterItemSpace;
    self.itemSize = _eachItemSize;
    /**
     * decelerationRate系统给出了2个值：
     * 1. UIScrollViewDecelerationRateFast（速率快）
     * 2. UIScrollViewDecelerationRateNormal（速率慢）
     * 此处设置滚动加速度率为fast，这样在移动cell后就会出现明显的吸附效果
     */
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
}

/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat pageSpace = [self stepSpace];//计算分页步距
    CGFloat offsetMax = self.collectionView.contentSize.width - (pageSpace + self.sectionInset.right + self.miniLineSpace);
    CGFloat offsetMin = 0;
    /*修改之前记录的位置，如果小于最小contentsize或者大于最大contentsize则重置值*/
    if (_lastOffset.x<offsetMin)
    {
        _lastOffset.x = offsetMin;
    }
    else if (_lastOffset.x>offsetMax)
    {
        _lastOffset.x = offsetMax;
    }
    
    CGFloat offsetForCurrentPointX = ABS(proposedContentOffset.x - _lastOffset.x);//目标位移点距离当前点的距离绝对值
    CGFloat velocityX = velocity.x;
    BOOL direction = (proposedContentOffset.x - _lastOffset.x) > 0;//判断当前滑动方向,手指向左滑动：YES；手指向右滑动：NO
    
    if (offsetForCurrentPointX > pageSpace/8. && _lastOffset.x>=offsetMin && _lastOffset.x<=offsetMax)
    {
        NSInteger pageFactor = 0;//分页因子，用于计算滑过的cell个数
        if (velocityX != 0)
        {
            /*滑动*/
            pageFactor = ABS(velocityX);//速率越快，cell滑过数量越多
        }
        else
        {
            /**
             * 拖动
             * 没有速率，则计算：位移差/默认步距=分页因子
             */
            pageFactor = ABS(offsetForCurrentPointX/pageSpace);
        }

        /*设置pageFactor上限为2, 防止滑动速率过大，导致翻页过多*/
        pageFactor = pageFactor<1?1:(pageFactor<3?1:2);

        CGFloat pageOffsetX = pageSpace*pageFactor;
        proposedContentOffset = CGPointMake(_lastOffset.x + (direction?pageOffsetX:-pageOffsetX), proposedContentOffset.y);
    }
    else
    {
        /*滚动距离，小于翻页步距一半，则不进行翻页操作*/
        proposedContentOffset = CGPointMake(_lastOffset.x, _lastOffset.y);
    }

    //记录当前最新位置
    _lastOffset.x = proposedContentOffset.x;
    return proposedContentOffset;
}

/**
 *计算每滑动一页的距离：步距
 */
-(CGFloat)stepSpace
{
    return self.eachItemSize.width + self.miniLineSpace;
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
 *防止报错先复制attributes
 */
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes
{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

/**
 *设置放大动画
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    /*获取rect范围内的所有subview的UICollectionViewLayoutAttributes*/
    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];

    /*动画计算*/
    if (self.scrollAnimation)
    {
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
        }
    }
    return arr;
}




/**
 * 准备操作：一般在这里设置一些初始化参数
 */
//- (void)prepareLayout
//{
//    // 必须要调用父类(父类也有一些准备操作)
//    [super prepareLayout];
//    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
////    // 设置滚动方向(只有流水布局才有这个属性)
////    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
////
////    // 设置cell的大小
////    CGFloat itemWH = self.collectionView.frame.size.height * 0.8;
////    self.itemSize = CGSizeMake(itemWH, itemWH);
////
////    // 设置内边距
////    CGFloat inset = (self.collectionView.frame.size.width - itemWH) * 0.5;
////    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
//}



/**
 * 决定了cell怎么排布
 */
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    // 调用父类方法拿到默认的布局属性
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//
//    // 获得collectionView最中间的x值
////    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
//
////    // 在默认布局属性基础上进行微调
////    for (UICollectionViewLayoutAttributes *attrs in array) {
////        // 计算cell中点x 和 collectionView最中间x值  的差距
////        CGFloat delta = ABS(centerX - attrs.center.x);
////
////        // 利用差距计算出缩放比例（成反比）
////        CGFloat scale = 1 - delta / (self.collectionView.frame.size.width + self.itemSize.width);
////        attrs.transform = CGAffineTransformMakeScale(scale, scale);
////        //        attrs.transform3D = CATransform3DMakeRotation(scale * M_PI_4, 0, 1, 1);
////    }
//
////    for (UICollectionViewLayoutAttributes *attr in array) {
////        // 3.1 计算每个cell的中心点距离
////        CGFloat distance = ABS(attr.center.x - centerX);
////
////        // 3.2 距离越大，缩放比越小，距离越小，缩放比越大
////        CGFloat factor = 0.001;
////        CGFloat scale = 1 / (1 + distance * factor);
////        attr.transform = CGAffineTransformMakeScale(scale, scale);
//
////    }
//
//     // 闪屏现象解决参考 ：https://blog.csdn.net/u013282507/article/details/53103816
//        //扩大控制范围，防止出现闪屏现象
//        rect.size.width = rect.size.width + self.collectionView.frame.size.width;
//        rect.origin.x = rect.origin.x - self.collectionView.frame.size.width/2;
//
//        // 让父类布局好样式
//        NSArray *arr = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
//
//
//        for (UICollectionViewLayoutAttributes *attributes in arr) {
//            CGFloat scale;
//    //        scale = 1.0;
//
//            // collectionView 的 centerX
//            CGFloat centerX = self.collectionView.center.x;
//            CGFloat step = ABS(centerX - (attributes.center.x - self.collectionView.contentOffset.x));
//            NSLog(@"step %@ : attX %@ - offset %@", @(step), @(attributes.center.x), @(self.collectionView.contentOffset.x));
//            scale = fabsf(cosf(step/centerX * M_PI/5));
//
//            attributes.transform = CGAffineTransformMakeScale(scale, scale);
//        }
//
//
//
//    return array;
//}
//
///**
// * 当uicollectionView的bounds发生改变时，是否要刷新布局
// */
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}

/**
 * targetContentOffset ：通过修改后，collectionView最终的contentOffset(取决定情况)
 * proposedContentOffset ：默认情况下，collectionView最终的contentOffset
 */
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    // 计算最终的可见范围
//    CGRect rect;
////    rect.origin = proposedContentOffset;
//    rect.origin.y = 0;
//    rect.origin.x = proposedContentOffset.x;
//    rect.size = self.collectionView.frame.size;
//
//    // 取得cell的布局属性
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//
//    // 计算collectionView最终中间的x
//    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
//
//    // 计算最小的间距值
//    CGFloat minDetal = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attrs in array) {
//        if (ABS(minDetal) > ABS(attrs.center.x - centerX)) {
//            minDetal = attrs.center.x - centerX;
//        }
//    }
//
//    // 在原有offset的基础上进行微调
//    proposedContentOffset.x += minDetal;
//    return proposedContentOffset;
//
//}
@end



