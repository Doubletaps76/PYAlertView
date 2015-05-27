//
//  ViewController.m
//  PYAlertViewExample
//
//  Created by TsauPoYuan on 2015/5/27.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *customAlertView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat padding = 7;
    _customAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_customAlertView.frame), 30)];
    titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18.0];
    titleLabel.text = @"Title";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(_customAlertView.frame), 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame) + padding, CGRectGetWidth(_customAlertView.frame), 30)];
    contentLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    contentLabel.text = @"This is ContentThis is ContentThis is ContentThis is ContentThis is ContentThis is Content";
    CGFloat labelHeight = [self calculateLabelHeightWithLabel:contentLabel];
    contentLabel.frame = CGRectMake(0, CGRectGetMaxY(line.frame) + padding, CGRectGetWidth(_customAlertView.frame), labelHeight);
    
    _customAlertView.frame = CGRectMake(0, 0, CGRectGetWidth(_customAlertView.frame), CGRectGetMaxY(contentLabel.frame)+padding);
    
    [_customAlertView addSubview:titleLabel];
    [_customAlertView addSubview:line];
    [_customAlertView addSubview:contentLabel];
    [_customAlertView addSubview:contentLabel];
    
    [_slideEffectButton addTarget:self action:@selector(showAlertViewWithSlideAnim) forControlEvents:UIControlEventTouchUpInside];
    [_zoomEffectButton addTarget:self action:@selector(showAlertViewWithZoomAnim) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)showAlertViewWithSlideAnim
{
    PYAlertView *alertView = [[PYAlertView alloc] initWithCustomView:_customAlertView andAnimationType:PYAlertViewAnimationSlideInOut];
    [alertView setButtonTitles:[NSMutableArray arrayWithArray:@[@"Cancel"]]];
    [alertView setButtonBackgroundColor:[UIColor lightGrayColor] andTextColor:[UIColor whiteColor] andFont:[UIFont fontWithName:@"Avenir-Light" size:15.0] andIndex:0];
    
    // show in self.view
    [alertView showWithButtonTouchUpInsideBlock:^(PYAlertView *alertView, NSUInteger buttonIndex) {
        if (buttonIndex == 0) {
            [alertView close];
        }
    } withParentView:self.view];
}

- (void)showAlertViewWithZoomAnim
{
    PYAlertView *alertView = [[PYAlertView alloc] initWithCustomView:_customAlertView andAnimationType:PYAlertViewAnimationZoomInOut];
    [alertView setButtonTitles:[NSMutableArray arrayWithArray:@[@"Cancel",@"Sure"]]];
    [alertView setButtonBackgroundColor:[UIColor lightGrayColor] andTextColor:[UIColor whiteColor] andFont:[UIFont fontWithName:@"Avenir-Light" size:15.0] andIndex:0];
    [alertView setButtonBackgroundColor:[UIColor colorWithRed:81/255.0f green:152/255.0f blue:114/255.0f alpha:1.0] andTextColor:[UIColor whiteColor] andFont:[UIFont fontWithName:@"Avenir-Light" size:15.0] andIndex:1];
    
    //show in window
    [alertView showWindowWithButtonTouchUpInsideBlock:^(PYAlertView *alertView, NSUInteger buttonIndex) {
        if (buttonIndex == 0) {
            [alertView close];
        }else{
            [alertView close];
        }
    }];
}

#pragma mark - Helper Method
- (CGFloat)calculateLabelHeightWithLabel:(UILabel*)label
{
    CGSize size;
    size = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, 1000)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{NSFontAttributeName: label.font}
                                    context:nil].size;
    return size.height;
}
@end
