//
//  UIView+UIViewUtils.m
//  HZProgress
//
//  Created by 王会洲 on 16/4/8.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "UIView+UIViewUtils.h"

@implementation UIView (UIViewUtils)

@dynamic HUDCase;

#pragma mark hud
/**显示错误信息带角标提示 */
-(void)showHUDIndicatorViewErrorAtCenter:(NSString *)error {
    [self showHUDIndicatorViewAtCenter:error icon:@"error" MSPCase:HUDCaseSucErr];
    [self hide:YES afterDelay:1.0];
}

/**显示正确提示带角标提示*/
-(void)showHUDIndicatorViewSuccessAtCenter:(NSString *)success {
    [self showHUDIndicatorViewAtCenter:success icon:@"success" MSPCase:HUDCaseSucErr];
    [self hide:YES afterDelay:1.0];
}

-(void)showHUDIndicatorLabelAtCenter:(NSString *)indiTitle {
    [self showHUDIndicatorViewAtCenter:indiTitle icon:nil MSPCase:HUDCaseLabel];
    [self hide:YES afterDelay:1.0];
}

-(void)showHUDIndicatorAtCenter:(NSString *)indiTitle {
    [self showHUDIndicatorViewAtCenter:indiTitle icon:nil MSPCase:HUDCaseIndeterminate];
}


/**延迟加载控制*/
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(hideDelayed:) withObject:[NSNumber numberWithBool:animated] afterDelay:delay];
}
- (void)hideDelayed:(NSNumber *)animated {
    [self hideHUDIndicatorViewAtCenter];
}


/**
 *  显示标题信息带图片(Base)
 *
 *  @param indiTitle 标题
 *  @param iconStr   提示图片
 */
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle icon:(NSString *)iconStr MSPCase:(HUDCaseEnum)caseEnum
{
    MSProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    if (hud == nil){
        hud = [self createHUDIndicatorViewAtCenter:indiTitle icon:iconStr yOffset:0 MPBCase:caseEnum];
        [hud show:YES];
    }else{
        [self hideHUDIndicatorViewAtCenter];
        hud = [self createHUDIndicatorViewAtCenter:indiTitle icon:iconStr yOffset:0 MPBCase:caseEnum];
        [hud show:YES];
    }
}





// **********************************************************************************

/**
 网络请求相关提示
 
 @param indiTitle 提示标题
 */
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle {
    MSProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    if (hud == nil){
        hud = [self createHUDIndicatorViewAtCenter:indiTitle icon:nil yOffset:0 MPBCase:HUDCaseDefault];
        [hud show:YES];
    }else{
        hud.labelText = indiTitle;
    }
}



/*! 白底黑字----自动消失 */
-(MSProgressHUD *)showHUDWitheColorAtCenter:(NSString *)title {
    MSProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    if (hud == nil){
        hud = [self createHUDIndicatorViewAtCenter:title icon:nil yOffset:0 MPBCase:HUDCaseWhiteLabe];
        [hud show:YES];
    }else{
        hud.labelText = nil;
    }
    [[self getCurrentWindowView] insertSubview:hud atIndex:0];
    [hud hide:YES afterDelay:1.0];
    return hud;
}


/**获取当前window*/
- (UIWindow *)getCurrentWindowView {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    return window;
}

/**默认样式显示提示信息标题，和中间点的偏移*/
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y
{
    MSProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    if (hud == nil){
        hud = [self createHUDIndicatorViewAtCenter:indiTitle icon:nil yOffset:y MPBCase:HUDCaseLabel];
        [hud show:YES];
    }else{
        hud.labelText = indiTitle;
    }
}

/**隐藏弹层*/
- (void)hideHUDIndicatorViewAtCenter {
    MSProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
    [hud hide:YES];
}


/**
 *  改类的基类，用于CreateHUD
 */
- (MSProgressHUD *)createHUDIndicatorViewAtCenter:(NSString *)indiTitle
                                                                                          icon:(NSString *)icon
                                                                                     yOffset:(CGFloat)y
                                                                                MPBCase:(HUDCaseEnum)caseEnum {
    MSProgressHUD *hud = [[MSProgressHUD alloc] initWithView:self];
    hud.layer.zPosition = 10;
    hud.yOffset = y;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = indiTitle;
    
    /**如果有图片名称*/
    if (icon) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MSProgress.bundle/%@", icon]]];
    }
    switch (caseEnum) {
        case HUDCaseDefault:
        {
            // 默认
            hud.mode = MSProgressHUD25X;
            hud.dimBackground = NO;
            hud.color = nil;
            hud.labelColor = [UIColor whiteColor];
        }
            break;
        case HUDCaseSucErr:
        {
            hud.mode = MSProgressHUDICTtitle;
            hud.dimBackground = NO;
            hud.color = nil;
            hud.labelColor = [UIColor whiteColor];
        }
            break;
        case HUDCaseLabel:
        {
            hud.mode = MSProgressHUDModeText;
            hud.dimBackground = NO;
            hud.color = nil;
            hud.labelColor = [UIColor whiteColor];
        }
            break;
        case HUDCaseIndeterminate:
        {
            hud.mode = MSProgressHUDModeIndeterminate;
            hud.dimBackground = YES;
            hud.color = [UIColor whiteColor];
            hud.labelColor = [UIColor blackColor];
        }
            break;
        case HUDCaseETax:
        {
            hud.mode = MSProgressHUDETax;
            hud.dimBackground = NO;
            hud.color = [UIColor whiteColor];
            hud.labelColor = [UIColor blackColor];
        }
            break;
        case HUDCaseWhiteLabe:
        {
            hud.mode = MSProgressHUDModeText;
            hud.dimBackground = NO;
            hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            hud.labelColor = [UIColor whiteColor];
            
        }
            break;
        default:
            break;
    }
    [self addSubview:hud];
    hud.tag = hudViewTag;
    return hud;
}


/**获取HUD对象*/
- (MSProgressHUD *)getHUDIndicatorViewAtCenter {
    UIView *view = [self viewWithTagNotDeepCounting:hudViewTag];
    if (view != nil && [view isKindOfClass:[MSProgressHUD class]]){
        return (MSProgressHUD *)view;
    }
    else
    {
        return nil;
    }
}

- (UIView *)viewWithTagNotDeepCounting:(NSInteger)tag {
    for (UIView *view in self.subviews)
    {
        if (view.tag == tag) {
            return view;
            break;
        }
    }
    return nil;
}
@end
