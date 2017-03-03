//
//  SYResultPlugin.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/26.
//
//

#import <Cordova/CDV.h>

@interface SYResultPlugin : CDVPlugin
-(void)reload:(CDVInvokedUrlCommand *)command;
-(void)finish:(CDVInvokedUrlCommand *)command;
-(void)exec:(CDVInvokedUrlCommand *)command;
@end
