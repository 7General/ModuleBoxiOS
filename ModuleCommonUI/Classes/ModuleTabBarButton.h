//
//  ModuleTabBarButton.h
//  ModuleCommonUI
//
//  Created by ZZG on 2020/9/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModuleTabBarButton : UIButton

// 显示圆点
@property (nonatomic) BOOL isShowRedPoint;
@property (nonatomic) NSInteger badgeNumber;
//气泡的内容
@property (nonatomic,copy) NSString *bubbleContent;

- (instancetype)initWithTitle:(NSString *)title
             titleNormalColor:(UIColor *)titleNormalColor
           titleSelectedColor:(UIColor *)titleSelectedColor
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage;

- (instancetype)initWithTitle:(NSString *)title
             titleNormalColor:(UIColor *)titleNormalColor
           titleSelectedColor:(UIColor *)titleSelectedColor
               imageNormalUrl:(NSString *)imageNormalUrl
             selectedImageUrl:(NSString *)selectedImageUrl
                 defaultImage:(UIImage *)defaultImage
         defaultSelectedImage:(UIImage *)defaultSelectedImage;


- (void)setGJHighlighted:(BOOL)highlighted;

- (void)reloadWithTitleNormalColor:(UIColor *)titleNormalColor
                titleSelectedColor:(UIColor *)titleSelectedColor
                             image:(UIImage *)image
                     selectedImage:(UIImage *)selectedImage;

@end

NS_ASSUME_NONNULL_END
