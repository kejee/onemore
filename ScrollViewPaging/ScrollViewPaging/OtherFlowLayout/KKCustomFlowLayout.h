//
//  KKCustomFlowLayout.h
//  pickcolor
//
//  Created by apple on 2020/8/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKCustomFlowLayout : UICollectionViewFlowLayout
- (instancetype)initWithSectionInset:(UIEdgeInsets)insets andMiniLineSapce:(CGFloat)miniLineSpace andMiniInterItemSpace:(CGFloat)miniInterItemSpace andItemSize:(CGSize)itemSize;
@end

NS_ASSUME_NONNULL_END
