//
//  ViewController.m
//  ScrollViewPaging
//
//  Created by apple on 2020/9/18.
//

#import "ViewController.h"
#import "KKCustomFlowLayout.h"
#import "BSLooper3DFlowLayout.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView1;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView2;
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
        cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
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
    NSIndexPath *firstIndexPath = [[collectionView indexPathsForVisibleItems] firstObject];
    
//    NSLog(@"current index:%ld", firstIndexPath.item);
    NSLog(@"current index:%@", [collectionView indexPathsForVisibleItems]);
    
}

@end
