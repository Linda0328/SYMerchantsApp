//
//  SYAppCachePlugin.m
//  SYMerchantsApp
//
//  Created by 文清 on 2016/12/14.
//
//

#import "SYAppCachePlugin.h"

@implementation SYAppCachePlugin
-(void)cleanCache:(CDVInvokedUrlCommand *)command{
    //清楚cookies
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [storage cookies]) {
//        [storage deleteCookie:cookie];
//    }
    //清除UIWebView的缓存
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
//    [cache setDiskCapacity:0];
//    [cache setMemoryCapacity:0];
    [self.commandDelegate runInBackground:^{
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"clean"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        
    }];
 
}
@end
