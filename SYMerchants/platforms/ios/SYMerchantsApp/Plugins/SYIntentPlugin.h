//
//  SYIntentPlugin.h
//  SYMerchantsApp
//
//  Created by 文清 on 2016/10/26.
//
//

#import <Cordova/CDV.h>

@interface SYIntentPlugin : CDVPlugin
-(void)open:(CDVInvokedUrlCommand *)command;
-(void)start:(CDVInvokedUrlCommand *)command;
@end
