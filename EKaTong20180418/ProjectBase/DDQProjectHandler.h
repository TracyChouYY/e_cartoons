//
//  DDQProjectHandler.h
//
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NSString *DDQHandlerResultKey;
typedef void(^_Nullable DDQHandlerCompleted)(_Nullable id object);

typedef NS_ENUM(NSUInteger, DDQProjectHandlerOperationType) {
    
    DDQProjectHandlerOperationTypeInsert,
    DDQProjectHandlerOperationTypeDelete,
};

typedef NS_ENUM(NSUInteger, DDQProjectHandlerPathType) {

    DDQProjectHandlerPathTypeOrder,
    DDQProjectHandlerPathTypeProduct,
};

/**
 工程基础处理类
 PS:我主要会用在订单页那块，以求集中处理数据。
 */
@interface DDQProjectHandler : NSObject<NSCopying>

/**
 单例初始化方法
 */
+ (instancetype)defaultHandler;

/**
 本质就是你需要传递什么值。我通过观察这个属性进行回调。
 */
@property (nonatomic, strong) NSDictionary<DDQHandlerResultKey, id> *handler_dataMap;

/**
 Map发生改变的回调
 */
- (void)handler_responseWhenCompleted:(DDQHandlerCompleted)completed;
- (void)handler_responseTarget:(nullable id)target selector:(nullable SEL)sel;

/**
 释放对象
 */
- (void)handler_releaseObject;

/**
 保存的最大的对象个数
 */
@property (nonatomic, assign) NSInteger handler_dataMaxCount;//default 10

/**
 订单搜索内容保存路径
 */
@property (nonatomic, copy, readonly) NSString *handler_orderSearchPath;

/**
 商品搜索内容保存路径
 */
@property (nonatomic, copy, readonly) NSString *handler_productSearchPath;

/**
 获得保存的数据

 @param pType 路径类型
 @return 保存的历史数据数组
 */
- (NSArray *)handler_decodeSearchDataWithPathType:(DDQProjectHandlerPathType)pType;

/**
 保存数据

 @param text 保存的内容
 @param pType 路径类型
 @param oType 操作类型
 */
- (void)handler_encodeSearchDataWithText:(NSString *)text pathType:(DDQProjectHandlerPathType)pType operationType:(DDQProjectHandlerOperationType)oType;

/**
 删除缓存的数据

 @param pType 路径类型
 */
- (void)handler_deleteCacheDataWithPathType:(DDQProjectHandlerPathType)pType;

@end

//你也可以在其他.h中定义自己的键名
FOUNDATION_EXTERN DDQHandlerResultKey const DDQHandlerResultClassId;
FOUNDATION_EXTERN DDQHandlerResultKey const DDQHandlerResultModel;

NS_ASSUME_NONNULL_END

