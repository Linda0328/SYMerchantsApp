//
//  SYVersionPlugin.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/19.
//
//

#import "SYVersionPlugin.h"
#import "SYGlobleConst.h"
#import "SYVersionModel.h"
#import "SYShareVersionInfo.h"
#import "MainViewController.h"
#import "SYNavgationViewController.h"
static NSString *const getInfoMethod = @"getInfo";
static NSString *const setTokenMethod = @"setToken";
static NSString *const setNeedPushMethod = @"setNeedPush";
@implementation SYVersionPlugin
-(void)getSystemVersionByParam:(CDVInvokedUrlCommand*)command{
          //    这是回调JS方法
        CDVPluginResult *result = nil;
        NSString *comeback = [command.arguments firstObject];
        NSString *methodName = command.methodName;
        if (comeback) {
            if ([methodName isEqualToString:getInfoMethod]) {
                               
            }
            //成功回调 CDVCommandStatus_OK
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:comeback];
        }else{
            //失败回调 CDVCommandStatus_ERROR
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
        }
            //通过代理将数据传递给JS
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

}


-(void)getSystemVersionByParamThread:(CDVInvokedUrlCommand*)command{
    NSString *comeback = [command.arguments firstObject];
//    if (!comeback) {
//        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
//        //通过代理将数据传递给JS
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        return;
//    }
    NSString *methodName = command.methodName;
    [self.commandDelegate runInBackground:^{
        
        CDVPluginResult *result = nil;
        
        if ([methodName isEqualToString:getInfoMethod]) {
//            NSDictionary *dic = [self GetInfo];
//            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dic];
        }else if([methodName isEqualToString:setTokenMethod]){
            //成功回调 CDVCommandStatus_OK
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:comeback];
        }else if ([methodName isEqualToString:setNeedPushMethod]){
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:comeback];
        }
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
    
}

-(void)getInfo:(CDVInvokedUrlCommand*)command{
    
    NSDictionary *verDic = [self getVersionInfo];
    [self.commandDelegate runInBackground:^{
        
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:verDic];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];

}
-(NSMutableDictionary*)getVersionInfo{
    
    SYShareVersionInfo *shareVerInfo = [SYShareVersionInfo sharedVersion];
    
    NSMutableDictionary *verDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:shareVerInfo.pageVersion,@"pageVersion",shareVerInfo.appVersion,@"appVersion",shareVerInfo.appVersionName,@"appVersionName",nil];
    
    [verDic setObject:shareVerInfo.remoteUrl forKey:@"remoteUrl"];
    [verDic setObject:shareVerInfo.imageUrl forKey:@"imageUrl"];
    [verDic setObject:[SYGlobleConst judgeNSString:shareVerInfo.token]?shareVerInfo.token:@"" forKey:@"token"];
    [verDic setObject:shareVerInfo.lastAppVersion forKey:@"lastAppVersion"];
    [verDic setObject:shareVerInfo.lastVersionName forKey:@"lastVersionName"];
    [verDic setObject:@(shareVerInfo.needUpdate) forKey:@"needUpdate"];
    [verDic setObject:@(shareVerInfo.needPush) forKey:@"needPush"];
    [verDic setObject:shareVerInfo.systemType forKey:@"systemType"];
    [verDic setObject:shareVerInfo.regId forKey:@"regId"];
    return verDic;
}
-(void)setToken:(CDVInvokedUrlCommand*)command{
    NSString *comeback = [command.arguments firstObject];
    if (![SYGlobleConst judgeNSString:comeback]) {
        return;
    }
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:comeback forKey:loadToken];
    [def synchronize];
    [SYShareVersionInfo sharedVersion].token = comeback;
    MainViewController *main = (MainViewController*)self.viewController;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:loadAppNotify object:main];
    [self.commandDelegate runInBackground:^{
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:comeback];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}
-(void)setNeedPush:(CDVInvokedUrlCommand*)command{
    NSString *comeback = [command.arguments firstObject];
    [self.commandDelegate runInBackground:^{
        [SYShareVersionInfo sharedVersion].needPush = [comeback boolValue];
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:comeback];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}
@end
