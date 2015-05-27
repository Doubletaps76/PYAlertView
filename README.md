##PYAlertView

all animation by using POP

<img src="https://github.com/Doubletaps76/PYAlertView/blob/master/Demo.gif" alt="PYDropMenu Screenshot" width="320" height="568">

##Adding to your project
```
platform :ios, '7'
    pod 'PYAlertView'
```

## Usage

```obj-c

PYAlertView *alertView = [[PYAlertView alloc] initWithCustomView:_customAlertView andAnimationType:PYAlertViewAnimationSlideInOut];
[alertView setButtonTitles:[NSMutableArray arrayWithArray:@[@"Cancel"]]];
[alertView setButtonBackgroundColor:[UIColor lightGrayColor] andTextColor:[UIColor whiteColor] andFont:[UIFont fontWithName:@"Avenir-Light" size:15.0] andIndex:0];

// show in self.view
[alertView showWithButtonTouchUpInsideBlock:^(PYAlertView *alertView, NSUInteger buttonIndex) {
    if (buttonIndex == 0) {
        [alertView close];
    }
} withParentView:self.view];

```