//
//  SDChatModel.h
//  learn_weixin
//
//  Created by 蔡佳明 on 2020/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SDMessageTypeSendToOthers,
    SDMessageTypeSendToMe
} SDMessageType;


@interface SDChatModel : NSObject

@property (nonatomic, assign) SDMessageType messageType;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *imageName;

@end

NS_ASSUME_NONNULL_END
