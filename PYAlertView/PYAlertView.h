//
//  PYAlertView.h
//  AlertViewContainer
//
//  Created by TsauPoYuan on 2015/5/25.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP.h>
//#import <IHKeyboardAvoiding.h>
@class PYAlertView;

typedef void (^ButtonTouchUpInsideBlock)(PYAlertView *alertView,NSUInteger buttonIndex);

typedef NS_ENUM(NSUInteger, PYAlertViewAnimation) {
    PYAlertViewAnimationSlideInOut,
    PYAlertViewAnimationZoomInOut
};

@interface PYAlertView : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) NSMutableArray *buttonTitles;
@property (nonatomic, strong) UIView *boxView;

//custom button UI
- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor andTextColor:(UIColor *)textColor andFont:(UIFont*)font andIndex:(NSInteger)index;

- (instancetype)initWithCustomView:(UIView*)containerView andAnimationType:(PYAlertViewAnimation)animationType;

- (void)showWithButtonTouchUpInsideBlock:(ButtonTouchUpInsideBlock)buttonTouchUpInsideBlock withParentView:(UIView*)parentView;

- (void)showWindowWithButtonTouchUpInsideBlock:(ButtonTouchUpInsideBlock)buttonTouchUpInsideBlock;

- (void)close;

@end
