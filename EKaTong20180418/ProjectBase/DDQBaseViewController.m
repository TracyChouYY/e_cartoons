//
//  DDQBaseViewController.m
//
//  Copyright © 2017年 DDQ. All rights reserved.


#import "DDQBaseViewController.h"

@interface DDQBaseViewController ()<DDQAlertControllerDelegate, UIGestureRecognizerDelegate> {
    
    CGFloat _imageScale;
    MBProgressHUD *_pickerHud;
    DDQUserInformationManager *_infomationManager;
    
}
@property (nonatomic, copy) DDQBaseAnimationCompletion completion;
@property (nonatomic, copy) DDQBasePickerImageCompleted completed;

@property (nonatomic, copy) DDQAlertFieldInputCompleted fieldInputCompleted;

@end

@implementation DDQBaseViewController

DDQInputContentErrorDomain const DDQInputEmptyErrorDomain = @"DDQInputEmptyErrorDomain";
DDQInputContentErrorDomain const DDQInputInvalidErrorDomain = @"DDQInputInvalidErrorDomain";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _imageScale = 1.0;
    self.base_requestPage = 1;
    
    //系统版本判断
    if (@available(iOS 11.0, *)) {
        
        self.base_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        
    } else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = self.base_defaultBackgroundColor;

    //UserInfoObserver
    DDQWeakObject(self);
    [self.base_infomationManager information_registerPropertyObserverChange:^(DDQUserInformationManager * _Nonnull information) {
        
        if ([weakObjc respondsToSelector:@selector(base_handleWhenInformationKeyValueChange:)]) {
            
            [weakObjc base_handleWhenInformationKeyValueChange:information];
            
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //NavigationBar
    [self base_handleNavigationBarWithDifferentStyle];
    
}

- (void)dealloc {
    
    DDQLog(@"%@", self);
    if (self.base_tableView) {

        [self.base_tableView tableView_dealloc];
        
    }
    [self.base_infomationManager information_invaildPropertyObserver];
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    //Subview自适应，集中处理
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //PS:这里回答下为什么要有一个是否做过动画的判断。
        //因为我写的动画基本都是frame动画，frame在动画完成后会改变，这时会重新调用viewWillLayoutSubviews，导致Frame重置。View中的动画同理。
        if (view.view_autoLayout && !view.view_animated) {//子视图允许自适应大小,且没做过动画
            
            view.frame = CGRectMake(0.0, self.base_safeTopInset, self.view.width, self.view.height - self.base_safeTopInset - self.base_safeBottomInset);
        }
    }];
    
    if (self.base_navigationBarStyle == DDQBaseNavigationBarStyleMemberCenterEngross) {
        
        for (UIView *view in self.base_navigationController.navigationBar.subviews) {
            
            if ([NSStringFromClass([view class]) isEqualToString:@"_UIBarBackground"]) {
                
                for (UIView *subView in view.subviews) {
                    
                    if ([subView isKindOfClass:[UIImageView class]]) {
                        
                        subView.alpha = 1.0;
                    }
                }
            }
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - Custom IMP
- (CGFloat)base_animationDuration { return 0.25; }

- (NSString *)base_url { return @"http://ekt1805.wicep.net:999/"; }

- (NSString *)base_imageUrl { return @"http://ekt1805.wicep.net:999/"; }


- (NSString *)base_userID {
    
    return self.base_infomationManager.uid;
    
}

- (DDQAlertController *)base_alertController {
    
    if (!_base_alertController) {
        _base_alertController = [DDQAlertController alertControllerWithTitle:@"提示" message:@"" alertStyle:DDQAlertControllerStyleAlert];
        _base_alertController.delegate = self;
    }
    return _base_alertController;
}

- (CGFloat)base_safeTopInset {
    
    CGFloat safeTopGuide = 0.0;
    if (@available(iOS 11.0, *)) {
        safeTopGuide = self.view.safeAreaInsets.top;
    } else {
        safeTopGuide = self.topLayoutGuide.length;
    }
    return safeTopGuide;
}

- (CGFloat)base_safeBottomInset {
    
    CGFloat safeBottomGudide = 0.0;
    if (@available(iOS 11.0, *)) {
        safeBottomGudide = self.view.safeAreaInsets.bottom;
    } else {
        safeBottomGudide = self.bottomLayoutGuide.length;
    }
    return safeBottomGudide;
}

- (UIViewController *)base_initializeControllerClass:(Class)controller FromNib:(BOOL)nib Title:(NSString *_Nullable)title {

    UIViewController *viewController = nil;
    if (nib) {
        viewController = [[controller alloc] initWithNibName:NSStringFromClass(controller) bundle:nil];
    } else {
        viewController = [[controller alloc] init];
    }
    viewController.navigationItem.title = title;
    return viewController;
}

- (void)base_handleImagePickControllerWithDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate Type:(DDQFoundationAuthorityType)type {

    [self base_handleImagePickControllerWithDelegate:delegate Type:type allowEditing:YES];
    
}

- (void)base_handleImagePickControllerWithDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate Type:(DDQFoundationAuthorityType)type allowEditing:(BOOL)allow {
    
    NSError *resultError = [DDQBaseViewController foundation_checkUserAuthorityWithType:type];
    if (resultError) {
        [self base_handleAuthorityAlertWithError:resultError];
        [_pickerHud hideAnimated:YES];
        return;
    }
    
    UIImagePickerControllerSourceType sourceType = (type == DDQFoundationAuthorityCamera) ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
    NSArray *mediaTypes = @[(NSString *)kUTTypeImage];
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = delegate;
    pickerController.allowsEditing = allow;
    pickerController.sourceType = sourceType;
    pickerController.mediaTypes = mediaTypes;
    pickerController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:pickerController animated:YES completion:nil];//不允许Push

}

- (void)base_handleImagePickControllerCompleted:(DDQBasePickerImageCompleted)completed scale:(CGFloat)scale authorityType:(DDQFoundationAuthorityType)aType {
    
    [self base_handleImagePickControllerCompleted:completed scale:scale authorityType:aType editing:YES];
    
}

- (void)base_handleImagePickControllerCompleted:(DDQBasePickerImageCompleted)completed scale:(CGFloat)scale authorityType:(DDQFoundationAuthorityType)aType editing:(BOOL)editing {
    
    if (completed) {
        self.completed = completed;
    }
    _imageScale = scale;
    _pickerHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self base_handleImagePickControllerWithDelegate:self Type:aType allowEditing:editing];

}

- (DDQRateSet)base_controllerRate { return [UIView view_getCurrentDeviceRateWithVersion:DDQFoundationRateDevice_iPhone6]; }

- (CGFloat)base_widthRate { return self.base_controllerRate.widthRate; }

- (void)base_tableViewConfig {
    
    self.base_tableView = [DDQFoundationTableView tableViewWithStyle:self.base_tableViewStyle];
    [self.view addSubview:self.base_tableView];
    self.base_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.base_tableView.view_autoLayout = YES;
    [self.base_tableView tableView_configLayout:self.base_tableViewLayout];
    self.base_tableView.backgroundColor = [UIColor clearColor];
    if (self.base_tableView.style == UITableViewStylePlain) {
        self.base_tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
}

- (DDQFoundationTableViewLayout *)base_currentLayout { return self.base_tableView.tableView_layout; }

- (UITableViewStyle)base_tableViewStyle { return UITableViewStyleGrouped; }

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *baseLayout = [DDQFoundationTableViewLayout layoutWithTableView:self.base_tableView];
    baseLayout.layout_sectionCount = 1;
    return baseLayout;
}

- (NSString *)base_changeBase64StringWithImage:(UIImage *)image {
    
    NSData *data = nil;
    if ([image.image_extension isEqualToString:@"png"]) {
        
        data = UIImagePNGRepresentation(image);
        
    } else {
        
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    return [data base64EncodedStringWithOptions:0];
}

- (void)base_handleInputContentType:(DDQBaseHandleInputContentType)type text:(NSString *)text showHud:(BOOL)show error:(NSError * _Nullable __autoreleasing *)error {
    
    //对于输入内容的类型判断
    if (type == DDQBaseHandleInputContentTypeAccount) {//手机号
        
        if (text.length == 0) {
            
            [self base_handleInputErrorWithText:DDQAccountEmpty show:show error:error isEmpty:YES];
            
        } else {
            
            if (![self foundation_checkPhone:text]) {
                
                [self base_handleInputErrorWithText:DDQAccountError show:show error:error isEmpty:NO];
                
            }
        }
    } else if (type == DDQBaseHandleInputContentTypePassword) {//密码
        
        if (text.length == 0) {
            
            [self base_handleInputErrorWithText:DDQPasswordEmpty show:show error:error isEmpty:YES];
            
        }
    } else if (type == DDQBaseHandleInputContentTypeMessageCode) {//验证码
        
        if (text.length == 0) {
            
            [self base_handleInputErrorWithText:DDQMessageCodeEmpty show:show error:error isEmpty:YES];
            
        } else {
            
            if (![self foundation_checkIntWithString:text]) {
                
                [self base_handleInputErrorWithText:DDQMessageCodeError show:show error:error isEmpty:NO];
                
            }
        }
    } else if (type == DDQBaseHandleInputContentTypePoint) {//积分
        
        if (text.length == 0) {
            
            [self base_handleInputErrorWithText:DDQPointEmpty show:show error:error isEmpty:YES];
            
        } else {
            
            if (![self foundation_checkFloatWithString:text]) {//和价格一样只能是纯数字
                
                [self base_handleInputErrorWithText:DDQPointError show:show error:error isEmpty:NO];
                
            }
        }
    } else if (type == DDQBaseHandleInputContentTypePayPassword) {
        
        if (text.length == 0) {
            
            [self base_handleInputErrorWithText:DDQPayPasswordEmpty show:show error:error isEmpty:YES];
            
        } else {
            
            if (text.length != 6 || ![self foundation_checkIntWithString:text]) {//长度为6且纯数字
                
                [self base_handleInputErrorWithText:DDQPayPasswordFromatError show:show error:error isEmpty:NO];

            }
        }
    } else if (type == DDQBaseHandleInputContentTypeSurePayPassword) {
        
        if (text.length == 0) {
            
            [self base_handleInputErrorWithText:DDQPayPasswordEmpty show:show error:error isEmpty:YES];
            
        } else {
            
            if (text.length != 6 || ![self foundation_checkIntWithString:text]) {//长度为6且纯数字
                
                [self base_handleInputErrorWithText:DDQPayPasswordFromatError show:show error:error isEmpty:NO];
                
            }
        }
    } else if (type == DDQBaseHandleInputContentTypeSurePassword) {
        
        if (text.length == 0) {
            
            [self base_handleInputErrorWithText:DDQSurePasswordEmpty show:show error:error isEmpty:YES];
            
        }
    }
}

/**
 处理输入错误时HUD的显示

 @param text 用户输入的文字
 @param show 信不显示HUD
 @param error 错误
 @param empty 是不是提示内容为空
 */
- (NSString *)base_handleInputErrorWithText:(NSString *)text show:(BOOL)show error:(NSError **)error isEmpty:(BOOL)empty {
    
    if (show) {
        [self alertHUDWithText:text Delegate:nil];
    }
    *error = [NSError errorWithDomain:(empty) ? DDQInputEmptyErrorDomain : DDQInputInvalidErrorDomain code:(empty) ? DDQBaseHandleInputContentErrorEmpty : DDQBaseHandleInputContentErrorInvalid userInfo:@{@"ErrorDescription":text}];
    return text;
}

- (void)base_reloadTableViewWithSection:(NSInteger)section {
    
    [self.base_tableView beginUpdates];
    [self.base_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    [self.base_tableView endUpdates];
}

- (void)base_reloadTableViewWithIndexPath:(NSIndexPath *)indexPath {
    
    [self base_reloadTableViewWithIndexPaths:@[indexPath]];
}

- (void)base_reloadTableViewWithIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    
    [self.base_tableView beginUpdates];
    [self.base_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self.base_tableView endUpdates];
}

- (NSString *)base_handleFindURLDataWithKey:(NSString *)key url:(NSString *)url {
    
    return [self base_handleFindURLDataWithKey:key url:url separatorString:@"/"];
}

- (NSString *)base_handleFindURLDataWithKey:(NSString *)key url:(NSString *)url separatorString:(NSString *)string {
    
    NSArray<NSString *> *strings = [url componentsSeparatedByString:string];
    if ([strings containsObject:key]) {
        
        NSUInteger index = [strings indexOfObject:key] + 1;
        NSString *nextString = [strings objectAtIndex:index];
        return !nextString ? @"" : nextString;
    }
    return @"";
}

- (NSString *)base_handleSecureEntryWithPhoneNumber:(NSString *)text {
    
    if (![self foundation_checkPhone:text]) {
        return text;
    }
    return [text stringByReplacingOccurrencesOfString:[text substringWithRange:NSMakeRange(3, text.length - 7)] withString:@"****"];
}

#pragma mark - Tools
/**
 处理摄像头权限错误
 
 @param error 错误
 */
- (void)base_handleAuthorityAlertWithError:(NSError *)error {
    
    DDQAlertController *alertController = [DDQAlertController alertControllerWithTitle:@"提示" message:error.domain alertStyle:DDQAlertControllerStyleAlert];
    [alertController alert_addAlertItem:^__kindof DDQAlertItem * _Nullable{
        
        DDQAlertItem *alertItem = [DDQAlertItem alertItemWithStyle:DDQAlertItemStyleDefault];
        alertItem.item_title = @"取消";
        [_pickerHud hideAnimated:YES];
        return alertItem;
    } handler:nil];
    
    [alertController alert_addAlertItem:^__kindof DDQAlertItem * _Nullable{
        
        DDQAlertItem *alertItem = [DDQAlertItem alertItemWithStyle:DDQAlertItemStyleDefault];
        alertItem.item_attrTitle = [[NSAttributedString alloc] initWithString:@"设置" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        return alertItem;
    } handler:^(DDQAlertItem * _Nonnull item) {
        [DDQBaseViewController foundation_gotoAppSystemSet];
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - NavigationBar的处理

#pragma mark - ImagePicker && Navigation Delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    if (self.completed) {
        
        UIImage *selectedImage = nil;
        if (info[UIImagePickerControllerEditedImage]) {
            
            selectedImage = info[UIImagePickerControllerEditedImage];
            
        } else {
            
            selectedImage = info[UIImagePickerControllerOriginalImage];
        }
        
        selectedImage = [self foundation_compressionImageWithImage:selectedImage Scale:_imageScale];
        NSString *extension = @"png";
        NSURL *referenceUrl = info[UIImagePickerControllerReferenceURL];
        if (referenceUrl) {
            
            extension = [referenceUrl.pathExtension lowercaseString];
        }
        selectedImage.image_extension = extension;
        self.completed(selectedImage, extension);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [_pickerHud hideAnimated:YES];
}

@end

@implementation DDQBaseViewController (DDQBaseViewControllerItem)

- (DDQNavigationController *)base_navigationController {
    if ([self.navigationController isKindOfClass:[DDQNavigationController class]]) {
        return (DDQNavigationController *)self.navigationController;
    }
    return nil;
}

- (DDQTabBarController *)base_tabBarController {
    if ([self.tabBarController isKindOfClass:[DDQTabBarController class]]) {
        return (DDQTabBarController *)self.tabBarController;
    }
    return nil;
}

@end

@implementation DDQBaseViewController (DDQBaseViewControllerFromTS)

- (void)base_presentSystemCameraToRecordVideoWithDelegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate {
    
    //录制时的摄像头权限
    NSError *cameraError = [DDQBaseViewController foundation_checkUserAuthorityWithType:DDQFoundationAuthorityCamera];
    if (cameraError) {
        [self base_handleAuthorityAlertWithError:cameraError];
        return;
    }
    
    //录制时的麦克风权限
    NSError *microphoneError = [DDQBaseViewController foundation_checkUserAuthorityWithType:DDQFoundationAuthorityMicrophone];
    if (microphoneError) {
        [self base_handleAuthorityAlertWithError:microphoneError];
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = delegate;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
    imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    imagePickerController.videoMaximumDuration = 60.0;
    imagePickerController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)base_asyncUploadVideoWithUrl:(NSString *)url videoUrl:(NSString *)videoUrl progress:(void (^)(NSProgress * _Nullable))progress completed:(void (^)(NSError * _Nullable, id _Nullable))completed {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPRequestSerializer *reqSer = [AFHTTPRequestSerializer serializer];
    [reqSer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = reqSer;
    
    AFJSONResponseSerializer *resSer = [AFJSONResponseSerializer serializer];
    resSer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    manager.responseSerializer = resSer;
    
    [manager POST:url parameters:@{@"uid":self.base_userID} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:[NSData dataWithContentsOfFile:videoUrl] name:@"wjfile" fileName:videoUrl mimeType:@"mp4"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completed) completed(nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completed) completed(error, nil);
    }];
}

@end

@implementation DDQBaseViewController (DDQBaseViewControllerFromWDSG)

- (UIViewController *)base_handleInitializeWithControllerClass:(Class)cClass FromNib:(BOOL)nib title:(NSString *)title propertys:(NSDictionary *)propertys {
    return [self base_handleInitializeWithControllerClass:cClass fromNib:nib title:title animation:YES propertys:propertys];
}

- (UIViewController *)base_handleInitializeWithControllerClass:(Class)cClass fromNib:(BOOL)nib title:(NSString *)title animation:(BOOL)animation propertys:(NSDictionary *)propertys {
    
    UIViewController *controller = [self base_initializeControllerClass:cClass FromNib:nib Title:title];
    if (propertys.count > 0) {
        
        for (NSString *key in propertys.allKeys) {
            [controller setValue:propertys[key] forKey:key];
        }
    }
    controller.hidesBottomBarWhenPushed = YES;
    [self.base_navigationController pushViewController:controller animated:animation];
    return controller;
}

- (void)base_handlePopWithController:(__kindof DDQBaseViewController *)controller toController:(__kindof DDQBaseViewController *)tController animated:(BOOL)animated {
    
    if (!tController) {
        [controller.base_navigationController popViewControllerAnimated:animated];
    } else {
        [controller.base_navigationController popToViewController:tController animated:animated];
    }
}

- (void)base_handlePopController {
    [self base_handlePopWithController:self toController:nil animated:YES];
}

- (void)base_handleFullScreenView:(__kindof UIView *)view animationStyle:(DDQBaseHandleAnimationType)type completion:(DDQBaseAnimationCompletion)com {
    
    [UIView animateWithDuration:self.base_animationDuration animations:^{
        
        CGRect viewFrame = view.frame;
        viewFrame.origin.y = (type == DDQBaseHandleAnimationTypeShow) ? 0.0 : self.navigationController.view.height;
        view.frame = viewFrame;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            if (com) {
                com();
            }
        }
    }];
}

- (void)base_presentImagePickerAlertControllerWithDelegate:(id<DDQAlertControllerDelegate>)delegate {
    
    DDQAlertController *alertController = [DDQAlertController alertControllerWithTitle:nil message:nil alertStyle:DDQAlertControllerStyleSheetExceptHeader];
    alertController.delegate = delegate;
    [alertController alert_addAlertItem:^__kindof DDQAlertItem * _Nullable{
        
        DDQAlertItem *item = [DDQAlertItem alertItemWithStyle:DDQAlertItemStyleDefault];
        item.item_title = @"从手机相册中选择";
        item.tag = 1;
        return item;
    } handler:nil];
    
    [alertController alert_addAlertItem:^__kindof DDQAlertItem * _Nullable{
        
        DDQAlertItem *item = [DDQAlertItem alertItemWithStyle:DDQAlertItemStyleDefault];
        item.item_title = @"拍一张";
        item.tag = 2;
        return item;
    } handler:nil];
    
    [alertController alert_addAlertItem:^__kindof DDQAlertItem * _Nullable{
        
        DDQAlertItem *item = [DDQAlertItem alertItemWithStyle:DDQAlertItemStyleDefault];
        item.item_title = @"取消";
        item.tag = 3;
        return item;
    } handler:nil];
    
    alertController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)base_handleSystemAlertControllerTitle:(NSString *)title message:(NSString *)message inputContent:(nonnull void (^)(NSString * _Nullable))content completed:(void (^ _Nullable)(void))completed {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:(!title) ? @"提示" : title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (completed) {
            completed();
        }
    }];
    
    [alertController addAction:actionOne];
    [alertController addAction:actionTwo];
    
    [alertController addTextFieldWithConfigurationHandler:nil];
    
    id observer;
    observer = [DDQNotificationCenter addObserverForName:UITextFieldTextDidEndEditingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        UITextField *field = note.object;
        if (content) {
            content(field.text);
        }
        [DDQNotificationCenter removeObserver:observer];
    }];
    
    alertController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)base_setTableViewHeaderFooterWithHeaderCompleted:(DDQBaseHeaderFooterCompleted)hCompleted footerCompleted:(DDQBaseHeaderFooterCompleted)fCompleted {
    
    DDQWeakObject(self);
    [self.class foundation_setHeaderWithView:self.base_tableView Stlye:DDQFoundationHeaderStyleNormal Handle:^{
        
        if (hCompleted) {
            
            weakObjc.base_requestPage = 1;
            hCompleted(weakObjc.base_requestPage);
        }
        [weakObjc.base_tableView foundation_endRefreshing];
    }];
    
    MJRefreshAutoFooter *footer = [self.class foundation_setFooterWithView:self.base_tableView Stlye:DDQFoundationFooterStyleAutoState Handle:^{
        
        if (fCompleted) {
            
            weakObjc.base_requestPage++;
            fCompleted(weakObjc.base_requestPage);
        }
        [weakObjc.base_tableView foundation_endRefreshing];
    }];
    footer.onlyRefreshPerDrag = YES;
}

@end

@implementation DDQBaseViewController (DDQBaseViewControllerFromJYK)

- (void)base_handleSystemAlertControllerTitle:(NSString *)title message:(NSString *)message inputDelegate:(id<UITextFieldDelegate>)delegate inputCompleted:(DDQAlertFieldInputCompleted)completed {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:(!title) ? @"提示" : title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    if (completed) {
        
        self.fieldInputCompleted = completed;
        
    }
    
    [alertController addAction:actionOne];
    [alertController addAction:actionTwo];
    
    DDQWeakObject(self);
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.delegate = (delegate) ? delegate : weakObjc;
        
    }];
    
    alertController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)base_presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message style:(DDQAlertControllerStyle)style cancel:(void (^)(void))cancel sure:(void (^)(void))sure {
    
    DDQAlertController *alertC = [DDQAlertController alertControllerWithTitle:title ? : @"提示" message:message alertStyle:style];
    [alertC alert_addAlertItem:^__kindof DDQAlertItem * _Nullable{
        
        DDQAlertItem *cancelItem = [DDQAlertItem alertItemWithStyle:DDQAlertItemStyleDefault];
        cancelItem.item_title = @"取消";
        return cancelItem;
        
    } handler:nil];
    
    [alertC alert_addAlertItem:^__kindof DDQAlertItem * _Nullable{
        
        DDQAlertItem *sureItem = [DDQAlertItem alertItemWithStyle:DDQAlertItemStyleDefault];
        sureItem.item_attrTitle = [[NSAttributedString alloc] initWithString:@"确定" attributes:@{NSFontAttributeName:sureItem.item_font, NSForegroundColorAttributeName:kSetColor(230.0, 11.0, 47.0, 1.0)}];
        return sureItem;
        
    } handler:^(DDQAlertItem * _Nonnull item) {
        
        if (sure) sure();
        
    }];
    [self presentViewController:alertC animated:YES completion:nil];
    
}


#pragma mark - TextField Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.fieldInputCompleted) {
        
        self.fieldInputCompleted(textField.text);
        
    }
    textField.delegate = nil;
    
}

@end

@implementation DDQBaseViewController (DDQBaseViewControllerFromCS)

- (DDQUserInformationManager *)base_infomationManager {
    
    if (!_infomationManager) {
        
        _infomationManager = [DDQUserInformationManager defaultManager];
        
    }
    return _infomationManager;
    
}

- (void)base_handleUserInfomationWithData:(id)data {
    
    if ([data count] == 0 || !data) return;
    
    NSDictionary *requestData = data;
    [self base_handleSaveKeyValueIfContainKey:@"uid" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"state" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"image" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"phone" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"uname" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"base" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"zfpwd" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"yhdj" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"sex" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"zy" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"age" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"rz" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"jrxs" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"ljxs" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"wdcf" inData:requestData];
    [self base_handleSaveKeyValueIfContainKey:@"bid" inData:requestData];

}

/**
 保存数值，如果请求数据中包含这个字段的话
 */
- (void)base_handleSaveKeyValueIfContainKey:(NSString *)key inData:(id)data {
    
    NSArray *dataKeys = [data allKeys];
    if (![dataKeys containsObject:key]) return;
    
    NSArray *allDataKeys = [self.base_infomationManager information_allKeys];
    if (![allDataKeys containsObject:key]) return;
    
    NSString *valueString = [self base_handleRequestStringIfIllegal:data[key]];
    if ([key isEqualToString:@"image"]) {
        
        valueString = [self.base_imageUrl stringByAppendingString:valueString];
        
    }
    [self.base_infomationManager setValue:valueString forKey:key];
    
}

- (NSString *)base_handleRequestStringIfIllegal:(id)string {
    
    return [self base_handleRequestDataIfLegal:string targetClass:[NSString class]];
    
}

- (id)base_handleRequestDataIfLegal:(id)data targetClass:(Class)tC {
    
    if ([data isKindOfClass:[NSNull class]]) {//为Null
        
        return [[tC alloc] init];
    }
    
    if (data == nil) {//为空
        
        return [[tC alloc] init];
        
    }
    
    if (![[data class] isSubclassOfClass:tC]) {//不是要转化的目标类及其子类
        
        return [data description];
        
    }
    
    return data;
    
}

- (void)base_handleWhenInformationKeyValueChange:(DDQUserInformationManager *)manager {}

- (NSString *)base_handleHTMLString:(NSString *)html {
    
    NSAttributedString *htmlString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    NSString *htmlContent = htmlString.string;
    htmlContent = [htmlContent stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    htmlContent = [htmlContent stringByReplacingOccurrencesOfString:@"\U00002028\n" withString:@"\n"];
    
    return htmlContent;
    
}

@end


@implementation DDQBaseViewController (DDQECarAPI)

- (UIColor *)base_defaultBackgroundColor {
    
    return self.view.defaultViewBackgroundColor;
    
}

- (NSString *)base_navigationTitle {
    
    return @"";
    
}

- (DDQBaseNavigationBarStyle)base_navigationBarStyle {
    
    return DDQBaseNavigationBarStyleWhiteAndBack;
    
}

/**
 处理不同情况下的NavigatinBar的显示
 */
- (void)base_handleNavigationBarWithDifferentStyle {
    
    if ([self respondsToSelector:@selector(base_navigationTitle)]) {
        
        NSString *navTitle = [self performSelector:@selector(base_navigationTitle)];
        if (![self.navigationItem.title isEqualToString:navTitle] && self.navigationItem.title.length == 0) {//如果当前显示的标题和需要显示的标题不一致
            
            self.navigationItem.title = navTitle;
        }
    }
    
    //是不是根视图控制器
    if (self.base_navigationController.nav_rootViewController != self) {//隐藏默认的返回键
        
        self.navigationItem.backBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
    
    [self.base_navigationController.navigationBar setBackgroundImage:kSetImage(@"nav_whitBackground") forBarMetrics:UIBarMetricsDefault];
    self.base_navigationController.navigationBar.translucent = YES;
    if (self.base_navigationController.navigationBarHidden) {
        
        [self.base_navigationController setNavigationBarHidden:NO animated:YES];
        
    }
    [self.base_navigationController.navigationBar setShadowImage:[UIImage new]];
    
    //Bar的显示样式
    [self.base_navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    if (self.base_navigationBarStyle == DDQBaseNavigationBarStyleWhite) {
        
        self.navigationItem.leftBarButtonItems = @[];
        
    } else if (self.base_navigationBarStyle == DDQBaseNavigationBarStyleWhiteAndBack) {
        
        self.navigationItem.leftBarButtonItems = @[];
        UIButton *button = [self setLeftBarButtonItemStyle:DDQFoundationBarButtonImage Content:kSetImage(@"navigaiton_back")];
        [button addTarget:self action:@selector(foundation_leftItemSelectedWithCustomButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.base_navigationController nav_updateNavgationStatusBarStyle:UIStatusBarStyleDefault];
        [self.base_navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        [self.base_navigationController.navigationBar setShadowImage:kSetImage(@"nav_shadow")];
        
    } else if (self.base_navigationBarStyle == DDQBaseNavigationBarStyleHiddenBar) {
        
        [self.base_navigationController setNavigationBarHidden:YES animated:YES];
        [self.base_navigationController nav_updateNavgationStatusBarStyle:UIStatusBarStyleLightContent];
        
    }  else if (self.base_navigationBarStyle == DDQBaseNavigationBarStyleWhiteAndBackHiddenShadow) {
        
        self.navigationItem.leftBarButtonItems = @[];
        UIButton *button = [self setLeftBarButtonItemStyle:DDQFoundationBarButtonImage Content:kSetImage(@"navigaiton_back")];
        [button addTarget:self action:@selector(foundation_leftItemSelectedWithCustomButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.base_navigationController nav_updateNavgationStatusBarStyle:UIStatusBarStyleDefault];
        [self.base_navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:self.view.defaultBlackColor}];
        
    } else if (self.base_navigationBarStyle == DDQBaseNavigationBarStyleMemberCenterEngross) {
        
        self.navigationItem.leftBarButtonItems = @[];
        [self.base_navigationController.navigationBar setBackgroundImage:kSetImage(@"navigation_blue") forBarMetrics:UIBarMetricsDefault];
        UIButton *button = [self setLeftBarButtonItemStyle:DDQFoundationBarButtonImage Content:kSetImage(@"navigaiton_whiteBack")];
        [button addTarget:self action:@selector(foundation_leftItemSelectedWithCustomButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.base_navigationController nav_updateNavgationStatusBarStyle:UIStatusBarStyleDefault];
     
    } else if (self.base_navigationBarStyle == DDQBaseNavigationBarStyleClearAndWhitBack) {
        
        self.navigationItem.leftBarButtonItems = @[];
        [self.base_navigationController.navigationBar setBackgroundImage:kSetImage(@"navgation_clear") forBarMetrics:UIBarMetricsDefault];
        UIButton *button = [self setLeftBarButtonItemStyle:DDQFoundationBarButtonImage Content:kSetImage(@"navigaiton_whiteBack")];
        [button addTarget:self action:@selector(foundation_leftItemSelectedWithCustomButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.base_navigationController nav_updateNavgationStatusBarStyle:UIStatusBarStyleDefault];

    }
}

- (DDQProjectHandler *)base_handler {
    
    return [DDQProjectHandler defaultHandler];
    
}

- (void)base_handleSendMessageCodeToRegister:(BOOL)to phone:(NSString *)phone completed:(void (^)(int))completed {
    
    //忘记密码和注册发短信的接口不同
//    NSString *sendUrl = [self.base_url stringByAppendingString:(to) ? @"UserApi/fdx" : @"User/fsyzm_wjmm"];
    [self base_handleSendMessageCodeToRegister:to otherParam:nil phone:phone completed:completed];
    
}

- (void)base_handleSendMessageCodeToRegister:(BOOL)to otherParam:(NSDictionary *)param phone:(NSString *)phone completed:(void (^)(int))completed {
    
    NSString *sendUrl = [self.base_url stringByAppendingString:@"UserApi/fdx"];
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithDictionary:@{@"phone":phone}];
    if (to) {
        
        [requestParam setObject:@"1" forKey:@"zc"];
        
    } else {
        
        if (param) {
            
            [requestParam addEntriesFromDictionary:param];
            
        }
    }
    
    [self foundation_processNetPOSTRequestWithUrl:sendUrl Param:param.copy WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (completed) completed(code);
        return YES;
        
    }];
}

- (void)base_handleUserLoginStatus:(DDQBaseHandleLoginStatus)status {
    
    DDQBaseLoginStatus handleStatus = DDQBaseLoginStatusUnknown;
    handleStatus = (self.base_userID.length > 0) ? DDQBaseLoginStatusLogin : DDQBaseLoginStatusNotLogin;
    if (status) status(handleStatus);
    
}

- (void)base_handleUserLogoutCompleted:(void (^)(void))completed {
    
    [self.base_infomationManager information_clearSaveInformationCompleted:^{
        
        if (completed) {
            
            completed();
            
        }
    }];
}

- (NSUInteger)base_handleNavigationControllerControllerContainClass:(Class)cClass {
    
    __block NSUInteger index = DDQNavigationControllerIndexNotFound;
    [self.base_navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([NSStringFromClass([obj class]) isEqualToString:NSStringFromClass(cClass)]) {
            
            index = idx;
            
        }
    }];
    return index;
    
}

- (void)base_handleDifferentLoginTypeWithClass:(Class)cClass {
    
    NSUInteger index = [self base_handleNavigationControllerControllerContainClass:cClass];
    if (index != DDQNavigationControllerIndexNotFound) {
        
        [self base_handlePopWithController:self toController:self.base_navigationController.viewControllers[index] animated:YES];
        
    } else {
        
        [self base_handleInitializeWithControllerClass:cClass FromNib:NO title:nil propertys:nil];
        
    }
}

- (NSInteger)base_type {
    
    return self.base_infomationManager.state.integerValue;
    
}

@end



