//
//  DDQSuggestionsInputCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSuggestionsInputCell.h"

@interface DDQSuggestionsInputCell () {
    
    NSString *_longTitle;
}

@property (nonatomic, strong) UIView *suggestion_contentView;
@property (nonatomic, strong) UITextView *suggestion_textView;
@property (nonatomic, strong) UILabel *suggestion_placeholderLabel;
@property (nonatomic, strong) UILabel *suggestion_titleLabel;

@property (nonatomic, strong) UIView *suggestion_contactView;
@property (nonatomic, strong) UILabel *suggestion_contactTitleLabel;
@property (nonatomic, strong) UITextField *suggestion_phoneField;

@end

@implementation DDQSuggestionsInputCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.suggestion_contentView = [UIView viewChangeBackgroundColor:[UIColor whiteColor]];
    
    self.suggestion_textView = [[UITextView alloc] initWithFrame:CGRectZero];
    
    self.suggestion_placeholderLabel = [UILabel labelChangeText:@"请输入您的建议。" font:DDQFont(15.0) textColor:kSetColor(156.0, 156.0, 156.0, 1.0)];
    
    _longTitle = @"您每天的反馈我们都会仔细阅读，也可以发送至我们的邮箱\n";
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 5.0;
    NSMutableAttributedString *titleAttr = [[NSMutableAttributedString alloc] initWithString:[_longTitle stringByAppendingString:@"123456@163.com"] attributes:@{NSFontAttributeName:DDQFont(12.0), NSForegroundColorAttributeName:self.suggestion_placeholderLabel.textColor, NSParagraphStyleAttributeName:paragraph}];
    NSRange range = [titleAttr.string rangeOfString:_longTitle];
    [titleAttr addAttribute:NSForegroundColorAttributeName value:self.defaultBlueColor range:NSMakeRange(range.length + range.location, titleAttr.string.length - (range.length + range.location))];
    self.suggestion_titleLabel = [UILabel labelChangeText:@"" font:DDQFont(12.0) textColor:self.suggestion_placeholderLabel.textColor];
    self.suggestion_titleLabel.attributedText = titleAttr;
    
    self.suggestion_contactView = [UIView viewChangeBackgroundColor:[UIColor whiteColor]];
    
    self.suggestion_contactTitleLabel = [UILabel labelChangeText:@"联系方式" font:DDQFont(14.0) textColor:kSetColor(102.0, 102.0, 102.0, 1.0)];
    
    NSAttributedString *placeholderAttr = [[NSAttributedString alloc] initWithString:@"填写您的手机号" attributes:@{NSFontAttributeName:DDQFont(14.0), NSForegroundColorAttributeName:kSetColor(199.0, 199.0, 205.0, 1.0)}];
    self.suggestion_phoneField = [UITextField fieldChangeFont:DDQFont(14.0) textColor:[UIColor blackColor] placeholder:nil attributePlaceholder:placeholderAttr];
    
    [self.suggestion_contentView view_configSubviews:@[self.suggestion_textView, self.suggestion_titleLabel, self.suggestion_placeholderLabel]];
    [self.suggestion_contactView view_configSubviews:@[self.suggestion_contactTitleLabel, self.suggestion_phoneField]];
    [self view_configSubviews:@[self.suggestion_contentView, self.suggestion_contactView]];
    
    self.contentView.backgroundColor = self.defaultViewBackgroundColor;
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.suggestion_contentView).ddq_leading(self.contentView.leading, 0.0).ddq_top(self.contentView.top, 0.0).ddq_width(self.contentView.width);
    
    autoLayout(self.suggestion_textView).ddq_leading(self.suggestion_contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.suggestion_contentView.top, 12.0 * self.cell_widthRate).ddq_size(CGSizeMake(self.contentView.width - self.cell_defaultLeftMargin * 2.0, 190.0 * self.cell_widthRate));
    
    autoLayout(self.suggestion_placeholderLabel).ddq_leading(self.suggestion_textView.leading, 5.0).ddq_top(self.suggestion_textView.top, 15.0).ddq_fitSize();
    
    autoLayout(self.suggestion_titleLabel).ddq_leading(self.suggestion_textView.leading, 0.0).ddq_top(self.suggestion_textView.bottom, 20.0 * self.cell_widthRate).ddq_fitSize();
    
    autoLayout(self.suggestion_contentView).ddq_height(self.suggestion_titleLabel.frameMaxY + 30.0 * self.cell_widthRate);
    
    autoLayout(self.suggestion_contactView).ddq_leading(self.contentView.leading, 0.0).ddq_top(self.suggestion_contentView.bottom, 10.0 * self.cell_widthRate).ddq_width(self.contentView.width);
    
    autoLayout(self.suggestion_contactTitleLabel).ddq_leading(self.suggestion_textView.leading, 0.0).ddq_top(self.suggestion_contactView.top, 15.0 * self.cell_widthRate).ddq_fitSize();
    
    autoLayout(self.suggestion_contactView).ddq_height(self.suggestion_contactTitleLabel.frameMaxY + self.suggestion_contactTitleLabel.y);
    
    autoLayout(self.suggestion_phoneField).ddq_leading(self.suggestion_contactTitleLabel.trailing, self.cell_defaultLeftMargin).ddq_centerY(self.suggestion_contactView.centerY, 0.0).ddq_size(CGSizeMake(self.contentView.width - self.suggestion_phoneField.x - self.cell_defaultLeftMargin, self.suggestion_contactView.height));
    
    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.suggestion_contactView;
    
}

- (CGFloat)cell_bottomMargin {
    
    return 25.0 * self.cell_widthRate;
    
}

@end
