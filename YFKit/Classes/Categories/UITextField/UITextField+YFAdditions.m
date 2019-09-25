//
//  UITextField+HGAdditions.m
//  HGOrderingMerchant
//
//  Created by ShiGY on 2017/10/24.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import "UITextField+YFAdditions.h"
#import "objc/runtime.h"

@implementation UITextField (YFAdditions)

- (void)textFieldDidChanged:(UITextField *)textField {
    
    CGFloat maxLength = self.maxInputCount;
    NSString *toBeString = textField.text;

    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position || !selectedRange) {
        
        if (toBeString.length > maxLength){
            
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1){
                
                NSString *tempStr = [toBeString substringToIndex:maxLength];
                textField.text = [tempStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            }else{
                
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                NSString *tempStr = [toBeString substringWithRange:rangeRange];
                textField.text = [tempStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
        }else{
            textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
    }
}


- (void)setMaxInputCount:(NSInteger)maxInputCount {

    objc_setAssociatedObject(self, @selector(maxInputCount), @(maxInputCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!self.isMonitoring) {
        [self addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        self.isMonitoring = YES;
    }
}


- (NSInteger)maxInputCount {
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setIsMonitoring:(BOOL)isMonitoring {
    
    objc_setAssociatedObject(self, @selector(isMonitoring), @(isMonitoring), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isMonitoring {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
@end
