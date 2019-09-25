//
//  FIBaseAlertView.m
//  360FI
//
//  Created by Jiansi on 2018/8/25.
//  Copyright © 2018年 Calvien. All rights reserved.
//

#import "YFBaseAlertView.h"

@interface YFBaseAlertView()

@end

@implementation YFBaseAlertView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configureBaseUI];
    }
    return self;
}


- (void)configureBaseUI {
    
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self addSubview:self.backView];
    
    self.contentBackView = [[UIView alloc] init];
    [self addSubview:self.contentBackView];
    

    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 8;
    [self.contentBackView addSubview:self.contentView];
}

- (void)closePrompt {
    
    [self show:NO];
}

- (void)show:(BOOL)isShow {
    
    if (isShow) {
        
        self.backView.alpha = 0;
        self.contentBackView.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.1 animations:^{
            
            self.backView.alpha = 1;
        } completion:^(BOOL finished) {
            
            self.contentBackView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.contentBackView.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                
            }];
        }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.contentBackView.transform = CGAffineTransformMakeScale(0.3, 0.3);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
    }
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
    
    [self.contentBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView);
        make.center.equalTo(self);
    }];
    
  
}





@end
