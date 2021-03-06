//
//  LabelAndTextFieldCell.m
//  Meet
//
//  Created by jiahui on 16/5/4.
//  Copyright © 2016年 Meet. All rights reserved.
//

#import "LabelAndTextFieldCell.h"
#import "CellTextField.h"
#import "Masonry.h"

@interface LabelAndTextFieldCell()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end
@implementation LabelAndTextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lineLabel = [[UILabel alloc] init];
    _lineLabel.backgroundColor = [UIColor colorWithHexString:lineLabelBackgroundColor];
    [self.contentView addSubview:_lineLabel];
    [self updateConstraints];
//    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
//    [_textField setValue:[UIColor colorWithHexString:MeViewProfileContentLabelColorLight] forKeyPath:@"_placeholderLabel.textColor"];

    // Initialization code
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        __weak typeof(self) weakSelf = self;
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).offset(20);
            make.right.equalTo(weakSelf.contentView.mas_right).offset(-20);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(0);
            make.height.offset(0.5);
        }];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
