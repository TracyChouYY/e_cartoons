//
//  DDQUserInfomationManager.m
//  CheShang20180228
//
//  Created by 我叫咚咚枪 on 2018/3/28.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQUserInformationManager.h"

#import <MJExtension/MJExtension.h>

@interface DDQUserInformationManager () {
    
    id _userDefaultObserver;
    
}

@property (nonatomic, strong) NSUserDefaults *information_defaults;
@property (nonatomic, strong) NSMutableArray<NSString *> *information_keys;

@end

@implementation DDQUserInformationManager

@synthesize uid = _uid;
@synthesize uname = _uname;
@synthesize phone = _phone;
@synthesize state = _state;
@synthesize image = _image;
@synthesize zfpwd = _zfpwd;
@synthesize yhdj = _yhdj;
@synthesize base = _base;
@synthesize age = _age;
@synthesize zy = _zy;
@synthesize rz = _rz;
@synthesize sex = _sex;
@synthesize ljxs = _ljxs;
@synthesize jrxs = _jrxs;
@synthesize wdcf = _wdcf;
@synthesize bid = _bid;
@synthesize bd = _bd;

+ (instancetype)defaultManager {
    
    static DDQUserInformationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[DDQUserInformationManager alloc] init];

    });
    return manager;
    
}

- (instancetype)init {
    
    self = [super init];
    
    self.information_defaults = [NSUserDefaults standardUserDefaults];
    self.information_keys = [NSMutableArray array];
    return self;
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:_userDefaultObserver];
    
}

- (void)setImage:(NSString *)image {
    
    _image = image;
    
    [self information_handleRequestData:image targetClass:[NSString class] saveKey:@"image"];

}

- (NSString *)image {
    
    if (!_image) {
        
        _image = [self.information_defaults valueForKey:@"image"];
        
    }
    return _image;
    
}


- (void)setUid:(NSString *)uid {
    
    _uid = uid;
    
    [self information_handleRequestData:uid targetClass:[NSString class] saveKey:@"uid"];

}

- (NSString *)uid {
    
    if (!_uid) {
        
        _uid = [self.information_defaults valueForKey:@"uid"];
        
    }
    return _uid;
    
}

- (void)setPhone:(NSString *)phone {
    
    _phone = phone;
    
    [self information_handleRequestData:phone targetClass:[NSString class] saveKey:@"phone"];

}

- (NSString *)phone {
    
    if (!_phone) {
        
        _phone = [self.information_defaults valueForKey:@"phone"];
        
    }
    return _phone;
    
}

- (void)setUname:(NSString *)uname {
    
    _uname = uname;
    
    [self information_handleRequestData:uname targetClass:[NSString class] saveKey:@"uname"];

}

- (NSString *)uname {
    
    if (!_uname) {
        
        _uname = [self.information_defaults valueForKey:@"uname"];
        
    }
    return _uname;
    
}

- (void)setState:(NSString *)state {
    
    _state = state;
    
    [self information_handleRequestData:state targetClass:[NSString class] saveKey:@"state"];

}

- (NSString *)state {
    
    if (!_state) {
        
        _state = [self.information_defaults valueForKey:@"state"];
        
    }
    return _state;
    
}

- (void)setZfpwd:(NSString *)zfpwd {
    
    _zfpwd = zfpwd;
    
    [self information_handleRequestData:zfpwd targetClass:[NSString class] saveKey:@"zfpwd"];
    
}

- (NSString *)zfpwd {
    
    if (!_zfpwd) {
        
        _zfpwd = [self.information_defaults valueForKey:@"zfpwd"];
        
    }
    return _zfpwd;
    
}

- (void)setYhdj:(NSString *)yhdj {
    
    _yhdj = yhdj;
    
    [self information_handleRequestData:yhdj targetClass:[NSString class] saveKey:@"yhdj"];
    
}

- (NSString *)yhdj {
    
    if (!_yhdj) {
        
        _yhdj = [self.information_defaults valueForKey:@"yhdj"];
        
    }
    return _yhdj;
    
}

- (void)setBase:(NSString *)base {
    
    _base = base;
    
    [self information_handleRequestData:base targetClass:[NSString class] saveKey:@"base"];
    
}

- (NSString *)base {
    
    if (!_base) {
        
        _base = [self.information_defaults valueForKey:@"base"];
        
    }
    return _base;
    
}

- (void)setRz:(NSString *)rz {
    
    _rz = rz;
    
    [self information_handleRequestData:rz targetClass:[NSString class] saveKey:@"rz"];
    
}

- (NSString *)rz {
    
    if (!_rz) {
        
        _rz = [self.information_defaults valueForKey:@"rz"];
        
    }
    return _rz;
    
}

- (void)setZy:(NSString *)zy {
    
    _zy = zy;
    
    [self information_handleRequestData:zy targetClass:[NSString class] saveKey:@"zy"];
    
}

- (NSString *)zy {
    
    if (!_zy) {
        
        _zy = [self.information_defaults valueForKey:@"zy"];
        
    }
    return _zy;
    
}

- (void)setAge:(NSString *)age {
    
    _age = age;
    
    [self information_handleRequestData:age targetClass:[NSString class] saveKey:@"age"];
    
}

- (NSString *)age {
    
    if (!_age) {
        
        _age = [self.information_defaults valueForKey:@"age"];
        
    }
    return _age;
    
}

- (void)setSex:(NSString *)sex {
    
    _sex = sex;
    
    [self information_handleRequestData:sex targetClass:[NSString class] saveKey:@"sex"];
    
}

- (NSString *)sex {
    
    if (!_sex) {
        
        _sex = [self.information_defaults valueForKey:@"sex"];
        
    }
    return _sex;
    
}

- (void)setLjxs:(NSString *)ljxs {
    
    _ljxs = ljxs;
    
    [self information_handleRequestData:ljxs targetClass:[NSString class] saveKey:@"ljxs"];
    
}

- (NSString *)ljxs {
    
    if (!_ljxs) {
        
        _ljxs = [self.information_defaults valueForKey:@"ljxs"];
        
    }
    return _ljxs;
    
}

- (void)setJrxs:(NSString *)jrxs {
    
    _jrxs = jrxs;
    
    [self information_handleRequestData:jrxs targetClass:[NSString class] saveKey:@"jrxs"];
    
}

- (NSString *)jrxs {
    
    if (!_jrxs) {
        
        _jrxs = [self.information_defaults valueForKey:@"jrxs"];
        
    }
    return _jrxs;
    
}

- (void)setWdcf:(NSString *)wdcf {
    
    _wdcf = wdcf;
    
    [self information_handleRequestData:wdcf targetClass:[NSString class] saveKey:@"wdcf"];
    
}

- (NSString *)wdcf {
    
    if (!_wdcf) {
        
        _wdcf = [self.information_defaults valueForKey:@"wdcf"];
        
    }
    return _wdcf;
    
}

- (void)setBid:(NSString *)bid {
    
    _bid = bid;
    
    [self information_handleRequestData:bid targetClass:[NSString class] saveKey:@"bid"];
    
}

- (NSString *)bid {
    
    if (!_bid) {
        
        _bid = [self.information_defaults valueForKey:@"bid"];
        
    }
    return _bid;
    
}

- (void)setBd:(NSString *)bd {
    
    _bd = bd;
    
    [self information_handleRequestData:bd targetClass:[NSString class] saveKey:@"bd"];
    
}

- (NSString *)bd {
    
    if (!_bd) {
        
        _bd = [self.information_defaults valueForKey:@"bd"];
        
    }
    return _bd;
    
}

#pragma mark - Custom API
- (NSArray<NSString *> *)information_changeKeys {
    
    return self.information_keys.copy;
    
}

- (NSArray *)information_allKeys {
    
    unsigned int listCount = 0;
    
    objc_property_t *propertys = class_copyPropertyList([self class], &listCount);
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:listCount];
    for (int index = 0; index < listCount; index++) {
        
        objc_property_t property = propertys[index];
        NSString *propertyName = [[NSString alloc] initWithUTF8String:property_getName(property)];
        [keys addObject:propertyName];
        
    }
    free(propertys);

    return keys.copy;
    
}

/**
 处理数据不为null, 不为空，不为CFNumber
 */
- (id)infomation_processDataIfLegal:(id)data targetClass:(Class)class {
    
    id handleData = data;
    if ([data isEqual:[NSNull null]]) {
        
        handleData = [[class alloc] init];
        
    }
    
    if (!data) {
        
        handleData = [[class alloc] init];
        
    }
    
    if ([NSStringFromClass([data class]) isEqualToString:@"__NSCFNumber"]) {
        
        handleData = [data description];
        
    }
    return handleData;
    
}

- (void)information_registerPropertyObserverChange:(DDQInformationPropertyObserver)observer {
    
    _userDefaultObserver = [[NSNotificationCenter defaultCenter] addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        if (observer) {
            
            observer(self);
            
        }
    }];
}

- (void)information_invaildPropertyObserver {

    [self.information_keys removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:_userDefaultObserver];
    
}

/**
 防止重复存储相同数据

 @param data 请求到的数据
 @param target 属性的类
 @param key 保存的属性名
 */
- (void)information_handleRequestData:(id)data targetClass:(Class)target saveKey:(NSString *)key {
    
    id saveObject = [self.information_defaults objectForKey:key];
    id handleObject = [self infomation_processDataIfLegal:data targetClass:target];
    if (![saveObject isEqual:handleObject]) {//请求的数据和处理的数据不一致就更新
        
        if (![self.information_keys containsObject:key]) {
            
            [self.information_keys addObject:key];

        }
        [self.information_defaults setObject:handleObject forKey:key];

    }
}

- (void)information_clearSaveInformationCompleted:(void (^)(void))completed {
    
    NSDictionary *informationKeys = [self mj_keyValues];
    for (NSString *key in informationKeys.allKeys) {
        
        [self.information_defaults removeObjectForKey:key];

    }
    
    if (completed) {
        
        completed();
        
    }
}

+ (NSArray *)mj_ignoredPropertyNames {
    
    return @[@"information_defaults", @"information_changeKeys", @"information_keys"];
    
}

@end
