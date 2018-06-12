//
//  DDQBaseViewController.h
//
//  Copyright © 2017年 DDQ. All rights reserved.

//  工程基础控制器
//  PS:这里我先做下说明。这个类会根据不同的工程而出现不同，也就是我根据在这个公司写的项目而不断丰富的抽象类，应尽可能的不去调用本类的实例，而由子类实现或调用。我会尽量做到分而编写，让代码看起来不那么混乱。
//  这个类的作用如下：
//  1、可以作为工程中任何控制器的父类。
//  2、帮助代码做到低耦合。

#import <DDQProjectFoundation/DDQFoundationHeader.h>
#import <DDQProjectFoundation/DDQFoundationController.h>

#import "DDQProjectSet.h"
#import "DDQProjectHandler.h"
#import "DDQUserInformationManager.h"
#import "UIView+DDQAdditionalContent.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQBaseLoginStatus) {
    
    DDQBaseLoginStatusUnknown = 0,    //登录状态未知
    DDQBaseLoginStatusLogin,          //已登录
    DDQBaseLoginStatusNotLogin,       //未登录
};

typedef NS_ENUM(NSUInteger, DDQBaseHandleAnimationType) {
    
    DDQBaseHandleAnimationTypeShow,     //视图出现
    DDQBaseHandleAnimationTypeHidden,   //视图隐藏
};

typedef NS_ENUM(NSUInteger, DDQBaseHandleInputContentError) {
    
    DDQBaseHandleInputContentErrorEmpty = 10000,      //输入内容为空
    DDQBaseHandleInputContentErrorInvalid,            //输入内容有误
};

typedef NS_ENUM(NSUInteger, DDQBaseHandleInputContentType) {
    
    DDQBaseHandleInputContentTypeAccount,               //本项目中是手机号
    DDQBaseHandleInputContentTypeMessageCode,           //验证码
    DDQBaseHandleInputContentTypePassword,              //密码
    DDQBaseHandleInputContentTypeSurePassword,          //确认密码
    DDQBaseHandleInputContentTypePoint,                 //积分
    DDQBaseHandleInputContentTypePayPassword,           //支付密码
    DDQBaseHandleInputContentTypeSurePayPassword,       //支付密码

};

typedef NSString *DDQInputContentErrorDomain;

typedef NSString* DDQBaseUserDefaultKey;
typedef void(^DDQBaseHandleLoginStatus)(DDQBaseLoginStatus status);
typedef void(^_Nullable DDQBaseAnimationCompletion)(void);
typedef void(^_Nullable DDQBasePickerImageCompleted)(UIImage *_Nullable scaleImage, NSString *extension);
typedef void(^_Nullable DDQBaseRequestCompleted)(BOOL haveData);
typedef void(^_Nullable DDQBaseHeaderFooterCompleted)(int page);

/**
 基类公共方法。
 */
@interface DDQBaseViewController : DDQFoundationController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, DDQAlertControllerDelegate>

/**
 初始化控制器
 
 @param controller 控制器类型
 @param nib 是否由Nib初始化
 @return 控制器实例
 */
- (__kindof UIViewController *)base_initializeControllerClass:(Class)controller FromNib:(BOOL)nib Title:(nullable NSString *)title;

/**
 获得动画持续时间。UIView animationTime value is 0.2。
 */
@property (nonatomic, readonly) CGFloat base_animationDuration;//custom default value 0.25

/**
 获得基础URL
 */
@property (nonatomic, readonly) NSString *base_url;

/**
 获得基础图片URL
 */
@property (nonatomic, readonly) NSString *base_imageUrl;

/**
 用户的ID
 */
@property (nonatomic, readonly) NSString *base_userID;

/**
 布局中安全的顶部边距
 */
@property (nonatomic, readonly) CGFloat base_safeTopInset;

/**
 布局中安全的底部边距
 */
@property (nonatomic, readonly) CGFloat base_safeBottomInset;

/**
 默认的自定义AlertController
 */
@property (nonatomic, strong, nullable) DDQAlertController *base_alertController;

/**
 处理系统的图片选择和拍照
 
 @param delegate PickerController的代理
 @param type 访问的类型
 */
- (void)base_handleImagePickControllerWithDelegate:(nullable id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate Type:(DDQFoundationAuthorityType)type;

/**
 专门用来处理ImagePicker图片的选择
 
 @param completed 选择的图片
 @param scale 图片处理时的压缩大小比例
 */
- (void)base_handleImagePickControllerCompleted:(DDQBasePickerImageCompleted)completed scale:(CGFloat)scale authorityType:(DDQFoundationAuthorityType)aType;

/**
 专门用来处理ImagePicker图片的选择

 @param completed 选择的图片
 @param scale 压缩大小比例
 @param aType 图片选择方式
 @param editing 是否允许图片裁剪
 */
- (void)base_handleImagePickControllerCompleted:(DDQBasePickerImageCompleted)completed scale:(CGFloat)scale authorityType:(DDQFoundationAuthorityType)aType editing:(BOOL)editing;
/**
 默认的工程视图大小比例
 */
@property (nonatomic, readonly) DDQRateSet base_controllerRate;
@property (nonatomic, readonly) CGFloat base_widthRate;

/**
 配置TableView
 */
- (void)base_tableViewConfig DDQ_REQUIRES_SUPER;

/**
 默认的TableView
 */
@property (nonatomic, strong, nullable) DDQFoundationTableView *base_tableView;

/**
 TableView的样式。
 */
- (UITableViewStyle)base_tableViewStyle;//default UITableViewStyleGrouped

/**
 TableView的布局
 */
@property (nonatomic, readonly) DDQFoundationTableViewLayout *base_currentLayout;

/**
 设置的TableView基础布局
 */
- (DDQFoundationTableViewLayout *)base_tableViewLayout;

/** 适用于BaseTableView的刷新 */
- (void)base_reloadTableViewWithSection:(NSInteger)section;
- (void)base_reloadTableViewWithIndexPath:(NSIndexPath *)indexPath;
- (void)base_reloadTableViewWithIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 从url中找到我所需要数据的值 */
- (NSString *)base_handleFindURLDataWithKey:(NSString *)key url:(NSString *)url;
- (NSString *)base_handleFindURLDataWithKey:(NSString *)key url:(NSString *)url separatorString:(NSString *)string;

/**
 将图片转base64
 */
- (nullable NSString *)base_changeBase64StringWithImage:(UIImage *)image;

/**
 处理用户输入内容
 @param show 是否以HUD的形式显示错误内容
 */
- (void)base_handleInputContentType:(DDQBaseHandleInputContentType)type text:(nullable NSString *)text showHud:(BOOL)show error:(NSError **)error;

/**
 默认页码
 */
@property (nonatomic, assign) int base_requestPage;//default 1

/**
 类似手机号码中间“****”
 */
- (NSString *)base_handleSecureEntryWithPhoneNumber:(NSString *)text;

@property (nonatomic, copy) NSString *base_orderState;

@end

/**
 自定义(Navigation,TabBar)Controller
 */
@interface DDQBaseViewController (DDQBaseViewControllerItem)

/**
 导航控制器
 */
@property (nonatomic, readonly) DDQNavigationController *base_navigationController;//default nil

/**
 标签控制器
 */
@property (nonatomic, readonly) DDQTabBarController *base_tabBarController;//default nil

@end

/**
 来自《红道智能》项目。
 */
@interface DDQBaseViewController (DDQBaseViewControllerFromTS)

/**
 唤起摄像头拍摄视频
 */
- (void)base_presentSystemCameraToRecordVideoWithDelegate:(nullable id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate;

/**
 AFN上传视频
 
 @param url 接口地址
 @param videoUrl 视频地址
 @param progress 上传进度
 @param completed 完成情况
 */
- (void)base_asyncUploadVideoWithUrl:(NSString *)url videoUrl:(NSString *)videoUrl progress:(void(^_Nullable)(NSProgress *_Nullable progress))progress completed:(void(^_Nullable)(NSError *_Nullable error, _Nullable id response))completed;

@end

/**
 来自《味多食广》项目
 */
@interface DDQBaseViewController (DDQBaseViewControllerFromWDSG)

/**
 处理控制器初始化后的流程
 
 @param cClass 控制器的Class
 @param nib 是否由Xib初始
 @param title 控制器标题
 @param propertys 控制器属性
 */
- (__kindof UIViewController *)base_handleInitializeWithControllerClass:(Class)cClass FromNib:(BOOL)nib title:(nullable NSString *)title propertys:(nullable NSDictionary *)propertys;
- (__kindof UIViewController *)base_handleInitializeWithControllerClass:(Class)cClass fromNib:(BOOL)nib title:(nullable NSString *)title animation:(BOOL)animation propertys:(nullable NSDictionary *)propertys;

/**
 处理控制器的Pop
 */
- (void)base_handlePopWithController:(__kindof DDQBaseViewController *)controller toController:(nullable __kindof DDQBaseViewController *)tController animated:(BOOL)animated;
- (void)base_handlePopController;

/**
 ImagePicker选择前的AlertController
 */
- (void)base_presentImagePickerAlertControllerWithDelegate:(nullable id<DDQAlertControllerDelegate>)delegate;

/**
 处理蒙版视图的弹出和隐藏
 
 @param view 待处理的视图
 @param type 处理的类型
 @param com 动画完成的回调。回调为空时移除视图
 */
- (void)base_handleFullScreenView:(__kindof UIView *)view animationStyle:(DDQBaseHandleAnimationType)type completion:(DDQBaseAnimationCompletion)com;

/**
 系统AlertController的输入内容
 */
- (void)base_handleSystemAlertControllerTitle:(nullable NSString *)title message:(nullable NSString *)message inputContent:(void(^)(NSString *_Nullable input))content completed:(void(^_Nullable)(void))completed DDQ_DEPRECATED_V(2_0, 2_0, "Please Use - base_handleSystemAlertControllerTitle:message:inputDelegate:inputCompleted");

/**
 快速创建header和footer
 注:回调的Page和base_requestPage一致
 */
- (void)base_setTableViewHeaderFooterWithHeaderCompleted:(DDQBaseHeaderFooterCompleted)hCompleted footerCompleted:(DDQBaseHeaderFooterCompleted)fCompleted;

@end

typedef void(^DDQAlertFieldInputCompleted)(NSString *input);
/**
 来自《聚源康》项目
 */
@interface DDQBaseViewController (DDQBaseViewControllerFromJYK)<UITextFieldDelegate>

/**
 观察UIAlertController的textField的输入。
 我还是推荐代理的这种方式。
 */
- (void)base_handleSystemAlertControllerTitle:(nullable NSString *)title message:(nullable NSString *)message inputDelegate:(nullable id<UITextFieldDelegate>)delegate inputCompleted:(DDQAlertFieldInputCompleted)completed;

/**
 简单的确定取消Alert
 */
- (void)base_presentAlertControllerWithTitle:(nullable NSString *)title message:(NSString *)message style:(DDQAlertControllerStyle)style cancel:(nullable void(^)(void))cancel sure:(nullable void(^)(void))sure;

@end

/**
 来自《车尚》项目
 */
@interface DDQBaseViewController (DDQBaseViewControllerFromCS)

/**
 保存数据
 */
@property (nonatomic, readonly) DDQUserInformationManager *base_infomationManager;

/**
 集中处理登录、注册、我的请求的数据
 
 @param data requestData
 */
- (void)base_handleUserInfomationWithData:(id)data;

/**
 处理字符串，如果它非法的话
 
 @param string 待处理的字符串
 */
- (NSString *)base_handleRequestStringIfIllegal:(id)string;


/**
 处理请求的数据，如果它非法的话
 
 @param data 待处理的请求数据
 @param tC 转换的目标类
 */
- (id)base_handleRequestDataIfLegal:(id)data targetClass:(Class)tC;

/**
 当本地保存的数据发生改变后
 
 @param manager 单例
 */
- (void)base_handleWhenInformationKeyValueChange:(DDQUserInformationManager *)manager;

/**
 将html字符串转成字符串
 
 @param html html字符串
 @return 字符串
 */
- (NSString *)base_handleHTMLString:(NSString *)html;

@end

typedef NS_ENUM(NSUInteger, DDQBaseNavigationBarStyle) {
    
    DDQBaseNavigationBarStyleWhite,                          //白底
    DDQBaseNavigationBarStyleWhiteAndBack,                   //白底，带返回键，有shadowimage
    DDQBaseNavigationBarStyleWhiteAndBackHiddenShadow,       //白底，带返回键，没有shadowimage
    DDQBaseNavigationBarStyleClearAndWhitBack,               //透明底带白色返回键
    DDQBaseNavigationBarStyleHiddenBar,                      //隐藏NavigationBar
    DDQBaseNavigationBarStyleMemberCenterEngross,            //会员中心独占特效😆

};

static const NSUInteger DDQNavigationControllerIndexNotFound = -1;
/**
 本工程自定义API
 */
@interface DDQBaseViewController (DDQECarAPI)

/**
 设置NavigationBar的样式
 */
- (DDQBaseNavigationBarStyle)base_navigationBarStyle;

/**
 工程处理订单类
 */
@property (nonatomic, readonly) DDQProjectHandler *base_handler;

@property (nonatomic, assign, readonly) NSInteger base_type;


/** 背景色 */
- (UIColor *)base_defaultBackgroundColor;

/**
 当前自控制器显示的标题
 */
- (nullable NSString *)base_navigationTitle;

/**
 处理用户登录情况
 
 @param status 获得用户的登录状态
 */
- (void)base_handleUserLoginStatus:(DDQBaseHandleLoginStatus)status;

/**
 用户退出登录
 */
- (void)base_handleUserLogoutCompleted:(void(^)(void))completed;

/**
 统一处理发送验证码

 @param to 注册时发送验证码传YES，其他情况发送验证码传NO
 @param phone 注册手机号
 @param completed 发送完成
 */
- (void)base_handleSendMessageCodeToRegister:(BOOL)to phone:(NSString *)phone completed:(void (^)(int code))completed;
- (void)base_handleSendMessageCodeToRegister:(BOOL)to otherParam:(nullable NSDictionary *)param phone:(NSString *)phone completed:(void (^)(int code))completed;
/**
 找到Navigation

 @param cClass 某个特定类在NavigationController中的索引
 @return 索引。没有这个类则返回DDQNavigationControllerIndexNotFound
 */
- (NSUInteger)base_handleNavigationControllerControllerContainClass:(Class)cClass;

/**
 处理不同的登录页之间的切换

 @param cClass 登录页的类型
 */
- (void)base_handleDifferentLoginTypeWithClass:(Class)cClass;

/**
 处理不同样式下bar的显示
 */
- (void)base_handleNavigationBarWithDifferentStyle;

@end

UIKIT_EXTERN DDQInputContentErrorDomain const DDQInputEmptyErrorDomain;
UIKIT_EXTERN DDQInputContentErrorDomain const DDQInputInvalidErrorDomain;

NS_ASSUME_NONNULL_END
