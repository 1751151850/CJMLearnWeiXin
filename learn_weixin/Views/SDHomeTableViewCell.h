//
//  SDHomeTableViewCell.h
//  learn_weixin
//
//  Created by 蔡佳明 on 2020/12/28.
//

#import <UIKit/UIKit.h>

@class SDHomeTableViewCellModel;

NS_ASSUME_NONNULL_BEGIN

@interface SDHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) SDHomeTableViewCellModel *model;

+ (CGFloat)fixedHeight;

@end

NS_ASSUME_NONNULL_END
