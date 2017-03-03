//
//  SYMerchantsNetworkClient.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/20.
//
//

#import "SYMerchantsNetworkClient.h"
//#import "Bee_FileCache.h"


static NSString * const SYSGMerchantsTestBaseURL = @"http://test.shengyuan.cn:7086"; //测试服务器
static NSString * const SYSGMerchantsFormalBaseURL = @"http://shengyuan.cn:7086"; //正式服务器
@implementation SYMerchantsNetworkClient

+ (instancetype)sharedClient{
    static SYMerchantsNetworkClient *shareClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *baseURL = nil;
//        if (DEBUG) {
//            baseURL = SYSGMerchantsTestBaseURL;
//        }else{
            baseURL = SYSGMerchantsFormalBaseURL;
//        }
        shareClient = [[self alloc]initWithBaseURL:[NSURL URLWithString:baseURL]];
        shareClient.requestSerializer.timeoutInterval = 60;
        shareClient.operationQueue.maxConcurrentOperationCount = 10;
        shareClient.responseSerializer.acceptableContentTypes = [shareClient.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html,text/json"];
//        shareClient.cache = [[BeeFileCache alloc]init];
    });
    return shareClient;
}

@end
