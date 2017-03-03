//
//  SYAppCachePlugin.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/12/14.
//
//

#import <Cordova/CDV.h>

@interface SYAppCachePlugin : CDVPlugin
-(void)cleanCache:(CDVInvokedUrlCommand *)command;
@end
