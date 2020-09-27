//
//  LGCAlertView.h
//  pickcolor
//
//  Created by apple on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGCAlertView : UIViewController

+ (void)showAlertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message detailText:(NSString *_Nullable)detailText cancelTitle:(NSString *_Nullable)cancelTitle okTitle:(NSString *_Nullable)okTitle parentVC:(UIViewController *_Nonnull)parentVC completion:(void(^ _Nonnull)(BOOL confirmed))completion;
//second
+ (void)showAlertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message cancelTitle:(NSString *_Nullable)cancelTitle okTitle:(NSString *_Nullable)okTitle parentVC:(UIViewController *_Nonnull)parentVC completion:(void(^_Nonnull)(BOOL confirmed))completion noNoti:(void(^_Nonnull)(BOOL selected))noNotiBlock;
//third
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message okTitle:(NSString *)okTitle image:(UIImage *)image parentVC:(UIViewController *)parentVC completion:(void (^_Nonnull)(BOOL clicked))completion;
@end

NS_ASSUME_NONNULL_END
