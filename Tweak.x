#import <UIKit/UIKit.h>

%hook WXK26KeyPinyinKeyView
// 拦截数字/符号小标绘制，不影响按键点击、上滑核心功能
- (void)drawRect:(CGRect)rect {
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"WXKKeyBadgeLabel")]) {
            subview.hidden = YES;
            subview.alpha = 0;
        }
    }
    %orig;
}

// 强制保留上滑输入数字/符号能力，防止页面刷新失效
- (BOOL)canSwipeToInput {
    return YES;
}

// 阻断小标文本赋值，彻底拦截标识渲染
- (void)setBadgeText:(NSString *)text {
    return;
}
%end

%hook WXK26KeyLayoutView
// 布局时二次清理所有小标，防止键盘切换/刷新后重新显示
- (void)layoutSubviews {
    %orig;
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"WXKKeyBadgeLabel")]) {
            [subview removeFromSuperview];
        }
    }
}
%end

%hook WXKKeyBadgeLabel
// 全局兜底，所有小标标签默认隐藏，兼容全场景26键布局
- (id)initWithFrame:(CGRect)frame {
    self = %orig;
    if (self) {
        self.hidden = YES;
        self.alpha = 0;
    }
    return self;
}
%end
