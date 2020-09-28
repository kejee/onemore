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


+ (void)showCustomAlertWithTitle:(NSString *_Nullable)title
                         message:(NSString *_Nullable)message
                      detailText:(NSString *_Nullable)detailText
                     cancelTitle:(NSString *_Nullable)cancelTitle
                         okTitle:(NSString *_Nullable)okTitle
                     noNotiTitle:(NSString *_Nullable)notiTitle
                        TopImage:(UIImage *_Nullable)image
                        parentVC:(UIViewController *_Nonnull)parentVC
                      completion:(void(^_Nonnull)(BOOL confirmed))completion
                          noNoti:(void(^_Nullable)(BOOL selected))noNotiBlock;
//third
+ (void)showAlertWithTitle:(NSString *_Nullable)title
                   message:(NSString *_Nullable)message
                   okTitle:(NSString *_Nonnull)okTitle
                  TopImage:(UIImage *_Nullable)image
                 TextImage:(UIImage *_Nullable)textImage
               noNotiTitle:(NSString *_Nullable)notiTitle
                  parentVC:(UIViewController *_Nonnull)parentVC
                completion:(void (^_Nonnull)(BOOL clicked))completion
                    noNoti:(void(^_Nullable)(BOOL selected))noNotiBlock;
@end

NS_ASSUME_NONNULL_END
