//
//  YMShareManager.m
//  YMShare
//
//  Created by 张江威 on 2017/3/14.
//  Copyright © 2017年 YM. All rights reserved.
//

#import "YMShareManager.h"
#import "YMShareItem.h"
#import "YMShareView.h"

@interface YMShareManager ()

{
    YMShareView *shareView;
}

@end

@implementation YMShareManager
+ (instancetype)sharedManager {
    static YMShareManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

-(void)showYMShareViewMessage:(OSMessage*)message handler:(void (^)(YMShareType type))handler{

    YMShareItem *item_SX = [YMShareItem itemWithTitle:@"发送给好友"
                                                     icon:@"Action_Friends"
                                                  handler:^{
                                                      if (handler) {
                                                          handler(YMShareTypeToFriend);
                                                      }
                                                  }];

    // 创建代表每个按钮的模型
    YMShareItem *item_TRQ = [YMShareItem itemWithTitle:@"分享到朋友圈"
                                                      icon:@"Action_Melting"
                                                   handler:^{
                                                       if (handler) {
                                                           handler(YMShareTypeToYM);
                                                       }
                                                   }];



    // 创建代表每个按钮的模型
    YMShareItem *item0 = [YMShareItem itemWithTitle:@"发送给朋友"
                                                   icon:@"Action_Share"
                                                handler:^{

                                                    if (handler) {
                                                        handler(YMShareTypeToWeixin);
                                                    }

                                                    if (![message.link containsString:@"rongcloud"]) {
                                                        message.link = [message.link stringByAppendingString:@"&fromType=wechat"];
                                                    }

                                                    [OpenShare shareToWeixinSession:message Success:^(OSMessage *message) {
                                                        NSLog(@"微信分享到会话成功：\n%@",message);
                                                    } Fail:^(OSMessage *message, NSError *error) {
                                                        NSLog(@"微信分享到会话失败：\n%@\n%@",error,message);

                                                    }];
                                                }];

    YMShareItem *item1 = [YMShareItem itemWithTitle:@"分享到朋友圈"
                                                   icon:@"Action_Moments"
                                                handler:^{

                                                    NSLog(@"点击了分享到朋友圈");

                                                    if (handler) {
                                                        handler(YMShareTypeToWeixinTimeline);
                                                    }



                                                    if (![message.link containsString:@"rongcloud"]) {
                                                        message.link = [message.link stringByAppendingString:@"&fromType=wechatTimeline"];
                                                    }

                                                    [OpenShare shareToWeixinTimeline:message Success:^(OSMessage *message) {
                                                        NSLog(@"微信分享到朋友圈成功：\n%@",message);

                                                    } Fail:^(OSMessage *message, NSError *error) {
                                                        NSLog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);

                                                    }];

                                                }];






    YMShareItem *item3 = [YMShareItem itemWithTitle:@"QQ"
                                                   icon:@"Action_QQ"
                                                handler:^{
                                                    NSLog(@"点击了QQ");

                                                    if (handler) {
                                                        handler(YMShareTypeToQQFriends);
                                                    }

                                                    if (![message.link containsString:@"rongcloud"]) {
                                                        message.link = [message.link stringByAppendingString:@"&fromType=qq"];
                                                    }
                                                    [OpenShare shareToQQFriends:message Success:^(OSMessage *message) {
                                                        NSLog(@"分享到QQ好友成功:%@",message);

                                                    } Fail:^(OSMessage *message, NSError *error) {
                                                        NSLog(@"分享到QQ好友失败:%@\n%@",message,error);

                                                    }];

                                                    
                                                }];
    
    YMShareItem *item4 = [YMShareItem itemWithTitle:@"QQ空间"
                                                   icon:@"Action_qzone"
                                                handler:^{

                                                    NSLog(@"点击了QQ空间");

                                                    if (handler) {
                                                        handler(YMShareTypeToQQZone);
                                                    }

                                                    if (![message.link containsString:@"rongcloud"]) {
                                                        message.link = [message.link stringByAppendingString:@"&fromType=qzone"];
                                                    }
                                                    [OpenShare shareToQQZone:message Success:^(OSMessage *message) {
                                                        NSLog(@"分享到QQ空间成功:%@",message);
                                                        
                                                    } Fail:^(OSMessage *message, NSError *error) {
                                                        NSLog(@"分享到QQ空间失败:%@\n%@",message,error);
                                                        
                                                    }];
                                                    
                                                    
                                                    
                                                }];



    NSMutableArray *shareItemsArray = [NSMutableArray array];
    NSMutableArray *functionItemsArray = [NSMutableArray array];
    [shareItemsArray addObject:item_SX];
    [shareItemsArray addObject:item_TRQ];

    if ([OpenShare isWeixinInstalled]) { // 用户安装微信
        [functionItemsArray addObjectsFromArray:@[item0, item1]];
    }
    if ([OpenShare isQQInstalled]) { // 用户安装QQ
        [functionItemsArray addObjectsFromArray:@[item3,item4]];
    }

    // 创建shareView
    shareView = [YMShareView shareViewWithShareItems:shareItemsArray
                                         functionItems:functionItemsArray];

    // 弹出shareView
    [shareView show];

}
- (void)hideYMShareViewMessage{
    [shareView hide];
}

-(void)showInvitationMessage:(OSMessage*)message index:(NSInteger)index{


    switch (index) {
        case 1:
            //qq空间
            message.link = [message.link stringByAppendingString:@"&fromType=qzone"];

            [OpenShare shareToQQZone:message Success:^(OSMessage *message) {
                NSLog(@"分享到QQ空间成功:%@",message);

            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"分享到QQ空间失败:%@\n%@",message,error);

            }];


            break;
        case 2:
            //qq
            message.link = [message.link stringByAppendingString:@"&fromType=qq"];

            [OpenShare shareToQQFriends:message Success:^(OSMessage *message) {
                NSLog(@"分享到QQ好友成功:%@",message);

            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"分享到QQ好友失败:%@\n%@",message,error);

            }];
            break;
        case 3:
            //微信

            [OpenShare shareToWeixinSession:message Success:^(OSMessage *message) {
                NSLog(@"微信分享到会话成功：\n%@",message);

            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"微信分享到会话失败：\n%@\n%@",error,message);

            }];
            break;
        case 4:
            //朋友圈
            message.link = [message.link stringByAppendingString:@"&fromType=wechatTimeline"];

            [OpenShare shareToWeixinTimeline:message Success:^(OSMessage *message) {
                NSLog(@"微信分享到朋友圈成功：\n%@",message);

            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);
                
            }];
            break;
            
        default:
            break;
    }
    
}

- (void)itemAction:(NSString *)title
{
    NSLog(@"%@", title);
}


@end
