//
//  LGCAlertView.m
//  pickcolor
//
//  Created by apple on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LGCAlertView.h"


typedef void(^clickEvent)(BOOL confirmed);

@interface LGCAlertView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;

//second
@property (weak, nonatomic) IBOutlet UIButton *noNotiButton;

@property (nonatomic, copy) NSArray *blockArray;

@end

@implementation LGCAlertView
{
    NSString *_title;
    NSString *_message;
    NSString *_detail;
    NSString *_cancelButtonTitle;
    NSString *_yesButtonTitle;
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message detailText:(NSString *)detailText cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle parentVC:(UIViewController *)parentVC completion:(void (^_Nonnull)(BOOL))completion {
    
    [self showAlertWithTitle:title message:message detailText:detailText cancelTitle:cancelTitle okTitle:okTitle nilName:@"LGCAlertView" parentVC:parentVC BlockArray:@[completion]];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle parentVC:(UIViewController*)parentVC completion:(void(^_Nonnull)(BOOL confirmed))completion noNoti:(void(^_Nonnull)(BOOL selected))noNotiBlock {
    
    [self showAlertWithTitle:title message:message detailText:nil cancelTitle:cancelTitle okTitle:okTitle nilName:@"LGCAlertViewSecond" parentVC:parentVC BlockArray:@[completion, noNotiBlock]];
}



+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message  detailText:(NSString *)detailText cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle nilName:(NSString *)nilName parentVC:(UIViewController *)parentVC BlockArray:(NSArray *)blockArray {
    LGCAlertView *alertView = [[LGCAlertView alloc]initWithNibName:nilName bundle:nil];
    alertView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    alertView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [alertView alertWithTitle:title message:message detailText:detailText cancelTitle:cancelTitle okTitle:okTitle BlockArray:blockArray];
    [parentVC presentViewController:alertView animated:YES completion:nil];
}


- (void)alertWithTitle:(NSString *)title message:(NSString *)message detailText:(NSString *)detailText cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle BlockArray:(NSArray *)blockArray {//completion:(void (^)(BOOL confirmed))completion {
    
    _title = title;
    _message = message;
    _detail = detailText;
    _cancelButtonTitle = cancelTitle;
    _yesButtonTitle = okTitle;

    _blockArray = blockArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    [self setViewConstraintsWithTitle:_title message:_message detailText:_detail cancelTitle:_cancelButtonTitle okTitle:_yesButtonTitle];
}


-(void)setViewConstraintsWithTitle:(NSString *)title message:(NSString *)message detailText:(NSString *)detailText cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle {
    if (!title) {
        self.titleLabel.hidden = YES;
        self.imageView.hidden = YES;
    }
    if (!message) {
        self.messageLabel.hidden = YES;
    }
    if (!_detail) {
        self.detailLabel.hidden = YES;
    }
    if (!cancelTitle) {
        self.cancelButton.hidden = YES;
    }
    if (!okTitle) {
        self.yesButton.hidden = YES;
    }
    self.titleLabel.text = title;
    self.messageLabel.text = message;
    self.detailLabel.text = detailText;
    [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    [self.yesButton setTitle:okTitle forState:UIControlStateNormal];
}

-(IBAction)dismiss:(id)sender {
    clickEvent block = _blockArray[0];
    !block?:block(NO);
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)didClickConfirmButton:(id)sender {
    if (self.noNotiButton) {
        clickEvent block2 = _blockArray[1];
        !block2?:block2(self.noNotiButton.selected);
    }
    
    clickEvent block = _blockArray[0];
    !block?:block(YES);

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didClickNoNotiButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
