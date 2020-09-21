//
//  ParentViewController.m
//  KKSegmentControl
//
//  Created by apple on 2020/9/21.
//

#import "ParentViewController.h"
#import "KKCollectionViewFlowLayout_r.h"
#import "KKSegmentControl.h"
@interface ParentViewController ()<KKCollectionViewFlowLayout_rPageDelegate, KKSegmentControlDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet KKSegmentControl *segmentControl;

@end

@implementation ParentViewController
{
    NSInteger _currentPage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor blackColor];
    
    [self.segmentControl setItems:@[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"] selectedItemIndex:0];
    self.segmentControl.delegate = self;
    self.segmentControl.bridgeScrollView = self.collectionView;
}

- (void)segmentControl:(KKSegmentControl *)segmentControl itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
    
}

- (void)segmentControl:(KKSegmentControl *)segmentControl itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    _currentPage = toIndex;
    self.pageControl.currentPage = _currentPage;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//     [self.segmentControl moveTrackerFollowScrollView:scrollView];
}




















- (KKCollectionViewFlowLayout_r *)flowLayout1 {
    KKCollectionViewFlowLayout_r *flowLayout1 = [[KKCollectionViewFlowLayout_r alloc] init];
    flowLayout1.scale = 0.6;
    flowLayout1.itemSize = CGSizeMake(self.collectionView.bounds.size.width - 90, self.collectionView.bounds.size.height * 0.7);
    flowLayout1.pageDelegate = self;
    return flowLayout1;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.collectionViewLayout = self.flowLayout1;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    self.pageControl.currentPage = _currentPage;
}

- (void)fl_currentPage:(NSInteger)page {
    NSLog(@"%ld", page);
    _currentPage = page;
    self.pageControl.currentPage = _currentPage;
}

- (IBAction)didClickPageControl:(UIPageControl *)sender {
    NSInteger page = sender.currentPage;
    _currentPage = page;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.collectionView) {
        self.pageControl.numberOfPages = 13;
        return 13;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collectionView) {
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item1" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.collectionView) {
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        _currentPage = indexPath.item;
        self.pageControl.currentPage = _currentPage;
    }
}

@end
