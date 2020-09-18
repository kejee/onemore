//
//  ViewController.m
//  LGCAlertView
//
//  Created by apple on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ViewController.h"
#import "LGCAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didClickButton1:(id)sender {
    [LGCAlertView showAlertWithTitle:@"提示" message:@"Hello,World!" detailText:@"大河向东流" cancelTitle:@"Cancel" okTitle:@"OK" parentVC:self completion:^(BOOL confirmed) {
        NSLog(@"%d", confirmed);
    }];
}
- (IBAction)didClickButton2:(id)sender {
    [LGCAlertView showAlertWithTitle:nil message:@"Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!Hello,World!" detailText:nil cancelTitle:@"退出" okTitle:@"Yes" parentVC:self completion:^(BOOL confirmed) {
        NSLog(@"%d", confirmed);
    }];
}
- (IBAction)didClickButton3:(id)sender {
    [LGCAlertView showAlertWithTitle:nil message:@"大家好" cancelTitle:@"退出" okTitle:@"Yes" parentVC:self completion:^(BOOL confirmed) {
        NSLog(@"%d", confirmed);
    } noNoti:^(BOOL selected) {
        NSLog(@"%d", selected);
    }];
}
@end
