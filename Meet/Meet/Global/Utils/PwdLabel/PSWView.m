//
//  PwdView.m
//  aaa
//
//  Created by 刘家男 on 16/7/8.
//  Copyright © 2016年 刘家男. All rights reserved.
//

#import "PSWView.h"

#define  LableWidh    40
#define  LableHeight  52

#define  SpachMarginX 16

@interface PSWView ()<UITextFieldDelegate>

@property (nonatomic, strong)NSMutableArray *labelMArr;

@property (nonatomic, strong)UITextField *numTextField;

@property (nonatomic, assign) KeyboardType type;

@property BOOL isShow;

@end

@implementation PSWView

- (UITextField *)numTextField
{
    if (!_numTextField) {
        _numTextField = [[UITextField alloc]initWithFrame:self.bounds];
        if (self.type == KeyboardTypeDefault) {
            _numTextField.keyboardType = UIKeyboardTypeASCIICapable;
        }else{
            _numTextField.keyboardType = UIKeyboardTypeNumberPad;
        }
        _numTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _numTextField.textColor = [UIColor clearColor];
        _numTextField.tintColor = [UIColor clearColor];
        [_numTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        _numTextField.delegate = self;
    }
    return _numTextField;
}

- (void)loginWithOldUser:(UITapGestureRecognizer *)sender
{
    if (self.block) {
        self.block(sender.view.tag);
    }
}

- (void)changeLabelColor:(UIColor *)textColor
{
    for (NSInteger i = 0; i < self.labelMArr.count; i ++ ) {
        UILabel *label = self.labelMArr[i];
        label.textColor = textColor;
    }
}

- (NSMutableArray *)labelMArr
{
    if (!_labelMArr) {
        _labelMArr = [NSMutableArray array];
    }
    return _labelMArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame labelNum:1 showPSW:YES keyboarType:self.type];
}

- (instancetype)initWithFrame:(CGRect)frame labelNum:(NSInteger)num showPSW:(BOOL)isShow keyboarType:(KeyboardType)type
{
    
    self.type = type;
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.numTextField];
        self.isShow = isShow;
        for (int i = 0; i < num; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SpachMarginX + LableWidh) *i, 0, LableWidh, LableHeight)];
            label.backgroundColor = [UIColor colorWithHexString:TableViewBackGroundColor];
            label.font = ApplyCodeFont;
            label.textAlignment = NSTextAlignmentCenter;
            label.userInteractionEnabled = YES;
            label.tag = i+1000;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouch:)];
            [label addGestureRecognizer:tap];
            [self.labelMArr addObject:label];
            [self addSubview:label];
        }
        
    }
    return self;
}

- (void)labelTouch:(UIGestureRecognizer *)tap
{
    [self.numTextField becomeFirstResponder];
}

- (void)textFieldChange:(id)sender
{
    for (int i = 0; i < self.labelMArr.count; i++) {
        UILabel *label = self.labelMArr[i];
        if (i < self.numTextField.text.length) {
            //显示密码
            if(self.isShow){
                label.text = [NSString stringWithFormat:@"%c", [self.numTextField.text characterAtIndex:i]];
            }else{
            //隐藏密码
                label.text = @"●";
            }
        } else {
            label.text = @"";
        }
    }
    if (self.numTextField.text.length > 4) {
        self.numTextField.text = [self.numTextField.text substringToIndex:4];
    }
    if ([self.delegate respondsToSelector:@selector(pwdNum:)]) {
        [self.delegate pwdNum:(self.numTextField.text)];
    }
    [self changeLabelColor:[UIColor colorWithHexString:HomeDetailViewNameColor]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.keyBoardPressBlock){
        self.keyBoardPressBlock(textField.text);
    }
    
    if (textField.text.length < 4) {
        [self changeLabelColor:[UIColor colorWithHexString:MeProfileCollectViewItemSelect]];
    }
    
    return YES;
}

@end
