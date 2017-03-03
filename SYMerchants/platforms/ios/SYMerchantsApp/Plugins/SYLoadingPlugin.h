//
//  SYLoadingPlugin.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/26.
//
//

#import <Cordova/CDV.h>

@interface SYLoadingPlugin : CDVPlugin
-(void)show:(CDVInvokedUrlCommand *)command;
-(void)hide:(CDVInvokedUrlCommand *)command;
-(void)update:(CDVInvokedUrlCommand *)command;
@end
