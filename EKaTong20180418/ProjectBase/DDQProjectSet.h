//
//  DDQProjectSet.h
//
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.


#ifndef DDQProjectSet_h
#define DDQProjectSet_h

//UM
#define DDQUMAppKey @"5ad842f3b27b0a7b3d00004e"

//WX
#define DDQWXAppID @"wx82477079751c5c92"
#define DDQWXPartnerID @"1503290251"
#define DDQWXAppSecret @"f3c664bb10c9cc9d38ce9605fe4313a1"
//这个是app端自己请求微信同意订单时需要的API秘钥
#define DDQWXKey @"eDongKePu20180508ChuangKeRongHui"

//QQ
#define DDQQQAppID @"1106853122"
#define DDQQQAppKey @"xWSKRaLejMEXY70l"

//AL
#define DDQALAppID @"2018042802602272"
#define DDQALPrivateKey @"MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC2Us2VTZ9AteQL3TWgDP/e2A7EHXWjoQcw/i4oXDdu5aBbGDyCUwQB6F47NcUK+JamsZgTQ9y3XJ810Afpv3xAaXKIkTfOP976zeOWvZ1s/JgY6yCJzAo+SgAz9jElv3GO5VCKEtlYZHjc6fINYIz/YraO790u/PQbDbf2oNBixl1YSgO920lpWladNnhjF46rhQWPEBpkaBi9rfou8lCLk4PD1FnjeI0a6yCbMDhFJ8M740Bk7TAEZBE6V9iFF5Ho0F+b9uyEHowBgl5CYAiMfEFedYexq71rpoD7i9o9nCViMsktK3AV6eRgz+dsnP769Max8AqoXlbfL561cuonAgMBAAECggEADhf0gFgRuWTWDfy5ine2x7kX2x0T3OQztBvR4ZjPSClD7ga/lqtoIeWecyFC7AgvTQ9pXAPg6eOlAvnjwrPknO4JxnjDQZQ6XlTQBPT/WE9mSnbSexRkrk/2GA4t2mckFhGv2hx+5JBPr3P+G/6cp5kv13i/NkSjcfvrfosL0La254t5z3/B/ZqiYDBDguXMS09Smml24i75VK6y5S4+H28bK6q1OlnqAu7LWO24JDnXgJ9eGEEjn4etj+7YXFDI7zKdWzCnKhGsr0R5GFz54V8QalqfbjOfDUZxfiJ0kym+2n5VsS7cBxL5LJ77Pz5VvcHF3Xx+b+uumteuTlno8QKBgQD9px5wBL9Xdhf0cDCClvCzBIHTG4bAaIr3ByehwpcEHj+k6WT8LS72Jxu3QtkW9P5GiMLyQqxjTMbKx4p7tM70itV41G1f2sMN0N63lG83Lk1nXw1jBTYLHWaXuulmKv3HEhJwJNUvi4hcOZxPCDoaND/KI+IJMSIWvGFWUOB8gwKBgQC4ArYR57jtIZ3zQ9T1VaLoIOrYNn1CWipe4A+3IM2JyljkrRAEA1fSVhtMQIk0atgki/g/MfUBpFiYonwXOLpaDt5FltK0CnB5/6ozuakmWMde7cTU5BgLzgXCafkh0wgvAIcFebR8Rhxj5BX9WHtNRhMZF8oX4abZOW4cbXRyjQKBgQDAo+SU9LYRCaplxbLB6zrA6uJiX1x20q7/r5pk2vFwejyh1XQRpYst/UOqagWPzt8y2HkeHo7oF44+wU8mZopq5On9i2/Jxc4vtvr+96eDhBHbOTBkjLeft2OMRrMuGeaFAu+n5gFWy6TzTfmteDUQY7AyqA/qJTubgtR2BpSHWwKBgQCWdrkUWQuQ850pbvzzA2xrLYd69stj90CQRdzz3KHVGx2nF5ByB53HQ1uc9WR79SX6dG2wlxQFnLJJVQvtHRjcTS4ZbyOpzqN8Tr+I/ja/QXb9O6Vog37aIEP7XhY2P06AyIifxI391IKgd8A3YiOo4zT4nshE0OJS27AbFLFUfQKBgQCHNqncpvPgnImIE0h2LE+sSuQOdRU2YeMQp22DGCQaItiuYqidEaagzAwiyFrpenKpzX/Pg6BJjXNWjZq0lM91drt304y9bazfNvEzRFfa7R0RVKq/byLoJbg7PMz8805jLFNK5Rd4AwqkS2OO4qNG2oYOcP/8xM9bYpRgNO4vUQ=="
#define DDQALPartnerID @"2088031971548840"
#define DDQALSellerID @"bjckrh@yeah.net"
#define DDQALSchemes @"EKaTong20180418"

//System Single
#define DDQNotificationCenter [NSNotificationCenter defaultCenter]
#define DDQUserDefault [NSUserDefaults standardUserDefaults]

//Error Tip
#define DDQEmptyError(...) [NSString stringWithFormat:@"%@不能为空", __VA_ARGS__]
#define DDQInputError(...) [NSString stringWithFormat:@"%@输入有误", __VA_ARGS__]
#define DDQAccountEmpty DDQEmptyError(@"手机号")
#define DDQAccountError DDQInputError(@"手机号")

#define DDQMessageCodeEmpty DDQEmptyError(@"验证码")
#define DDQMessageCodeError DDQInputError(@"验证码")

#define DDQPasswordEmpty DDQEmptyError(@"密码")

#define DDQSurePasswordEmpty DDQEmptyError(@"新密码")

#define DDQPointEmpty DDQEmptyError(@"积分")
#define DDQPointError DDQInputError(@"积分")

#define DDQPayPasswordEmpty DDQEmptyError(@"支付密码")
#define DDQPayPasswordError @"密码需是6位的数字组合"
#define DDQPayPasswordCheckError @"两次密码输入不一致"

#define DDQPasswordCheckError @"两次密码输入不一致"

#define DDQPayPasswordFromatError @"支付密码需为6位数组组合！"

//Notification Name
#define DDQLoginSuccessNotification @"login.success"
#define DDQLogoutSuccessNotification @"logout.success"


#endif /* DDQProjectSet_h */
