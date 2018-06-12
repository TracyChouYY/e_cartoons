//
//  DDQProjectHandler.m
//
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.

#import "DDQProjectHandler.h"

@interface DDQProjectHandler ()

@property (nonatomic, copy) DDQHandlerCompleted completed;
@property (nonatomic, strong) id target;
@property (nonatomic) SEL sel;
@property (nonatomic, strong) NSMutableArray *container;

@end

@implementation DDQProjectHandler

DDQHandlerResultKey const DDQHandlerResultClassId = @"Handler.ClassId";
DDQHandlerResultKey const DDQHandlerResultModel = @"Handler.Model";

static DDQProjectHandler *_handler = nil;

- (id)copyWithZone:(NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _handler = [[DDQProjectHandler allocWithZone:zone] init];
    });
    return _handler;
}

+ (instancetype)defaultHandler {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _handler = [[DDQProjectHandler alloc] init];
    });
    return _handler;
}

- (instancetype)init {
    
    self = [super init];
    if (!self) return nil;
    
    self.handler_dataMaxCount = 10;
    return self;
}

- (void)dealloc {
    
    [self handler_releaseObject];
}

- (void)setHandler_dataMap:(NSDictionary<DDQHandlerResultKey,id> *)handler_dataMap {
    
    _handler_dataMap = handler_dataMap;
    if (self.completed) {
        self.completed(_handler_dataMap);
    }
    
    if (self.target && [self.target respondsToSelector:self.sel]) {
        [self.target performSelectorOnMainThread:self.sel withObject:_handler_dataMap waitUntilDone:NO];
    }
}

- (NSMutableArray *)container {

    if (!_container) {
        _container = [NSMutableArray array];
    }
    return _container;
}

- (void)handler_responseWhenCompleted:(DDQHandlerCompleted)completed {
    if (completed) self.completed = completed;
}

- (void)handler_responseTarget:(id)target selector:(SEL)sel {
    
    if (target) {
        self.target = target;
    }
    
    if (sel) {
        self.sel = sel;
    }
}

- (void)handler_releaseObject {
    
    self.target = nil;
    self.sel = nil;
    self.completed = nil;
    [self.container removeAllObjects];
    self.container = nil;
}

#pragma mark - File Handler
- (NSArray *)handler_decodeSearchDataWithPathType:(DDQProjectHandlerPathType)pType {
    
    NSData *data = [NSData dataWithContentsOfFile:[self handler_getSavePathWithType:pType]];
    NSError *error = nil;
    NSArray *dataArray = nil;
    if (data) {
        dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    }
    
    if (!dataArray) {
        dataArray = [NSArray array];
    }
    return dataArray;
}

- (void)handler_encodeSearchDataWithText:(NSString *)text pathType:(DDQProjectHandlerPathType)pType operationType:(DDQProjectHandlerOperationType)oType {
    
    NSMutableArray *dataArray = [self handler_decodeSearchDataWithPathType:pType].mutableCopy;
    if (!dataArray) dataArray = [NSMutableArray arrayWithCapacity:self.handler_dataMaxCount + 1];
    
    if ([dataArray containsObject:text] && oType == DDQProjectHandlerOperationTypeDelete) {
        [dataArray removeObject:text];
    }
    
    if (oType == DDQProjectHandlerOperationTypeInsert) {
        [dataArray insertObject:text atIndex:0];
        if (dataArray.count > 10) {
            [dataArray removeLastObject];
        }
    }
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataArray options:NSJSONWritingPrettyPrinted error:&error];
    [data writeToFile:[self handler_getSavePathWithType:pType] atomically:YES];
}

- (void)handler_deleteCacheDataWithPathType:(DDQProjectHandlerPathType)pType {
    
    NSError *error = nil;
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:[self handler_getSavePathWithType:pType]]) {
        [manager removeItemAtPath:[self handler_getSavePathWithType:pType] error:&error];
    }
}

- (NSString *)handler_getSavePathWithType:(DDQProjectHandlerPathType)type {
    return (type == DDQProjectHandlerPathTypeOrder) ? self.handler_orderSearchPath : self.handler_productSearchPath;
}

- (NSString *)handler_orderSearchPath {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return [cachePath stringByAppendingPathComponent:@"/Order"];
}

- (NSString *)handler_productSearchPath {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return [cachePath stringByAppendingPathComponent:@"/Product"];
}

@end
