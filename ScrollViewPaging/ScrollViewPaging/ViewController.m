//
//  ViewController.m
//  ScrollViewPaging
//
//  Created by apple on 2020/9/18.
//

#import "ViewController.h"
#import "KKCustomFlowLayout.h"
#import "BSLooper3DFlowLayout.h"
#import "KKCollectionViewFlowLayout_r.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, KKCollectionViewFlowLayout_rPageDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView1;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView2;

@property (nonatomic, strong) KKCollectionViewFlowLayout_r *flowLayout1;

//@property (nonatomic, strong) KKCustomFlowLayout *flowLayout;
@property (nonatomic, strong) BSLooper3DFlowLayout *flowLayout2;


@end

@implementation ViewController
{
    CGSize _itemSize;
    CGFloat _itemSpace;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.flowLayout1 = [[KKCollectionViewFlowLayout_r alloc] init];
    self.flowLayout1.scale = 0.6;
    self.flowLayout1.itemSize = CGSizeMake(self.collectionView1.bounds.size.width - 90, self.collectionView1.bounds.size.height * 0.7);
    self.flowLayout1.pageDelegate = self;
    
    self.collectionView1.collectionViewLayout = self.flowLayout1;
    self.collectionView1.backgroundColor = [UIColor blackColor];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    _itemSpace = 10;
//    _itemSize = CGSizeMake(self.collectionView2.bounds.size.width-80, self.collectionView2.bounds.size.height/2);
//    CGFloat margin = (self.collectionView2.bounds.size.width - _itemSize.width)/2;
//    _flowLayout = [[KKCustomFlowLayout alloc] initWithSectionInset:UIEdgeInsetsMake(0, margin, 0, margin) andMiniLineSapce:_itemSpace andMiniInterItemSpace:0 andItemSize:_itemSize];
//
//    self.collectionView2.collectionViewLayout = _flowLayout;
    [self resetCollectionView];
}

-(void)resetCollectionView{
    
    
    
    
    self.flowLayout2 = [[BSLooper3DFlowLayout alloc]init];
//    self.flowLayout2.itemSize = self.itemSize;
//    self.flowLayout2.minimumLineSpacing = self.minimumLineSpacing;
//    self.flowLayout.minimumInteritemSpacing = self.minimumInteritemSpacing;
    self.flowLayout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.flowLayout2.sectionInset = self.sectionInset;
    self.flowLayout2.scale = 0.6;
    self.flowLayout2.centerOffset = -30;
    self.collectionView2.collectionViewLayout = self.flowLayout2;
//    self.collectionView2.pagingEnabled = YES;
    
    self.collectionView2.backgroundColor = [UIColor systemTealColor];
}

- (void)fl_currentPage:(NSInteger)page {
    NSLog(@"%ld", page);
}








- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.collectionView1 || collectionView == self.collectionView2) {
        return 13;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collectionView1 || collectionView == self.collectionView2) {
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item1" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.collectionView1 || collectionView == self.collectionView2) {
//        NSLog(@"index:%ld", indexPath.item);
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获取当前显示的cell的下标
//    NSIndexPath *firstIndexPath = [[collectionView indexPathsForVisibleItems] firstObject];
    
//    NSLog(@"current index:%ld", firstIndexPath.item);
//    NSLog(@"current index:%@", [collectionView indexPathsForVisibleItems]);
    
    
    NSLog(@"collectionView.contentOffset.x:%f", collectionView.contentOffset.x);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"will display index:%@", indexPath);
}
@end
