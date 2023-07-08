//
//  RCSightCollectionViewCell.h
//  RongIMKit
//
//  Created by zhaobindong on 2017/5/3.
//  Copyright © 2017年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCMessageModel;

@protocol RCDestructSightCollectionCellDelegate <NSObject>
@optional
- (void)closeSight;

- (void)playEnd;

- (void)sightLongPressed:(NSString *)localPath;

@end

@interface RCDestructSightCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, weak) id<RCDestructSightCollectionCellDelegate> delegate;

@property (nonatomic, assign, getter=isAutoPlay) BOOL autoPlay;

- (void)setDataModel:(RCMessageModel *)model;

- (void)stopPlay;

- (void)resetPlay;

@end
