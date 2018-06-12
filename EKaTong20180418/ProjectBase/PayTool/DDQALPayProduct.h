//
//  DDQALPayProduct.h
//  WeiDuoShiGuang20171106
//
//  Created by 我叫咚咚枪 on 2017/12/30.
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDQALPayProduct : NSObject

// NOTE: (非必填项)商品描述
@property (nonatomic, copy) NSString *product_body;

// NOTE: 商品的标题/交易标题/订单标题/订单关键字等。
@property (nonatomic, copy) NSString *product_subject;

// NOTE: 商户网站唯一订单号
@property (nonatomic, copy) NSString *product_tradeNo;

// NOTE: 订单总金额，单位为元，精确到小数点后两位，取值范围[0.01,100000000]
@property (nonatomic, copy) NSString *product_totalAmount;

// NOTE: 收款支付宝用户ID。 如果该值为空，则默认为商户签约账号对应的支付宝用户ID (如 2088102147948060)
@property (nonatomic, copy) NSString *product_sellerID;

// NOTE: 该笔订单允许的最晚付款时间，逾期将关闭交易。
//       取值范围：1m～15d m-分钟，h-小时，d-天，1c-当天(1c-当天的情况下，无论交易何时创建，都在0点关闭)
//       该参数数值不接受小数点， 如1.5h，可转换为90m。
@property (nonatomic, copy) NSString *product_timeout;

// NOTE: 销售产品码，商家和支付宝签约的产品码 (如 QUICK_MSECURITY_PAY)
@property (nonatomic, copy) NSString *product_code;

@end

@interface DDQALPayAuthority : NSObject

// NOTE: 支付宝分配给开发者的应用ID(如2014072300007148)
@property (nonatomic, copy) NSString *al_appID;

// NOTE: 支付接口名称
@property (nonatomic, copy) NSString *al_method;

// NOTE: 参数编码格式，如utf-8,gbk,gb2312等
@property (nonatomic, copy) NSString *al_charset;

// NOTE: 请求发送的时间，格式"yyyy-MM-dd HH:mm:ss"
@property (nonatomic, copy) NSString *al_timestamp;

// NOTE: 请求调用的接口版本，固定为：1.0
@property (nonatomic, copy) NSString *al_version;

// NOTE: 签名类型
@property (nonatomic, copy) NSString *al_signType;

// NOTE: (非必填项)支付宝服务器主动通知商户服务器里指定的页面http路径
@property (nonatomic, copy) NSString *al_notifyUrl;

// NOTE: 商品详情
@property (nonatomic, strong) DDQALPayProduct *al_product;

/**
 支付签名
 */
- (NSString *)al_orderInfoEncode:(BOOL)encode;

@end

NS_ASSUME_NONNULL_END
