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

@property (weak, nonatomic) IBOutlet UIButton *noNotiButton;
@property (weak, nonatomic) IBOutlet UIView *botView;

//third
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIImageView *textImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageTextViewHeight;


@property (nonatomic, copy) NSArray *blockArray;

@end

#define CustomNib @"LGCAlertView"
//#define SecondNib @"LGCAlertViewSecond"
#define ThirdNib @"LGCAlertViewThird"

@implementation LGCAlertView
{
    NSString *_nibName;
    
    UIImage *_image;
    NSString *_title;
    NSString *_message;
    NSString *_detail;
    NSString *_cancelButtonTitle;
    NSString *_okButtonTitle;
    
    NSString *_noNotiButtonTitle;
    UIImage *_textImage;
}


+ (void)showCustomAlertWithTitle:(NSString *_Nullable)title
                         message:(NSString *_Nullable)message
                      detailText:(NSString *_Nullable)detailText
                     cancelTitle:(NSString *_Nullable)cancelTitle
                         okTitle:(NSString *_Nullable)okTitle
                     noNotiTitle:(NSString *_Nullable)notiTitle
                        TopImage:(UIImage *_Nullable)image
                        parentVC:(UIViewController *_Nonnull)parentVC
                      completion:(void(^_Nonnull)(BOOL confirmed))completion
                          noNoti:(void(^_Nullable)(BOOL selected))noNotiBlock {
    
    [self showAlertWithTitle:title message:message detailText:detailText cancelTitle:cancelTitle okTitle:okTitle TopImage:image TextImage:nil noNotiTitle:notiTitle NibName:CustomNib parentVC:parentVC BlockArray:noNotiBlock?@[completion, noNotiBlock]:@[completion]];
}
//third
+ (void)showAlertWithTitle:(NSString *_Nullable)title
                   message:(NSString *_Nullable)message
                   okTitle:(NSString *_Nonnull)okTitle
                  TopImage:(UIImage *_Nullable)image
                 TextImage:(UIImage *_Nullable)textImage
               noNotiTitle:(NSString *_Nullable)notiTitle
                  parentVC:(UIViewController *_Nonnull)parentVC
                completion:(void (^_Nonnull)(BOOL clicked))completion
                    noNoti:(void(^_Nullable)(BOOL selected))noNotiBlock {
   
    [self showAlertWithTitle:title message:message detailText:nil cancelTitle:nil okTitle:okTitle TopImage:image TextImage:textImage noNotiTitle:notiTitle NibName:ThirdNib parentVC:parentVC BlockArray:noNotiBlock?@[completion, noNotiBlock]:@[completion]];
}



+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                detailText:(NSString *)detailText
               cancelTitle:(NSString *)cancelTitle
                   okTitle:(NSString *)okTitle
                  TopImage:(UIImage *)image
                 TextImage:(UIImage *)textImage
               noNotiTitle:(NSString *)notiTitle
                   NibName:(NSString *)nibName
                  parentVC:(UIViewController *)parentVC
                BlockArray:(NSArray *)blockArray {
    
    LGCAlertView *alertView = [[LGCAlertView alloc]initWithNibName:nibName bundle:nil];
    alertView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    alertView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [alertView alertWithTitle:title message:message detailText:detailText cancelTitle:cancelTitle okTitle:okTitle Image:image TextImage:textImage noNotiTitle:notiTitle BlockArray:blockArray NibName:nibName];
    [parentVC presentViewController:alertView animated:YES completion:nil];
}


- (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
            detailText:(NSString *)detailText
           cancelTitle:(NSString *)cancelTitle
               okTitle:(NSString *)okTitle
                 Image:(UIImage *)image
             TextImage:(UIImage *)textImage
           noNotiTitle:(NSString *)notiTitle
            BlockArray:(NSArray *)blockArray
               NibName:(NSString *)nibName {//completion:(void (^)(BOOL confirmed))completion {
    
    _nibName = nibName;
    
    _image = image;
    _title = title;
    _message = message;
    _detail = detailText;
    _cancelButtonTitle = cancelTitle;
    _okButtonTitle = okTitle;
    _textImage = textImage;
    _noNotiButtonTitle = notiTitle;
    
    _blockArray = blockArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self createUI];
}

- (void)createUI {
    if ([_nibName isEqualToString:CustomNib]) {
        [self setViewConstraintsWithTitle:_title message:_message detailText:_detail cancelTitle:_cancelButtonTitle okTitle:_okButtonTitle Image:_image noNotiTitle:_noNotiButtonTitle];
//        self.botView.backgroundColor = [UIColor systemGrayColor];
    }
    if ([_nibName isEqualToString:ThirdNib]) {
        [self setViewConstraintsWithTitle:_title message:_message okTitle:_okButtonTitle Image:_image TextImage:_textImage noNotiTitle:_noNotiButtonTitle];
    }
}


- (void)setViewConstraintsWithTitle:(NSString *)title
                            message:(NSString *)message
                         detailText:(NSString *)detailText
                        cancelTitle:(NSString *)cancelTitle
                            okTitle:(NSString *)okTitle
                              Image:(UIImage *)image
                        noNotiTitle:(NSString *)notiTitle{
    
    if (!title) {
        self.titleLabel.hidden = YES;
        self.imageView.hidden = YES;
    }
    if (!message) self.messageLabel.hidden = YES;
    if (!detailText) self.detailLabel.hidden = YES;
    if (!cancelTitle) self.cancelButton.hidden = YES;
    if (!okTitle) self.yesButton.hidden = YES;
    if (!notiTitle) self.noNotiButton.hidden = YES;
    
    self.imageView.image = image;
    self.titleLabel.text = title;
    self.messageLabel.text = message;
    self.detailLabel.text = detailText;
    [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    [self.yesButton setTitle:okTitle forState:UIControlStateNormal];
    [self.noNotiButton setTitle:notiTitle forState:UIControlStateNormal];
}
//third
- (void)setViewConstraintsWithTitle:(NSString *)title
                            message:(NSString *)message
                            okTitle:(NSString *)okTitle
                              Image:(UIImage *)image
                          TextImage:(UIImage *)textImage
                        noNotiTitle:(NSString *)notiTitle {
    
    if (!image) self.imageView.hidden = YES;
    if (!title) self.titleLabel.hidden = YES;
    if (!message) self.messageTextView.hidden = YES;
    if (!okTitle) self.okButton.hidden = YES;
    if (!textImage) self.textImageView.hidden = YES;
    if (!notiTitle) self.noNotiButton.hidden = YES;
    
    self.imageView.image = image;
    self.titleLabel.text = title;
//    self.messageTextView.text = message;
    self.textImageView.image = textImage;
    
    [self.okButton setTitle:okTitle forState:UIControlStateNormal];
    [self.noNotiButton setTitle:notiTitle forState:UIControlStateNormal];
    
    
    NSDictionary *attDict = [self theAttributesWithTextAlignment:NSTextAlignmentLeft];
    
    NSAttributedString *attMessage = [[NSAttributedString alloc] initWithString:message attributes:attDict];
    self.messageTextView.attributedText = attMessage;
    
    CGFloat h = [self heightOfString:message WithAttributes:attDict withWidth:self.messageTextView.frame.size.width];
    self.messageTextViewHeight.constant = h>240?240:h;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat h = [self heightOfString:_message WithAttributes:[self theAttributesWithTextAlignment:NSTextAlignmentLeft] withWidth:self.messageTextView.frame.size.width];
    self.messageTextViewHeight.constant = h>240?240:h;
}


-(IBAction)dismiss:(id)sender {
    clickEvent block = _blockArray[0];
    !block?:block(NO);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)didClickConfirmButton:(id)sender {
    if (_blockArray.count == 2) {
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

//third
- (IBAction)didClickOkButton:(UIButton *)sender {
    clickEvent block = _blockArray[0];
    !block?:block(YES);

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

- (CGFloat)heightOfString:(NSString *)srcString WithAttributes:(NSDictionary *)attributes withWidth:(CGFloat)maxWidth {
    CGSize size = [srcString boundingRectWithSize:CGSizeMake(maxWidth,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.height;
}

- (NSDictionary *)theAttributesWithTextAlignment:(NSTextAlignment)alignment {
    UIFont *dFont = [UIFont systemFontOfSize:14];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3.0; // 设置行间距
    paragraphStyle.alignment = alignment; //设置两端对齐显示
    
    NSDictionary *attributes = @{NSFontAttributeName:dFont, NSParagraphStyleAttributeName:paragraphStyle};
    return attributes;
}

@end
