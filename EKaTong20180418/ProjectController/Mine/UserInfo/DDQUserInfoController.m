//
//  DDQUserInfoController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/24.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQUserInfoController.h"

#import "DDQVerifiedController.h"
#import "DDQBirthDateController.h"
#import "DDQProfessionController.h"

#import "DDQUserInfoHeaderView.h"

#import "DDQUserInfoSexCell.h"
#import "DDQUserInfoNameCell.h"
#import "DDQUserInfoChoiceCell.h"

@interface DDQUserInfoController () <DDQUserInfoDelegate>

@property (nonatomic, strong) NSMutableArray<DDQUserInfoModel *> *info_dataSource;

@end

@implementation DDQUserInfoController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *titleKey = @"title";
    NSString *placeholderKey = @"placeholder";
    NSString *textKey = @"text";
    NSString *typeKey = @"type";
    
    NSString *text = self.base_infomationManager.uname.length > 0 ? self.base_infomationManager.uname : [self base_handleSecureEntryWithPhoneNumber:self.base_infomationManager.phone];
    DDQUserInfoSexType type = self.base_infomationManager.sex.intValue == 1 ? DDQUserInfoSexTypeMan : DDQUserInfoSexTypeWoman;
    NSString *birthKey = self.base_infomationManager.age.length > 0 ? textKey : placeholderKey;
    NSString *birthValue = self.base_infomationManager.age.length > 0 ? self.base_infomationManager.age : @"请选择";
    NSString *zyKey = self.base_infomationManager.zy.length > 0 ? textKey : placeholderKey;
    NSString *zyValue = self.base_infomationManager.zy.length > 0 ? self.base_infomationManager.zy : @"请选择";
    //实名制
    NSString *realKey = self.base_infomationManager.rz.intValue == 1 ? textKey : placeholderKey;
    NSString *realValue = self.base_infomationManager.rz.intValue == 1 ? @"已认证" : @"未认证";
    NSArray *data = @[@{titleKey:@"昵称", textKey:text},
                      @{titleKey:@"性别", typeKey:@(type)},
                      @{titleKey:@"出生年月", birthKey:birthValue},
                      @{titleKey:@"职业", zyKey:zyValue},
                      @{titleKey:@"实名认证", realKey:realValue},
                      ];
    self.info_dataSource = [NSMutableArray arrayWithCapacity:data.count];
    for (NSDictionary *dic in data) {
        
        [self.info_dataSource addObject:[DDQUserInfoModel mj_objectWithKeyValues:dic]];
        
    }
    
    //TableView
    [self base_tableViewConfig];
    
    //RigthItem
    UIButton *rightButton = [self setRightBarButtonItemStyle:DDQFoundationBarButtonText Content:@"保存"];
    [rightButton addTarget:self action:@selector(info_didSelectSaveData) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = DDQFont(15.0);
    
}

- (NSString *)base_navigationTitle {
    
    return @"个人资料";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    NSString *headerID = @"header";
    [self.base_tableView registerClass:[DDQUserInfoHeaderView class] forHeaderFooterViewReuseIdentifier:headerID];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setHeaderViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQUserInfoHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
        headerView.header_url = weakObjc.base_infomationManager.image;
        
        [headerView userInfo_didSelectPickImage:^{
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakObjc base_handleImagePickControllerCompleted:^(UIImage * _Nullable scaleImage, NSString * _Nonnull extension) {
                    
                    headerView.header_image = scaleImage;
                    
                } scale:0.2 authorityType:DDQFoundationAuthorityCamera];
            }];
            
            UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakObjc base_handleImagePickControllerCompleted:^(UIImage * _Nullable scaleImage, NSString * _Nonnull extension) {
                    
                    headerView.header_image = scaleImage;

                } scale:0.2 authorityType:DDQFoundationAuthorityPhotoLibary];
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:cameraAction];
            [alertController addAction:photoAction];
            [alertController addAction:cancelAction];
            [weakObjc presentViewController:alertController animated:YES completion:nil];
            
        }];
        return headerView;
        
    }];
    
    [self.base_tableView tableView_setCellHeightConfig:^CGFloat(NSIndexPath * _Nonnull indexPath) {
        
        return [DDQUserInfoBaseCell cell_getCellHeightWithModel:weakObjc.info_dataSource[indexPath.row]];
        
    }];

    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {

        if (indexPath.row == 0) {
            
            DDQUserInfoNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQUserInfoNameCell class])] forIndexPath:indexPath];
            [nameCell cell_updateDataWithModel:weakObjc.info_dataSource[indexPath.row]];
            return nameCell;
            
        } else if (indexPath.row == 1) {
            
            DDQUserInfoSexCell *sexCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQUserInfoSexCell class])] forIndexPath:indexPath];
            [sexCell cell_updateDataWithModel:weakObjc.info_dataSource[indexPath.row]];
            return sexCell;
            
        }
        
        DDQUserInfoChoiceCell *choiceCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQUserInfoChoiceCell class])]];
        [choiceCell cell_updateDataWithModel:weakObjc.info_dataSource[indexPath.row]];
        choiceCell.delegate = weakObjc;
        return choiceCell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    DDQFoundationControllerCellIdentifier const DDQNikeNameCellID = @"info_nickname";
    DDQFoundationControllerCellIdentifier const DDQSexCellID = @"info_sex";
    DDQFoundationControllerCellIdentifier const DDQChoiceCellID = @"info_choice";
    layout.layout_reuseDataSource = @{NSStringFromClass([DDQUserInfoNameCell class]):DDQNikeNameCellID,
                                      NSStringFromClass([DDQUserInfoSexCell class]):DDQSexCellID,
                                      NSStringFromClass([DDQUserInfoChoiceCell class]):DDQChoiceCellID
                                      };
    layout.layout_rowCount = self.info_dataSource.count;
    layout.layout_headerHeight = 135.0 * self.base_widthRate;
    
    return layout;
    
}

/**
 点击保存按钮
 */
- (void)info_didSelectSaveData {
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithObject:self.base_userID forKey:@"uid"];
    DDQUserInfoNameCell *nameCell = [self.base_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [requestParam setObject:nameCell.info_inputField.text forKey:@"uname"];
    
    DDQUserInfoSexCell *sexCell = [self.base_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [requestParam setObject:sexCell.info_sexType == DDQUserInfoSexTypeMan ? @"1" : @"2" forKey:@"usex"];

    DDQUserInfoBaseCell *brithCell = [self.base_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [requestParam setObject:brithCell.info_inputField.text forKey:@"uage"];
    
    DDQUserInfoNameCell *professionCell = [self.base_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    [requestParam setObject:professionCell.info_inputField.text forKey:@"occupation"];

    DDQUserInfoHeaderView *headerView = (DDQUserInfoHeaderView *)[self.base_tableView headerViewForSection:0];
    if (headerView.header_image) {
        
        [requestParam setObject:[self base_changeBase64StringWithImage:headerView.header_image] forKey:@"pic"];

    }
    
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/upuser"];
    DDQWeakObject(self);
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:requestParam WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {
            
            [weakObjc base_handleUserInfomationWithData:response];
        }
        return YES;
        
    }];
}

#pragma mark - UserInfo Delegate
- (void)userInfo_didSelectChoiceOperationWithCell:(DDQUserInfoBaseCell *)cell {
    
    NSIndexPath *indexPath = [self.base_tableView indexPathForCell:cell];
    if (indexPath.row == 3) {//点击了职业
        
        DDQProfessionController *professionC = [self base_handleInitializeWithControllerClass:[DDQProfessionController class] FromNib:NO title:nil propertys:nil];
        [professionC profession_didSelectProfession:^(NSString * _Nonnull profession) {
            
            cell.info_inputField.text = profession;
            
        }];
    } else if (indexPath.row == 4) {//点击了实名认证
        
        [self base_handleInitializeWithControllerClass:[DDQVerifiedController class] FromNib:YES title:nil propertys:nil];
        
    } else if (indexPath.row == 2) {//点击选择出生年月
        
        DDQBirthDateController *dateC = [[DDQBirthDateController alloc] init];
        [self presentViewController:dateC animated:YES completion:nil];
        [dateC birth_didSelectBirthDate:^(NSString * _Nonnull date) {
            
            cell.info_inputField.text = date;
            
        }];
    }
}

@end
