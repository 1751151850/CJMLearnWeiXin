//
//  SDChatTableViewCell.h
//  learn_weixin
//
//  Created by 蔡佳明 on 2020/12/29.
//

#import <UIKit/UIKit.h>

#import "MLEmojiLabel.h"

NS_ASSUME_NONNULL_BEGIN
@class SDChatModel;


@interface SDChatTableViewCell : UITableViewCell

@property (nonatomic, strong) SDChatModel *model;

@property (nonatomic, copy) void (^didSelectLinkTextOperationBlock)(NSString *link, MLEmojiLabelLinkType type);

@end

NS_ASSUME_NONNULL_END
