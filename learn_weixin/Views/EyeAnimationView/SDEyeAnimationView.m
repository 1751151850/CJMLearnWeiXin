//
//  SDEyeAnimationView.m
//  learn_weixin
//
//  Created by 蔡佳明 on 2020/12/28.
//

#import "SDEyeAnimationView.h"

#import "UIView+SDAutoLayout.h"

static const CGFloat KEyeImageViewWidth = 65.0f;
static const CGFloat KEyeImageViewHeight = 44.0f;

@implementation SDEyeAnimationView
{
    UIImageView *_eyeImageView;
    CGFloat _originalY;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _eyeImageView = [UIImageView new];
    _eyeImageView.image = [UIImage imageNamed:@"icon_sight_capture_mask"];
    [self addSubview:_eyeImageView];
    
    _eyeImageView.sd_layout
    .widthIs(KEyeImageViewWidth)
    .heightIs(KEyeImageViewHeight)
    .centerXEqualToView(self)
    .centerYEqualToView(self);
    self.progress = 0.0;
}

- (void)progressAnimationWithProcess:(CGFloat)progress {
    CGFloat eyeViewProgress = MIN(progress, 1);
    CGFloat w = KEyeImageViewWidth * eyeViewProgress;
    CGFloat h = KEyeImageViewHeight;
    if (w < h) {
        h = w;
    }
    CGFloat x = (KEyeImageViewWidth - w) * 0.5;
    CGFloat y = (KEyeImageViewHeight - h) * 0.5;
    CGRect rect = CGRectMake(x, y, w, h);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.path = path.CGPath;
    
    _eyeImageView.layer.mask = mask;
    _eyeImageView.alpha = progress;
    
    if(_originalY == 0) {
        _originalY = self.top;
    }
    CGFloat move = 30 * progress;
    self.top = _originalY + move;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self progressAnimationWithProcess:progress];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
