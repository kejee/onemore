//
//  LGCAlert.h
//  pickcolor
//
//  Created by apple on 2020/9/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LGCAlert : NSObject

+ (void)showCustomAlertWithMessage:(NSString *_Nullable)message detailText:(NSString *_Nullable)detailText cancelTitle:(NSString *_Nullable)cancelTitle okTitle:(NSString *_Nullable)okTitle parentVC:(UIViewController *_Nonnull)parentVC completion:(void(^ _Nonnull)(BOOL confirmed))completion;

+ (void)showActionAlertOnParentVC:(UIViewController *_Nonnull)parentVC completion:(void(^ _Nonnull)(BOOL confirmed))completion noNoti:(void(^_Nonnull)(BOOL selected))noNotiBlock;

+ (void)showCustomNoticeAlertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message okTitle:(NSString *_Nonnull)okTitle parentVC:(UIViewController *)parentVC completion:(void (^_Nonnull)(BOOL clicked))completion;

@end

NS_ASSUME_NONNULL_END
