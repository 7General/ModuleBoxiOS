//
//  UIView+UIViewUtils.h
//  HZProgress
//
//  Created by 王会洲 on 16/4/8.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#define hudViewTag                     0x98751235
#import <UIKit/UIKit.h>
#import "MSProgressHUD.h"




typedef enum : NSUInteger {
    HUDCaseDefault, //在头部有圆圈显示
    HUDCaseSucErr, //显示的时候有状态图片
    HUDCaseLabel, //只显示文字内容
    HUDCaseIndeterminate, //菊花转圈
    HUDCaseWhiteLabe, //白底黑字
    HUDCaseETax,    //e税客等待转圈
} HUDCaseEnum;


@interface UIView (UIViewUtils)

/**枚举状态*/
@property (nonatomic, assign) HUDCaseEnum  HUDCase;

/**显示错误信息带角标提示-自动消失*/
-(void)showHUDIndicatorViewSuccessAtCenter:(NSString *)success;

/**显示正确提示带角标提示-自动消失*/
-(void)showHUDIndicatorViewErrorAtCenter:(NSString *)error;

/**显示文字，不带任何图标-自动消失*/
-(void)showHUDIndicatorLabelAtCenter:(NSString *)indiTitle;

/**菊花转，背景为黑色透明*/
-(void)showHUDIndicatorAtCenter:(NSString *)indiTitle;

/*! 白底黑字----自动消失---提示文案 */
-(MSProgressHUD *)showHUDWitheColorAtCenter:(NSString *)title;


//********************************************************************
/**
 网络请求相关提示，网络加载中....

 @param indiTitle 提示标题
 */
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle;


/**隐藏弹层*/
- (void)hideHUDIndicatorViewAtCenter;

- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y;

@end
