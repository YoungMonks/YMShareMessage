//
//  ViewController.m
//  YMShareMessage
//
//  Created by 张江威 on 2017/9/11.
//  Copyright © 2017年 YoungMonk. All rights reserved.
//

#import "ViewController.h"
#import "YMShareManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)shareBtn:(id)sender {
        NSString *title= @"小和尚儿";
        NSString *desc= @"动物之家是一款了解动物的平台，为用户提供各方面的动物介绍。";
        NSString * link= @"https://wap.baidu.com";
    
    
        OSMessage *msg=[[OSMessage alloc]init];
        msg.title= title;
        msg.desc= desc;
        msg.link= link;
        msg.image= [UIImage imageNamed:@"icon"];//缩略图
    
        [[YMShareManager sharedManager]showYMShareViewMessage:msg handler:^(YMShareType type) {
    
            NSLog(@">>>>>>>>分享出去了");
            
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
