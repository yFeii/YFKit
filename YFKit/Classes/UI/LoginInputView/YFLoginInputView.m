//
//  HGLoginInputView.m
//  HGOrderingMerchant
//
//  Created by GY on 2017/8/30.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import "YFLoginInputView.h"

@interface YFLoginInputView ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *lineLab;
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UIButton *timeBtn;
@end

@implementation YFLoginInputView

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithType:(YFLoginInputViewType)type {

    self = [super init];
    if (self) {
        
        _type = type;
        [self configureUI];
    }
    return self;
}

- (instancetype)init {

    return [self initWithType:YFLoginInputViewTypeDefault];
}

- (void)configureUI {

    self.backView = [[UIView alloc] init];
    [self addSubview:self.backView];
    
    self.inputTextField = [[UITextField alloc] init];
    self.inputTextField.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:_inputTextField];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = UIColorHexMake(@"#E4E7F3");
    [self addSubview:self.lineLab];
    
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.iconBtn setImage:[UIImage imageNamed:@"ico_eye_close"] forState:UIControlStateNormal];
    [self.iconBtn addTarget:self action:@selector(secretInput) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.iconBtn];
    
    self.timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.timeBtn setTitleColor:UIColorHexMake(@"#007eff") forState:UIControlStateNormal];
    self.timeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.timeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.backView addSubview:self.timeBtn];
    [self.timeBtn addTarget:self action:@selector(clickVerifyCodeAction) forControlEvents:UIControlEventTouchUpInside];

    YFLoginInputViewType tempType = self.type;
    self.type = tempType;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}


- (void)setup {
    
    [self.inputTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void)secretInput {

    self.inputTextField.secureTextEntry = !self.inputTextField.secureTextEntry;
    [self.iconBtn setImage:[UIImage imageNamed:self.inputTextField.secureTextEntry?@"ico_eye_close":@"ico_eye_open"] forState:UIControlStateNormal];
}

- (void)clearAction {
    
    self.inputTextField.text = @"";
}

- (void)clickVerifyCodeAction {

    if (self.clickSendVerifyCodeCallBack) {
        
        self.clickSendVerifyCodeCallBack();
    }
}

- (void)setEdit:(BOOL)isEdit {
    
    if (isEdit) {
        
        [self.inputTextField becomeFirstResponder];
    }else{
        
        [self.inputTextField resignFirstResponder];
    }
}
- (void)startTime
{
    self.timeBtn.selected = !self.timeBtn.selected;
    if (self.timeBtn.selected) {
        [self.timeBtn setTitleColor:UIColorHexMake(@"#4179F7") forState:UIControlStateNormal];
        [self getVerificationCodeRunTimeNumber];
    }else {
        [self.timeBtn setTitleColor:UIColorHexMake(@"#4179F7") forState:UIControlStateNormal];
        [self.timeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
}

- (void)setText:(NSString *)text {

    self.inputTextField.text = text;
}

- (NSString *)text {

    return self.inputTextField.text;
}

- (void)textFieldDidChanged:(UITextField *)textField {

    if (self.textFieldChangedCallBack) {
        
        self.textFieldChangedCallBack(textField.text);
    }
}

#pragma mark - UIApplicationDidEnterBackgroundNotification

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    
    UIApplication*  app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid){
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid){
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}

#pragma mark -<private method>
- (void)getVerificationCodeRunTimeNumber
{
    self.timeBtn.enabled = NO;
    __weak typeof(self) _self = self;
    __block NSInteger timeout = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_HIGH);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        __strong typeof(_self) self = _self;
        if (timeout <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self startTime];
                self.timeBtn.enabled = YES;
            });
        }else {
            NSInteger seconds = timeout;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.timeBtn setTitle:[NSString stringWithFormat:@"%.2lds后获取",(long)seconds] forState:UIControlStateNormal];
                self.timeBtn.enabled = NO;
            });
            timeout --;
        }
    });
    dispatch_resume(timer);
}
- (void)setType:(YFLoginInputViewType)type {

    _type = type;
    self.timeBtn.hidden = YES;
    self.iconBtn.hidden = YES;
    self.inputTextField.secureTextEntry = NO;
    switch (type) {
        case YFLoginInputViewTypeSecret:
            
            self.timeBtn.hidden = YES;
            self.iconBtn.hidden = NO;
            self.inputTextField.secureTextEntry = YES;
            self.inputTextField.clearButtonMode = UITextFieldViewModeNever;
            self.inputTextField.keyboardType = UIKeyboardTypeASCIICapable;
            break;
        case YFLoginInputViewTypeVerify:
            
            self.timeBtn.hidden = NO;
            self.iconBtn.hidden = YES;
            self.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            break;
        case YFLoginInputViewTypeDefault:
            
            self.timeBtn.hidden = YES;
            self.iconBtn.hidden = YES;
            self.inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            break;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)setPlaceholder:(NSAttributedString *)placeholder {

    _placeholder = placeholder;
    self.inputTextField.attributedPlaceholder = placeholder;
}

- (void)setLeftMargin:(float)leftMargin {

    _leftMargin = leftMargin;
    if (leftMargin >0) {
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftMargin, 10)];
        self.inputTextField.leftView = leftView;
        self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
    }
}
- (void)layoutSubviews {

    [super layoutSubviews];
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self).with.insets(self.contentEdgeInets);
    }];
    
    [self.inputTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.equalTo(self.backView);
        if (self.type == YFLoginInputViewTypeSecret) {
            
            make.right.equalTo(self.backView.mas_right).with.offset(-1);
        }else if(self.type == YFLoginInputViewTypeVerify){
            
            make.right.equalTo(self.timeBtn.mas_left).with.offset(-10);
        }else{
            
            make.right.equalTo(self.timeBtn.mas_right).with.offset(6);
        }
    }];
    
    [self.lineLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.backView);
        make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.iconBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.backView);
        make.right.equalTo(self.backView.mas_right).with.offset(-2);
    }];
    
    [self.timeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
//        make.size.mas_equalTo(CGSizeMake(110, 36));
        make.centerY.equalTo(self.backView);
        make.right.equalTo(self.backView.mas_right).with.offset(-2);
    }];
}

@end
