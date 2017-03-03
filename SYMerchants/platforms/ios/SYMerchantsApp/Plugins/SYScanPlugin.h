//
//  SYScanPlugin.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/26.
//
//

#import <Cordova/CDV.h>

@interface SYScanPlugin : CDVPlugin
-(void)getCode:(CDVInvokedUrlCommand *)command;
@end
