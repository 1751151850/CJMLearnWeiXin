//
//  SDChatTableViewCell.m
//  learn_weixin
//
//  Created by 蔡佳明 on 2020/12/29.
//

#import "SDChatTableViewCell.h"

#import "UIView+SDAutoLayout.h"
#import "SDChatModel.h"

#define kLabelMargin 20.f
#define kLabelTopMargin 8.f
#define kLabelBottomMargin 20.f

#define kChatCellItemMargin 10.f

#define kChatCellIconImageViewWH 35.f

#define kMaxContainerWidth 220.f
#define kMaxLabelWidth (kMaxContainerWidth - kLabelMargin * 2)

#define kMaxChatImageViewWidth 200.f
#define kMaxChatImageViewHeight 300.f

@interface SDChatTableViewCell () <MLEmojiLabelDelegate>

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *containerBackgroundImageView;
@property (nonatomic, strong) MLEmojiLabel *label;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *messageImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@end

@implementation SDChatTableViewCell

// cell初始化会自动调用
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.selectionStyle = UITableViewCellSelectionStyleNone; // 禁止突出显示
    
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    
    _container = [UIView new];
    [self.contentView addSubview:_container];
    
    _label = [MLEmojiLabel new];
    _label.delegate = self;
    _label.font = [UIFont systemFontOfSize:16.0f];
    _label.numberOfLines = 0; // 不限制行数
    _label.textInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _label.isAttributedContent = YES;
    [_container addSubview:_label];
    
    _messageImageView = [UIImageView new];
    [_container addSubview:_messageImageView];
    
    
    _containerBackgroundImageView = [UIImageView new];
    [_container insertSubview:_containerBackgroundImageView atIndex:0];
    
    _maskImageView = [UIImageView new];
    
    [self setupAutoHeightWithBottomView:_container bottomMargin:0];
    
    // 设置containerBackgroundImageView填充父View
    _containerBackgroundImageView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (void)setModel:(SDChatModel *)model {
    _model = model;
    
    _label.text = model.text;
    self.iconImageView.image = [UIImage imageNamed:model.iconName];
    
    // 根据model设置cell左浮动或者右浮动样式
    [self setMessageOriginWithModel:model];
    
    if (model.imageName) { // 有图片的先设置图片的自动布局
        [self.container clearAutoWidthSettings];
        self.messageImageView.hidden = NO;
        
        self.messageImageView.image = [UIImage imageNamed:model.imageName];
        
        // 根据图片的宽高设置图片约束
        CGFloat standardWidthHeightRatio = kMaxChatImageViewWidth / kMaxChatImageViewHeight;
        CGFloat widthHeightRatio = 0;
        UIImage *image = [UIImage imageNamed:model.imageName];
        CGFloat h = image.size.height;
        CGFloat w = image.size.width;
        
        // 判断width height是否超出最大限制
        if (w > kMaxChatImageViewWidth || h > kMaxChatImageViewHeight) {
            widthHeightRatio = w / h; // 新的宽高标准比
            // 下面是保证image等比例缩放
            if (widthHeightRatio > standardWidthHeightRatio) { // width太大了
                w = kMaxChatImageViewWidth;
                h = w * (image.size.height / image.size.width);
            } else {
                h = kMaxChatImageViewHeight;
                w = h * widthHeightRatio;
            }
        }
        // ssssss
        self.messageImageView.size = CGSizeMake(w, h);
        _container.sd_layout.widthIs(w).heightIs(h);
        
        // 设置container以messageImageView为BottomView高度自适应
        [_container setupAutoHeightWithBottomView:self.messageImageView bottomMargin:kChatCellItemMargin];
        
        // container按照maskImageView 裁剪
        self.container.layer.mask = self.maskImageView.layer;
        
        __weak typeof(self) weakSelf = self;
        [_containerBackgroundImageView setDidFinishAutoLayoutBlock:^(CGRect frame) {
            // 在containerBackgroundImageView的frame确定之后 设置 maskImageView的size
            weakSelf.maskImageView.size = frame.size;
        }];
    } else if(model.text) { // 没有图片有文字的布局
        // 清除展示图片时候用到的mask
        [_container.layer.mask removeFromSuperlayer];
        
        self.messageImageView.hidden = YES;
        
        // 清除展示图片时候_containerBackgroundImageView用到的didFinishAutoLayoutBlock
        _containerBackgroundImageView.didFinishAutoLayoutBlock = nil;
        
        _label.sd_resetLayout
        .leftSpaceToView(_container, kLabelMargin)
        .topSpaceToView(_container, kLabelTopMargin)
        .autoHeightRatio(0); // 设置label纵向自适应
        
        // 设置label横向自适应
        [_label setSingleLineAutoResizeWithMaxWidth:kMaxContainerWidth];
        
        // container以label为rightView宽度自适应
        [_container setupAutoWidthWithRightView:_label rightMargin:kLabelMargin];
        
        // container以label为bottomView高度自适应
        [_container setupAutoHeightWithBottomView:_label bottomMargin:kLabelBottomMargin];
    }
}

- (void)setMessageOriginWithModel:(SDChatModel *)model {
    if (model.messageType == SDMessageTypeSendToOthers) {
        // 发出去的消息设置居右样式
        self.iconImageView.sd_resetLayout
        .rightSpaceToView(self.contentView, kChatCellItemMargin)
        .topSpaceToView(self.contentView, kChatCellItemMargin)
        .widthIs(kChatCellIconImageViewWH)
        .heightIs(kChatCellIconImageViewWH);
        
        _container.sd_resetLayout.topEqualToView(self.iconImageView)
        .rightSpaceToView(self.iconImageView, kChatCellItemMargin);
        
        // stretchableImageWithLeftCapWidth:50 topCapHeight:30 对图片进行拉伸
        _containerBackgroundImageView.image = [[UIImage imageNamed:@"SenderTextNodeBkg"] stretchableImageWithLeftCapWidth:50 topCapHeight:30];
    } else if(model.messageType == SDMessageTypeSendToMe) {
        // 收到的消息是居左样式
        self.iconImageView.sd_resetLayout
        .leftSpaceToView(self.contentView, kChatCellItemMargin)
        .topSpaceToView(self.contentView, kChatCellItemMargin)
        .widthIs(kChatCellIconImageViewWH)
        .heightIs(kChatCellIconImageViewWH);
        
        _container.sd_resetLayout.topEqualToView(self.iconImageView)
        .leftSpaceToView(self.iconImageView, kChatCellItemMargin);
        
        _containerBackgroundImageView.image = [[UIImage imageNamed:@"ReceiverTextNodeBkg"] stretchableImageWithLeftCapWidth:50 topCapHeight:30];
    }
    
    _maskImageView.image = _containerBackgroundImageView.image;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - MLEmojiLabelDelegate

- (void)mlEmojiLabel:(MLEmojiLabel *)emojiLabel didSelectLink:(NSString *)link withType:(MLEmojiLabelLinkType)type
{
    if (self.didSelectLinkTextOperationBlock) {
        self.didSelectLinkTextOperationBlock(link, type);
    }
}
@end
