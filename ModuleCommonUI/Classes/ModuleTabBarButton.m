//
//  ModuleTabBarButton.m
//  ModuleCommonUI
//
//  Created by ZZG on 2020/9/24.
//

#import "ModuleTabBarButton.h"
#import "UIView+Addition.h"

@interface ModuleTabBarButton()

@property (nonatomic,strong) UIImageView *barImageView;
@property (nonatomic,strong) UILabel *barTitleLabel;
@property (nonatomic,strong) UIImageView *redPointView;
@property (nonatomic,strong) UIButton *bubbleButton;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIColor *titleNormalColor;
@property (nonatomic,strong) UIColor *titleSelectedColor;
@property (nonatomic,strong) NSString *imageNormalUrl;
@property (nonatomic,strong) NSString *selectedImageUrl;
@property (nonatomic,strong) UIImage *networkNormalImage;
@property (nonatomic,strong) UIImage *networkSelectedImage;
@property (nonatomic,strong) UIImage *defaultNormalImage;
@property (nonatomic,strong) UIImage *defaultSelectedImage;
@property (nonatomic,assign) BOOL imageIsHighlighted;
@property (nonatomic,strong) UILabel *badgeLabel;

@end

@implementation ModuleTabBarButton

- (instancetype)initWithTitle:(NSString *)title
             titleNormalColor:(UIColor *)titleNormalColor
           titleSelectedColor:(UIColor *)titleSelectedColor
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage {
    if (self = [super init]) {
        _titleNormalColor   = titleNormalColor;
        _titleSelectedColor = titleSelectedColor;
        
        _barTitleLabel = [[UILabel alloc] init];
        [_barTitleLabel setText:title];
        [_barTitleLabel setFont:[UIFont systemFontOfSize:10]];
        [_barTitleLabel setTextColor:_titleNormalColor];
        [self addSubview:_barTitleLabel];
        
        
        _barImageView = [[UIImageView alloc] initWithImage:image
                                          highlightedImage:selectedImage];
        _barImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.adjustsImageWhenHighlighted = NO;
        [self addSubview:_barImageView];
        [self addSubview:self.badgeLabel];
        
        self.title = title;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
             titleNormalColor:(UIColor *)titleNormalColor
           titleSelectedColor:(UIColor *)titleSelectedColor
               imageNormalUrl:(NSString *)imageNormalUrl
             selectedImageUrl:(NSString *)selectedImageUrl
                 defaultImage:(UIImage *)defaultImage
         defaultSelectedImage:(UIImage *)defaultSelectedImage {
    if (self = [super init]) {
        
        self.titleNormalColor = titleNormalColor;
        self.titleSelectedColor = titleSelectedColor;
        self.imageNormalUrl = imageNormalUrl;
        self.selectedImageUrl = selectedImageUrl;
        self.defaultNormalImage = defaultImage;
        self.defaultSelectedImage = defaultSelectedImage;
        
        _barTitleLabel = [[UILabel alloc] init];
        [_barTitleLabel setText:title];
        [_barTitleLabel setFont:[UIFont systemFontOfSize:10]];
        //        [_barTitleLabel setTextColor:(self.titleNormalColor)?:GZColorFromRGB(0x5F6670)];
        [self addSubview:_barTitleLabel];
        [self addSubview:_badgeLabel];
        
        _barImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 26)];
        
        //        @weakify(self);
        //        [_barImageView gz_setImageWithURL:[NSURL URLWithString:imageNormalUrl] placeholderImage:defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //            @strongify(self);
        //            self.networkNormalImage = (image && self.networkSelectedImage != defaultSelectedImage)?image:defaultImage;
        //            self.barImageView.size = (image)?CGSizeMake(32, 26):CGSizeMake(24, 24);
        //            self.barImageView.image = (!self.imageIsHighlighted)?self.networkNormalImage:self.networkSelectedImage;
        //            [self setNeedsLayout];
        //        }];
        //
        //        [_barImageView gz_setHighlightedImageWithURL:[NSURL URLWithString:selectedImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //            @strongify(self);
        //            self.networkSelectedImage = (image && self.networkNormalImage != defaultImage)?image:defaultSelectedImage;
        //            self.barImageView.size = (image)?CGSizeMake(32, 26):CGSizeMake(24, 24);
        //            self.barImageView.image = (self.imageIsHighlighted)?self.networkSelectedImage:self.networkNormalImage;
        //            [self setNeedsLayout];
        //        }];
        _barImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.adjustsImageWhenHighlighted = NO;
        [self addSubview:_barImageView];
        
        self.title = title;
    }
    
    return self;
}

#pragma mark - public

// 这里未来还会进行处理
- (void)setGJHighlighted:(BOOL)highlighted {
    // 如果高亮viewocn
    if (highlighted) {
        if (!self.imageNormalUrl) {
            [_barImageView setHighlighted:YES];
        } else {
            _barImageView.image = self.networkSelectedImage;
        }
        [_barTitleLabel setTextColor:(self.titleSelectedColor)];
        self.imageIsHighlighted = YES;
    } else {
        if (!self.imageNormalUrl) {
            [_barImageView setHighlighted:NO];
        } else {
            _barImageView.image = self.networkNormalImage;
        }
        [_barTitleLabel setTextColor:(self.titleNormalColor)];
        self.imageIsHighlighted = NO;
    }
}

- (void)reloadWithTitleNormalColor:(UIColor *)titleNormalColor
                titleSelectedColor:(UIColor *)titleSelectedColor
                             image:(UIImage *)image
                     selectedImage:(UIImage *)selectedImage {
    _titleNormalColor = titleNormalColor;
    _titleSelectedColor = titleSelectedColor;
    _barImageView.image = image;
    _barImageView.highlightedImage = selectedImage;
    _barImageView.highlighted = NO;
    _barImageView.size = image.size;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


#pragma mark -privite

- (UIColor *)titleNormalColor {
    if (!_titleNormalColor) {
        _titleNormalColor = [UIColor redColor];//GZColorFromRGB(0x5F6670);
    }
    return _titleNormalColor;
}

- (UIColor *)titleSelectedColor {
    if (!_titleSelectedColor) {
        _titleSelectedColor = [UIColor redColor];//GZColorFromRGB(0x22ac38);
    }
    return _titleSelectedColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_barTitleLabel sizeToFit];
    float width = roundf(self.frame.size.width/2);
    if (self.imageNormalUrl && self.networkNormalImage != self.defaultNormalImage) {
        _barImageView.centerX = width;
        _barImageView.top = 4;
        _barTitleLabel.centerX = width;
        _barTitleLabel.top = _barImageView.bottom + 4;
        _redPointView.left = _barImageView.right - _redPointView.height/2;
        _redPointView.top = _barImageView.top;
        _badgeLabel.centerY = _barImageView.top + 1;
    } else if (CGSizeEqualToSize(_barImageView.size, CGSizeMake(32, 26))) {
        // 活动换肤的本地图片是 32 * 26 的
        _barImageView.centerX = width;
        _barImageView.top = 4;
        _barTitleLabel.centerX = width;
        _barTitleLabel.top = _barImageView.bottom + 4;
        _redPointView.left = _barImageView.right - _redPointView.height/2;
        _redPointView.top = _barImageView.top;
        _badgeLabel.top = 4;
    } else {
        [_barImageView setCenter:CGPointMake(width, _barImageView.bounds.size.height/2 + 7)];
        [_barTitleLabel setCenter:CGPointMake(width, _barImageView.frame.origin.y + _barImageView.bounds.size.height + 2.5 + _barTitleLabel.bounds.size.height/2)];
        _redPointView.center = CGPointMake(_barImageView.right, _barImageView.top);
        _badgeLabel.centerY = _barImageView.top + 1;
    }
    
    _bubbleButton.left = _barImageView.right - 6;
    _bubbleButton.top = _barImageView.top - 2;
    
    _badgeLabel.centerX = _barImageView.right;
}

- (void)setupRedPointView {
    if (!self.redPointView) {
        _redPointView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
        _redPointView.backgroundColor = [UIColor redColor];//GZCRGBCOLOR(250, 70, 83);
        _redPointView.layer.allowsEdgeAntialiasing = YES;
        _redPointView.layer.cornerRadius = 4;
        _redPointView.contentMode = UIViewContentModeCenter;
        [self addSubview:_redPointView];
    }
    [self layoutIfNeeded];
}

- (void)drawBubbleButtonWithContent:(NSString *)content {
    if (!_bubbleButton) {
        _bubbleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bubbleButton setBackgroundImage:[[UIImage imageNamed:@"channel_bubble"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 8)] forState:UIControlStateNormal];
        [_bubbleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        _bubbleButton.titleLabel.font = HaoCheFont(9);
        _bubbleButton.userInteractionEnabled = NO;
        [self addSubview:_bubbleButton];
    }
    [_bubbleButton setTitle:content forState:UIControlStateNormal];
    [_bubbleButton sizeToFit];
    CGSize contentSize = [content?:@"" sizeWithAttributes:@{NSFontAttributeName:_bubbleButton.titleLabel.font}];
    _bubbleButton.width = contentSize.width + 8;
    
    [self setNeedsLayout];
}

- (void)setBubbleContent:(NSString *)bubbleContent {
    _bubbleContent = bubbleContent;
    
    if (bubbleContent.length > 0) {
        [_redPointView removeFromSuperview];
        _redPointView = nil;
        [self drawBubbleButtonWithContent:bubbleContent];
    } else {
        [_bubbleButton removeFromSuperview];
        _bubbleButton = nil;
    }
}

- (void)setIsShowRedPoint:(BOOL)isShowRedPoint {
    _isShowRedPoint = isShowRedPoint;
    //如果气泡存在，则不显示小红点
    if ((_bubbleButton && !_bubbleButton.hidden)) {
        [_redPointView removeFromSuperview];
        _redPointView = nil;
        return;
    }
    
    if (isShowRedPoint) {
        [self setupRedPointView];
    } else {
        [_redPointView removeFromSuperview];
        _redPointView = nil;
    }
}

- (CGSize)badgeSize {
    return CGSizeMake(12, 12);
}

- (void)setBadgeNumber:(NSInteger)badgeNumber {
    _badgeNumber = badgeNumber;
    _badgeLabel.hidden = badgeNumber <= 0;
    
    NSString *badgeText = [NSString stringWithFormat:@"%zd", badgeNumber];
    if (badgeNumber > 99) {
        badgeText = [NSString stringWithFormat:@"99+"];
    }
    _badgeLabel.text = badgeText;
    CGSize textSize = [badgeText boundingRectWithSize:CGSizeMake(MAXFLOAT, 12) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
    if (badgeNumber < 10) {
        _badgeLabel.size = CGSizeMake([self badgeSize].width, [self badgeSize].height);
    } else {
        _badgeLabel.size = CGSizeMake(ceil(textSize.width) + 4, [self badgeSize].height);
    }
    [self setNeedsLayout];
}

- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self badgeSize].width, [self badgeSize].height)];
        //        _badgeLabel.font = HaoCheFont(10);
        _badgeLabel.textColor = [UIColor whiteColor];
        //        _badgeLabel.backgroundColor = GZCRGBCOLOR(0xfa, 0x46, 0x53);
        _badgeLabel.layer.cornerRadius = [self badgeSize].width/2;
        _badgeLabel.layer.masksToBounds = YES;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.hidden = YES;
    }
    return _badgeLabel;
}

@end
