//
//  PYAlertView.m
//  AlertViewContainer
//
//  Created by TsauPoYuan on 2015/5/25.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import "PYAlertView.h"

#define kButtonHeight 40
#define kCornerRadius 6.0f
#define kPadding 7

@interface PYAlertView ()

@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, assign) PYAlertViewAnimation animationType;
@property (readwrite, copy, nonatomic) ButtonTouchUpInsideBlock buttonTouchUpInsideBlock;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, strong) NSMutableArray *buttonsUI;

@end

@implementation PYAlertView

- (instancetype)initWithCustomView:(UIView*)contentView andAnimationType:(PYAlertViewAnimation)animationType
{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    self = [super initWithFrame:CGRectMake(0, 0, width, height)];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _animationType = animationType;
        _screenWidth = width;
        _screenHeight = height;
        _contentView = contentView;

        
    }
    return self;
}

- (void)createView
{
    if (!_padding) _padding = kPadding;
    
    if (!_cornerRadius) _cornerRadius = kCornerRadius;
    
    if (! _buttonTitles) {
        _buttonTitles = [NSMutableArray arrayWithObject:@"Close"];
    }
    
    if (! _contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(_padding, _padding, _screenWidth*0.8, 150)];
    }
    _contentView.frame = CGRectMake(_padding, _padding, CGRectGetWidth(_contentView.frame), CGRectGetHeight(_contentView.frame));
    
    CGFloat boxViewHeight = CGRectGetHeight(_contentView.frame) + kButtonHeight + _padding*3;
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_contentView.frame)+_padding*2, boxViewHeight)];
    _boxView.center = CGPointMake(_screenWidth/2, _screenHeight/2 - _screenHeight);
    _boxView.alpha = 0;
    _boxView.backgroundColor = [UIColor whiteColor];
    _boxView.layer.cornerRadius = kCornerRadius;
    [_boxView addSubview:_contentView];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBoxView:)];
    [_boxView addGestureRecognizer:_tapGesture];
//    [IHKeyboardAvoiding setAvoidingView:_boxView];
    
    CGFloat buttonY = _padding + CGRectGetHeight(_contentView.frame) + _padding;
    CGFloat buttonWidth = (CGRectGetWidth(_contentView.frame) - _padding*(_buttonTitles.count-1) )/ _buttonTitles.count;
    CGFloat buttonHeight = kButtonHeight;
    int count = 0;
    
    for (NSString *buttonTitle in _buttonTitles) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake( (_padding + buttonWidth)*count + _padding, buttonY, buttonWidth, buttonHeight)];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.7] forState:UIControlStateHighlighted];
        
        if ( ! [_buttonsUI[count] isKindOfClass:[NSNull class]] && _buttonsUI) {
            button.titleLabel.font = _buttonsUI[count][@"Font"];
            button.titleLabel.textColor = _buttonsUI[count][@"TextColor"];
            button.backgroundColor = _buttonsUI[count][@"BackgroundColor"];
        }else{
            button.titleLabel.textColor = [UIColor whiteColor];
            button.backgroundColor = [UIColor lightGrayColor];
        }
        
        button.tag = count;
        button.layer.cornerRadius = kCornerRadius;
        [_boxView addSubview:button];
        count += 1;
    }
    
    [self addSubview:_boxView];
    
}

- (void)tapBoxView:(UITapGestureRecognizer*)tapGesture
{
    [self endEditing:YES];
}

- (void)buttonTouchUpInside:(id)sender
{
    NSLog(@"buttonTouchUpInside!");
    if (_buttonTouchUpInsideBlock) _buttonTouchUpInsideBlock(self,[sender tag]);    
}

- (void)showWithButtonTouchUpInsideBlock:(ButtonTouchUpInsideBlock)buttonTouchUpInsideBlock withParentView:(UIView*)parentView
{
    _buttonTouchUpInsideBlock = buttonTouchUpInsideBlock;
    
    [self createView];

    [parentView addSubview:self];

    [self show];
}

- (void)showWindowWithButtonTouchUpInsideBlock:(ButtonTouchUpInsideBlock)buttonTouchUpInsideBlock
{
    _buttonTouchUpInsideBlock = buttonTouchUpInsideBlock;
    
    [self createView];
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    [self show];
}

- (void)show
{
    //background fadein
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];
    
    if (_animationType == PYAlertViewAnimationSlideInOut) {
        POPBasicAnimation *alphaAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        alphaAnim.toValue = @(1.0);
        
        POPSpringAnimation *positionAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_screenWidth/2, _screenHeight/2 - _screenHeight)];
        positionAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(_screenWidth/2, _screenHeight/2 - _boxView.frame.size.height/6)];
        positionAnim.springBounciness = 5;
        
        [_boxView.layer pop_addAnimation:alphaAnim forKey:@"alphaAnim"];
        [_boxView.layer pop_addAnimation:positionAnim forKey:@"positionAnim"];
        
    }else if (_animationType == PYAlertViewAnimationZoomInOut){
        
        _boxView.center = CGPointMake(_screenWidth/2, _screenHeight/2);
        
        POPBasicAnimation *alphaAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        alphaAnim.toValue = @(1.0);
        
        POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
        scaleAnim.springBounciness = 8;
        
        [_boxView.layer pop_addAnimation:alphaAnim forKey:@"alphaAnim"];
        [_boxView.layer pop_addAnimation:scaleAnim forKey:@"scaleAnim"];
    }
    
}

- (void)close
{
    //background fade out
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }];
    
    if (_animationType == PYAlertViewAnimationSlideInOut) {
        
        POPBasicAnimation *alphaAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        alphaAnim.toValue = @(0.0);
        
        POPSpringAnimation *positionAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(_screenWidth/2, _screenHeight/2 + _screenHeight)];
        positionAnim.springBounciness = 5;
        [positionAnim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            [self removeFromSuperview];
        }];
        
        [_boxView.layer pop_addAnimation:alphaAnim forKey:@"alphaAnim"];
        [_boxView.layer pop_addAnimation:positionAnim forKey:@"positionAnim"];
        
    }else if (_animationType == PYAlertViewAnimationZoomInOut){

        POPBasicAnimation *alphaAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        alphaAnim.toValue = @(0.0);
        
        POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
        [scaleAnim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            [self removeFromSuperview];
        }];
        
        [_boxView.layer pop_addAnimation:alphaAnim forKey:@"alphaAnim"];
        [_boxView.layer pop_addAnimation:scaleAnim forKey:@"scaleAnim"];
    }
}

#pragma mark - Other
- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor andTextColor:(UIColor *)textColor andFont:(UIFont*)font andIndex:(NSInteger)index
{
    if ( ! _buttonsUI) {
        _buttonsUI = [NSMutableArray array];
        for (int i = 0; i < _buttonTitles.count; i++) {
            [_buttonsUI addObject:[NSNull null]];
        }
    }
    
    if (index > _buttonTitles.count -1) {
        return;
    }
    
    NSDictionary *uiDict = @{@"BackgroundColor":buttonBackgroundColor,
                             @"TextColor":textColor,
                             @"Font":font};
    
    _buttonsUI[index] = uiDict;
}

@end
