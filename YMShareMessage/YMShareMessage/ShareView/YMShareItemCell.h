//
//  YMShareItemCell.h
//  
//
//  Created by ZZY on 16/3/28.
//
//

#import <UIKit/UIKit.h>
#import "YMShareItem.h"

static NSString *zy_share_item_cell_id = @"YMShareItemCell";

@interface YMShareItemCell : UICollectionViewCell

@property (nonatomic, strong) YMShareItem *item;

@end
