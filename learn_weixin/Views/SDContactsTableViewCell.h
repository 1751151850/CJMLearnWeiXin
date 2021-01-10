//
//  SDContactsTableViewCell.h
//  learn_weixin
//
//  Created by 蔡佳明 on 2021/1/10.
//

#import <UIKit/UIKit.h>

#import "SDContactModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SDContactsTableViewCell : UITableViewCell

@property (nonatomic, strong) SDContactModel *model;

+ (CGFloat)fixedHeight;

@end

NS_ASSUME_NONNULL_END
