//
//  InterestCollectViewCell.h
//  Demo
//
//  Created by Zhang on 6/1/16.
//  Copyright © 2016 Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewMeetInfoTableViewCell.h"

@interface InterestCollectViewCell : UICollectionViewCell

@property (nonatomic,retain) UIImageView *imageView; // 显示图片
@property (nonatomic,retain) UILabel *titleLabel; // 显示文字

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *titleColor;

- (void)filleCellWithFeed:(NSString *)text type:(CollectionViewItemStyle)type
;

- (void)filleCellSelect:(BOOL)select;

@end
