//
//  LGCAlert.m
//  pickcolor
//
//  Created by apple on 2020/9/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LGCAlert.h"
#import "LGCAlertView.h"

@implementation LGCAlert

+ (void)showCustomAlertWithMessage:(NSString *_Nullable)message detailText:(NSString *_Nullable)detailText cancelTitle:(NSString *_Nullable)cancelTitle okTitle:(NSString *_Nullable)okTitle parentVC:(UIViewController *_Nonnull)parentVC completion:(void(^ _Nonnull)(BOOL confirmed))completion {

    [LGCAlertView showCustomAlertWithTitle:@"提示" message:message detailText:detailText cancelTitle:cancelTitle okTitle:okTitle noNotiTitle:nil TopImage:[UIImage imageNamed:@"icon"] parentVC:parentVC completion:completion noNoti:nil];
}

+ (void)showActionAlertOnParentVC:(UIViewController *_Nonnull)parentVC completion:(void(^ _Nonnull)(BOOL confirmed))completion noNoti:(void(^_Nonnull)(BOOL selected))noNotiBlock {

    [LGCAlertView showCustomAlertWithTitle:@"提示" message:@"是否去控制设备?" detailText:nil cancelTitle:@"取消" okTitle:@"确定" noNotiTitle:@"今日不再提示" TopImage:[UIImage imageNamed:@"icon"] parentVC:parentVC completion:completion noNoti:noNotiBlock];
}

//eg:例行维护通知
+ (void)showCustomNoticeAlertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message okTitle:(NSString *_Nonnull)okTitle parentVC:(UIViewController *)parentVC completion:(void (^_Nonnull)(BOOL clicked))completion {

    [LGCAlertView showAlertWithTitle:title message:message okTitle:okTitle TopImage:[UIImage imageNamed:@"device_phone_top_icon2"] TextImage:nil noNotiTitle:nil parentVC:parentVC completion:completion noNoti:nil];
}

@end
