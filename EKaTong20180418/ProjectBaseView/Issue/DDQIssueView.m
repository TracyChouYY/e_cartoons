//
//  DDQIssueView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQIssueView.h"

#import "DDQIssueActivityCell.h"
#import "DDQIssueFirstSectionCell.h"
#import "DDQIssueSecondSectionCell.h"

@interface DDQIssueView () <DDQIssueFirstSectionCellDelegate, DDQIssueSecondSectionCellDelegate>

@property (nonatomic, strong) NSMutableArray *issue_imageDataSource;
@property (nonatomic, assign) DDQIssueViewStlye issue_style;

@end

@implementation DDQIssueView

DDQIssueImageDataKey const DDQIssueImageDataIndexKey = @"issue.image.index";
DDQIssueImageDataKey const DDQIssueImageDataImageKey = @"issue.image.image";

- (instancetype)initIssueViewWithStyle:(DDQIssueViewStlye)style {
    
    self.issue_style = style;
    return [super initViewWithFrame:CGRectZero];
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initIssueViewWithStyle:DDQIssueViewStyleBase];
    
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.issue_imageDataSource = [NSMutableArray arrayWithCapacity:5];
    
    //TableView
    [self view_tableViewConfig];
        
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    self.view_subTableView.frame = self.bounds;
    
}

- (void)view_tableViewConfig {
    
    [super view_tableViewConfig];
    
    [self.view_subTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];
    [self.view_subTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];

    DDQWeakObject(self);
    [self.view_subTableView tableView_setFooterHeightConfig:^CGFloat(NSInteger section) {
        
        return (section == 0) ? 0.0 : 84.0;
        
    }];
    
    [self.view_subTableView tableView_setHeaderHeightConfig:^CGFloat(NSInteger section) {
        
        return (section == 0) ? 0.0 : 15.0;
        
    }];
    
    [self.view_subTableView tableView_setHeaderViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        if (section == 0) return nil;
        
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        headerView.contentView.backgroundColor = tableView.defaultViewBackgroundColor;
        return headerView;
        
    }];
    
    [self.view_subTableView tableView_setFooterViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        if (section == 0) return nil;
        
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        footerView.contentView.backgroundColor = tableView.defaultViewBackgroundColor;

        UIButton *button = [footerView.contentView viewWithTag:1];
        if (!button) {
            
            button = [UIButton buttonChangeFont:DDQFont(16.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:@"确认发布" attributeTitle:nil target:self sel:@selector(issue_didSelectSure)];
            button.backgroundColor = self.defaultBlueColor;
            button.layer.cornerRadius = 3.0;
            button.tag = 1;
            [footerView.contentView addSubview:button];

        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsMake(30.0, 15.0 * weakObjc.view_widthRate, 10.0, 15.0 * weakObjc.view_widthRate));
            
        }];
        
        return footerView;
        
    }];
    
    [self.view_subTableView tableView_setRowConfig:^NSInteger(NSInteger section) {
        
        return weakObjc.issue_dataSource[section].count;
        
    }];
    
    [self.view_subTableView tableView_setCellHeightConfig:^CGFloat(NSIndexPath * _Nonnull indexPath) {

        return [DDQCell cell_getCellHeightWithModel:weakObjc.issue_dataSource[indexPath.section][indexPath.row]];
        
    }];
    
    [self.view_subTableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        if (indexPath.section == 0) {
            
            DDQIssueFirstSectionCell *firstCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQIssueFirstSectionCell class])] forIndexPath:indexPath];
            [firstCell first_updateCellStyle:(weakObjc.issue_style == DDQIssueViewStyleBase) ? DDQIssueFirstSectionCellStyleBase : DDQIssueFirstSectionCellStyleActivity];
            [firstCell cell_updateDataWithModel:weakObjc.issue_dataSource[indexPath.section][indexPath.row]];
            firstCell.delegate = weakObjc;
            return firstCell;

        }
        
        DDQIssueSecondSectionCell *cell;
        if (weakObjc.issue_style == DDQIssueViewStyleBase) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQIssueSecondSectionCell class])] forIndexPath:indexPath];

        } else {
            
            cell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQIssueActivityCell class])] forIndexPath:indexPath];

        }
        [cell cell_updateDataWithModel:weakObjc.issue_dataSource[indexPath.section][indexPath.row]];
        cell.delegate = weakObjc;
        return cell;

    }];
}

- (DDQFoundationTableViewLayout *)view_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super view_tableViewLayout];
    
    NSString *const IssueFirstID = @"first.id";
    NSString *const IssueSecondID = @"second.id";
    NSString *secondCellClass = (self.issue_style == DDQIssueViewStyleBase) ? NSStringFromClass([DDQIssueSecondSectionCell class]) : NSStringFromClass([DDQIssueActivityCell class]);
    layout.layout_reuseDataSource = @{NSStringFromClass([DDQIssueFirstSectionCell class]):IssueFirstID,
                                      secondCellClass:IssueSecondID
                                      };
    layout.layout_sectionCount = self.issue_dataSource.count;

    return layout;
    
}

/**
 点击“确认发布”按钮
 */
- (void)issue_didSelectSure {

    if (self.delegate && [self.delegate respondsToSelector:@selector(issue_didSelectSubmiteWithModel:)]) {
     
        DDQIssueDataModel *model = [DDQIssueDataModel mj_objectWithKeyValues:@{}];
        DDQIssueFirstSectionCell *firstCell = [self.view_subTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        model.title = firstCell.first_title;
        model.content1 = firstCell.first_content1;
        model.content2 = firstCell.first_content2;
        
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:5];
        for (id object in firstCell.first_changeImages) {
            
            if ([object isKindOfClass:[DDQIssueFirstImageModel class]]) {
                
                DDQIssueFirstImageModel *imageModel = object;
                [tempArr addObject:imageModel.image_url];
                
            } else if ([object isKindOfClass:[UIImage class]]) {
                
                UIImage *image = object;
                if (image.isDefault) {
                    
                    continue;
                    
                }
                [tempArr addObject:image];
                
            }
        }
        model.changeImages = tempArr.copy;
        model.position = firstCell.first_position;

        DDQIssueSecondSectionCell *secondCell = [self.view_subTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        model.startTime = secondCell.startTime;
        model.endTime = secondCell.endTime;
        model.sort = secondCell.sort;
        model.set = secondCell.setLoction;
        model.price = secondCell.price;
        model.parking = secondCell.parking;
        model.number = secondCell.number;
        
        [self.delegate issue_didSelectSubmiteWithModel:model];
    }
}

- (void)setIssue_dataSource:(NSArray<NSArray<DDQBaseCellModel *> *> *)issue_dataSource {
    
    _issue_dataSource = issue_dataSource;
    
    self.view_subTableViewLayout.layout_sectionCount = _issue_dataSource.count;
    [self.view_subTableView reloadData];
    
}

#pragma mark - First Section Cell Delegate
- (void)first_didSelectLocationWithCell:(DDQIssueFirstSectionCell *)cell {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(issue_didSelectContentPosition:)]) {
        
        [self.delegate issue_didSelectContentPosition:^(NSString * _Nonnull position) {
            
            cell.first_position = position;
            
        }];
    }
}

- (void)first_didSelectPickerImageWithCell:(DDQIssueFirstSectionCell *)cell selectIndexPath:(NSIndexPath *)sIndexPath deselectIndexPath:(NSIndexPath *)dIndexPath defaultImage:(BOOL)isDefault {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(issue_didSelectContentImage:)]) {
        
        DDQWeakObject(self);
        [self.delegate issue_didSelectContentImage:^(UIImage * _Nonnull image) {
            
            [cell first_replaceImage:image index:sIndexPath.row];
            [weakObjc.issue_imageDataSource addObject:image];

        }];
    }
}


#pragma mark - Second Section Cell Delegate
- (void)second_didSelectChoiceStartTimeWithCell:(DDQIssueSecondSectionCell *)cell inputView:(DDQContentInputView *)view {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(issue_didSelectPickerStartTime:)]) {
        
        [self.delegate issue_didSelectPickerStartTime:^(NSString * _Nonnull time) {
            
            view.input_textField.text = time;
            
        }];
    }
}

- (void)second_didSelectChoiceEndTimeWithCell:(DDQIssueSecondSectionCell *)cell inputView:(DDQContentInputView *)view {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(issue_didSelectPickerEndTime:)]) {
        
        [self.delegate issue_didSelectPickerEndTime:^(NSString * _Nonnull time) {
        
            view.input_textField.text = time;
            
        }];
    }
}

- (void)second_didSelectChoiceSortWithCell:(DDQIssueSecondSectionCell *)cell inputView:(DDQContentInputView *)view {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(issue_didSelectSort:)]) {
        
        [self.delegate issue_didSelectSort:^(NSString * _Nonnull sortType) {
            
            view.input_textField.text = sortType;

        }];
    }
}

- (void)second_didSelectChoiceStopLocationWithCell:(DDQIssueSecondSectionCell *)cell inputView:(DDQContentInputView *)view {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(issue_didSelectStopLocation:)]) {
        
        [self.delegate issue_didSelectStopLocation:^(NSString * _Nonnull location) {
            
            view.input_textField.text = location;
            
        }];
    }
}

@end

@implementation DDQIssueDataModel



@end
