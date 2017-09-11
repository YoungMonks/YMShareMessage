//
//  YMShareManager.h
//  YMShare
//
//  Created by 张江威 on 2017/3/14.
//  Copyright © 2017年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenShareHeader.h"

/**
 第三方分享类型
 */
typedef enum : NSUInteger {
    YMShareTypeToFriend, // 好友
    YMShareTypeToYM, // 朋友圈圈
    YMShareTypeToWeixin, // 微信好友
    YMShareTypeToWeixinTimeline, // 微信时间线
    YMShareTypeToQQFriends, // QQ好友
    YMShareTypeToQQZone // QQ空间
} YMShareType;

@interface YMShareManager : NSObject
+ (instancetype)sharedManager;


-(void)showYMShareViewMessage:(OSMessage*)message handler:(void (^)(YMShareType type))handler;
- (void)hideYMShareViewMessage;

#pragma 邀请好友
-(void)showInvitationMessage:(OSMessage*)message index:(NSInteger)index;

@end
