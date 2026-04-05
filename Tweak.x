#import <UIKit/UIKit.h>

@interface WBPanelLayout : NSObject
@property(nonatomic, readonly) NSArray *keyViews;
@end

@interface WBT9Panel : UIView
@property(nonatomic, readonly) WBPanelLayout *layout;
@end

@interface WBKeyView : UIView
@property(nonatomic, retain) UIView *subLabel;
@end

%hook WBT9Panel

- (void)layoutSubviews {
    %orig;
    for (WBKeyView *keyView in self.layout.keyViews) {
        keyView.subLabel.hidden = YES;
    }
}

%end
