

#import "YFPopoverAction.h"

@interface YFPopoverAction ()

@property (nonatomic, strong, readwrite) UIImage *image; ///< 图标
@property (nonatomic, copy, readwrite) NSString *title; ///< 标题
@property (nonatomic, copy, readwrite) void(^handler)(YFPopoverAction *action); ///< 选择回调

@end

@implementation YFPopoverAction

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(YFPopoverAction *action))handler {
    return [self actionWithImage:nil title:title handler:handler];
}

+ (instancetype)actionWithImage:(UIImage *)image title:(NSString *)title handler:(void (^)(YFPopoverAction *action))handler {
    YFPopoverAction *action = [[self alloc] init];
    action.image = image;
    action.title = title ? : @"";
    action.handler = handler ? : NULL;
    
    return action;
}

@end
