//
//  DDQOrderCell.m
//
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.
//

#import "DDQOrderCell.h"

#import "DDQOrderProductInfoView.h"

#import "DDQOrderSubCell.h"

@interface DDQOrderCell () <DDQOrderOperationBarDelegate>

@property (nonatomic, strong) DDQOrderProductInfoView *order_infoView;
@property (nonatomic, strong) DDQOrderOperationBar *order_operationBar;

//@property (nonatomic, strong) UILabel *order_priceLabel;
//@property (nonatomic, strong) UILabel *order_countLabel;
//@property (nonatomic, strong) UILabel *order_stateLabel;

@property (nonatomic, assign) DDQViewVHMargin order_defaultMargin;

@end

@implementation DDQOrderCell

- (void)cell_contentViewSubviewsConfig {

    [super cell_contentViewSubviewsConfig];

    self.order_infoView = [[DDQOrderProductInfoView alloc] initViewWithFrame:CGRectZero];
    self.order_infoView.title = @" ";
    self.order_infoView.subTitle = @" ";
    DDQWeakObject(self);
    [self.order_infoView info_didSelectSubCellCompleted:^{
        
        if (weakObjc.delegate && [weakObjc.delegate respondsToSelector:@selector(order_didSelectSubOrderCellWithCell:)]) {
            
            [weakObjc.delegate order_didSelectSubOrderCellWithCell:weakObjc];
            
        }
    }];

    self.order_operationBar = [[DDQOrderOperationBar alloc] initViewWithFrame:CGRectZero];
    self.order_operationBar.delegate = self;

//    UIColor *defaultLabelColor = kSetColor(102.0, 102.0, 102.0, 1.0);
//    UIFont *defaultLabelFont = DDQFont(12.0);
//    self.order_countLabel = [UILabel labelChangeText:@" " font:defaultLabelFont textColor:defaultLabelColor];
//
//    self.order_priceLabel = [UILabel labelChangeText:@" " font:defaultLabelFont textColor:self.defaultBlueColor];
    
//    [self.contentView view_configSubviews:@[self.order_operationBar, self.order_infoView, self.order_priceLabel, self.order_countLabel]];
    [self.contentView view_configSubviews:@[self.order_operationBar, self.order_infoView]];
    
    self.order_defaultMargin = DDQViewVHMarginMaker(12.0 * self.cell_widthRate, self.cell_defaultLeftMargin);
    self.order_operationBar.bar_margin = DDQViewVHMarginMaker(8.0, 12.0);

}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {

    DDQOrderModel *orderModel = model;
//    NSString *count = @"0";
//    int total = 0;
//    for (DDQOrderSubModel *model in orderModel.order_content) {
//
//        total += model.buy_num.intValue;
//    }
//    count = @(total).stringValue;

//    self.order_priceLabel.text = [NSString stringWithFormat:@"%@积分", orderModel.allmoney];
//    self.order_countLabel.text = [NSString stringWithFormat:@"共%@件商品 合计:", count];
    self.order_operationBar.bar_functionTextContainer = orderModel.functions;
    self.order_operationBar.bar_state = orderModel.state;
    self.order_infoView.title = [NSString stringWithFormat:@"订单编号：%@", orderModel.order_number];
    self.order_infoView.subTitle = orderModel.stateName;
    self.order_infoView.info_dataSource = orderModel.order_content;
    
//    if ([orderModel.state isEqualToString:@"2"] || [orderModel.state isEqualToString:@"3"]) {
//
//        self.order_operationBar.hidden = NO;
//
//    }
    
    [super cell_updateDataWithModel:model];
    
}

- (void)cell_updateContentSubviewsFrame {

    autoLayout(self.order_infoView).ddq_leading(self.contentView.leading, 0.0).ddq_top(self.contentView.top, 0.0).ddq_width(self.contentView.width);
    autoLayout(self.order_infoView).ddq_height(self.order_infoView.info_estimateHeight);
//    CGSize maxSize = CGSizeMake(150.0, 20.0);
//    DDQViewVHSpace space = DDQViewVHSpaceMaker(12.0 * self.cell_widthRate, 0.0);
    
//    self.order_priceLabel.auto_layout.rightMargin(self.contentView, self.order_defaultMargin.horMargin).topSpace(self.order_infoView, space.verSpace).boundSize(maxSize);
//
//    self.order_countLabel.auto_layout.rightSpace(self.order_priceLabel, 0.0).centerY(self.order_priceLabel, 0.0).boundSize(maxSize);

    autoLayout(self.order_operationBar).ddq_leading(self.order_infoView.leading, 0.0).ddq_top(self.order_infoView.bottom, 0.0).ddq_size(CGSizeMake(self.order_infoView.width, 44.0));
    
    [super cell_updateContentSubviewsFrame];

}

- (UIView *)cell_layoutBottomControl {
    
    return self.order_operationBar;

}

#pragma mark - FunctionBar Delegate
- (void)operation_didSelectWithType:(DDQOrderOperationType)type {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(order_didSelectFunctionWithType:cell:)]) {

        [self.delegate order_didSelectFunctionWithType:type cell:self];
        
    }
}

@end

@implementation DDQOrderModel

+ (NSArray *)mj_ignoredPropertyNames {
    
    return @[@"functions", @"stateName", @"order_content"];
}

- (NSArray *)model_handlerIgnoredProperty {
    
    return @[@"functions", @"stateName", @"order_content"];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

- (NSDictionary *)model_handlerReplaceProperty {
    
    return @{@"ID":@"id"};
}

@end
