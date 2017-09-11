//
//  YMShareItem.m
//  
//
//  Created by ZZY on 16/3/28.
//
//

#import "YMShareItem.h"

@implementation YMShareItem

+ (instancetype)itemWithTitle:(NSString *)title
                         icon:(NSString *)icon
                     handler:(void (^)())handler
{
    YMShareItem *item = [[YMShareItem alloc] init];
    item.title = title;
    item.icon = icon;
    item.selectionHandler = handler;
    
    return item;
}

@end
