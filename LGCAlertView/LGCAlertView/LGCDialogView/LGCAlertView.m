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

//third
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UIButton *okButton;


@property (nonatomic, copy) NSArray *blockArray;

@end

#define CustomNib @"LGCAlertView"
#define SecondNib @"LGCAlertViewSecond"
#define ThirdNib @"LGCAlertViewThird"

@implementation LGCAlertView
{
    NSString *_nibName;
    
    UIImage *_image;
    NSString *_title;
    NSString *_message;
    NSString *_detail;
    NSString *_cancelButtonTitle;
    NSString *_yesButtonTitle;
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message detailText:(NSString *)detailText cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle parentVC:(UIViewController *)parentVC completion:(void (^_Nonnull)(BOOL))completion {
    
    [self showAlertWithTitle:title message:message detailText:detailText cancelTitle:cancelTitle okTitle:okTitle Image:nil NibName:CustomNib parentVC:parentVC BlockArray:@[completion]];
}
//second
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle parentVC:(UIViewController*)parentVC completion:(void(^_Nonnull)(BOOL confirmed))completion noNoti:(void(^_Nonnull)(BOOL selected))noNotiBlock {
    
    [self showAlertWithTitle:title message:message detailText:nil cancelTitle:cancelTitle okTitle:okTitle Image:nil NibName:SecondNib parentVC:parentVC BlockArray:@[completion, noNotiBlock]];
}
//third
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message okTitle:(NSString *)okTitle image:(UIImage *)image parentVC:(UIViewController *)parentVC completion:(void (^_Nonnull)(BOOL clicked))completion {
    
    [self showAlertWithTitle:title message:message detailText:nil cancelTitle:nil okTitle:okTitle Image:image NibName:ThirdNib parentVC:parentVC BlockArray:@[completion]];
}



+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message  detailText:(NSString *)detailText cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle Image:(UIImage *)image NibName:(NSString *)nibName parentVC:(UIViewController *)parentVC BlockArray:(NSArray *)blockArray {
    LGCAlertView *alertView = [[LGCAlertView alloc]initWithNibName:nibName bundle:nil];
    alertView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    alertView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [alertView alertWithTitle:title message:message detailText:detailText cancelTitle:cancelTitle okTitle:okTitle Image:image BlockArray:blockArray NibName:nibName];
    [parentVC presentViewController:alertView animated:YES completion:nil];
}


- (void)alertWithTitle:(NSString *)title message:(NSString *)message detailText:(NSString *)detailText cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle Image:(UIImage *)image BlockArray:(NSArray *)blockArray NibName:(NSString *)nibName {//completion:(void (^)(BOOL confirmed))completion {
    
    _nibName = nibName;
    
    _image = image;
    _title = title;
    _message = message;
    _detail = detailText;
    _cancelButtonTitle = cancelTitle;
    _yesButtonTitle = okTitle;

    _blockArray = blockArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self createUI];
}

- (void)createUI {
    if ([_nibName isEqualToString:CustomNib] || [_nibName isEqualToString:SecondNib]) {
        [self setViewConstraintsWithTitle:_title message:_message detailText:_detail cancelTitle:_cancelButtonTitle okTitle:_yesButtonTitle];
    }
    if ([_nibName isEqualToString:ThirdNib]) {
        [self setViewConstraintsWithTitle:_title message:_message okTitle:_yesButtonTitle Image:_image];
    }
}


- (void)setViewConstraintsWithTitle:(NSString *)title message:(NSString *)message detailText:(NSString *)detailText cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle {
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
//third
- (void)setViewConstraintsWithTitle:(NSString *)title message:(NSString *)message okTitle:(NSString *)okTitle Image:(UIImage *)image{
    if (!image) {
       self.imageView.hidden = YES;
    }
    if (!title) {
        self.titleLabel.hidden = YES;
    }
    if (!message) {
        self.messageTextView.hidden = YES;
    }
    if (!okTitle) {
        self.okButton.hidden = YES;
    }
    self.imageView.image = image;
    self.titleLabel.text = title;
    self.messageTextView.text = message;
    [self.okButton setTitle:okTitle forState:UIControlStateNormal];
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
//second
- (IBAction)didClickNoNotiButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}
//third
- (IBAction)didClickOkButton:(UIButton *)sender {
    clickEvent block = _blockArray[0];
    !block?:block(YES);

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
