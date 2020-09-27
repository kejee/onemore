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
- (IBAction)didClickButton4:(id)sender {
    [LGCAlertView showAlertWithTitle:@"例行维护通知" message:@"Swift 是一种非常好的编写软件的方式，无论是手机，台式机，服务器，还是其他运行代码的设备。它是一种安全，快速和互动的编程语言，将现代编程语言的精华和苹果工程师文化的智慧，以及来自开源社区的多样化贡献结合了起来。编译器对性能进行了优化，编程语言对开发进行了优化，两者互不干扰，鱼与熊掌兼得。 Swift 对于初学者来说也很友好。它是一门满足工业标准的编程语言，但又有着脚本语言般的表达力和可玩性。它支持代码预览（playgrounds），这个革命性的特性可以允许程序员在不编译和运行应用程序的前提下运行 Swift 代码并实时查看结果。" okTitle:@"我知道了" image:[UIImage imageNamed:@"device_phone_top_icon2"] parentVC:self completion:^(BOOL clicked) {
        NSLog(@"%d", clicked);
    }];
}
@end
