//
//  SYMerchantsNetworkClient.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/20.
//
//

#import "AFHTTPSessionManager.h"
//#import "Bee_CacheProtocol.h"
typedef void (^ActionPrepareBlock)();
typedef void (^ActionFinallyBlock)();
typedef void (^SucessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^ErrorBlock)(NSURLSessionDataTask *task, NSError *error);
typedef void (^MultipartData)(id <AFMultipartFormData> formData);

@interface SYMerchantsNetworkClient : AFHTTPSessionManager

//界面显示activity
@property (nonatomic,copy) ActionPrepareBlock enable;
//界面取消activity
@property (nonatomic,copy) ActionFinallyBlock disable;
//网络请求成功
@property (nonatomic, copy) SucessBlock sucess;
//网络请求失败
@property (nonatomic, copy) FailureBlock failure;
//网络连接错误
@property (nonatomic, copy) ErrorBlock networkError;

//@property (nonatomic, strong)id<BeeCacheProtocol>cache;


+ (instancetype)sharedClient;

@end
