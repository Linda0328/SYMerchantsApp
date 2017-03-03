//
//  SYShareVersionInfo.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/25.
//
//

#import <Foundation/Foundation.h>

@interface SYShareVersionInfo : NSObject
@property (nonatomic,copy)NSString *remoteUrl;
@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,copy)NSString *regId;
@property (nonatomic,copy)NSString *systemType;
//获取app本地版本信息
@property (nonatomic,copy)NSString *appVersion;
@property (nonatomic,copy)NSString *appVersionName;

@property (nonatomic,copy)NSString *token;
@property (nonatomic,assign)BOOL needUpdate;
@property (nonatomic,assign)BOOL needPush;


//verison 接口获取数据
@property (nonatomic,copy)NSString *pageVersion;
@property (nonatomic,copy)NSString *lastAppVersion;
@property (nonatomic,copy)NSString *lastVersionName;

@property (nonatomic,copy)NSString *listenPluginID;

@property (nonatomic,copy)NSString *scanResult;
+ (instancetype)sharedVersion;
@end
